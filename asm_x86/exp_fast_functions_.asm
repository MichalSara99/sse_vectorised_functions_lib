include asm_x86_incs/exp_fast_functions.inc

extern exp:proc
							.code
;;		extern "C" bool exp_fast_sse_ps(float const* x, int n, float* out);
exp_fast_sse_ps				proc uses ebx,
										x_ptr:ptr real4,
										n_arg:dword,
										out_ptr:ptr real4		
							xor eax,eax

							mov ebx,x_ptr
							test ebx,0fh
							jnz done
							
							mov edx,out_ptr
							test edx,0fh
							jnz done

							mov ecx,n_arg
							cmp ecx,4
							jl too_short

							mov eax,ecx
							and ecx,0fffffffch
							sub eax,ecx
							shr ecx,2

				 @@:		movaps xmm0,xmmword ptr [ebx]			;; x = xmm0	(ps)	
							mulps xmm0,xmmword ptr [log2e_ps]		;; t = xmm0
							roundps xmm1,xmm0,0001b					;; e = xmm1	(ps)
							cvtps2dq xmm2,xmm1						;; i = xmm2 (int)
							subps xmm0,xmm1							;; f = xmm0

							movaps xmm1,xmmword ptr [c0_ps]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [c1_ps]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [c2_ps]			;; p = xmm1
							pslld xmm2,23
							paddd xmm2,xmm1
							movaps xmmword ptr [edx],xmm2				
							add ebx,16
							add edx,16
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx	
							mov eax,1
							jz done

							movaps xmm0,xmmword ptr [ebx]			;; x = xmm0	(ps)	
							mulps xmm0,xmmword ptr [log2e_ps]		;; t = xmm0
							roundps xmm1,xmm0,0001b					;; e = xmm1	(ps)
							cvtps2dq xmm2,xmm1						;; i = xmm2 (int)
							subps xmm0,xmm1							;; f = xmm0

							movaps xmm1,xmmword ptr [c0_ps]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [c1_ps]
							mulps xmm1,xmm0
							addps xmm1,xmmword ptr [c2_ps]			;; p = xmm1
							pslld xmm2,23
							paddd xmm2,xmm1

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
							je short three_left

			one_left:		movss real4 ptr [edx],xmm2
							jmp short done

			two_left:		insertps xmm0,xmm2,01000000b
							movss real4 ptr [edx],xmm2
							movss real4 ptr [edx + 4],xmm0
							jmp short done

			three_left:		insertps xmm0,xmm2,01000000b
							insertps xmm1,xmm2,10000000b
							movss real4 ptr [edx],xmm2
							movss real4 ptr [edx + 4],xmm0
							movss real4 ptr [edx + 8],xmm1

				done:		ret
exp_fast_sse_ps				endp

;;		extern "C" bool exp_fast_sse_pd(double const* x, int n, double* out);
exp_fast_sse_pd				proc uses ebx,
									x_ptr:ptr real8,
									n_arg:dword,
									out_ptr:ptr real8
							xor eax,eax

							mov ebx,x_ptr
							test ebx,0fh
							jnz done
							
							mov edx,out_ptr
							test edx,0fh
							jnz done

							mov ecx,n_arg
							cmp ecx,2
							jl too_short

							mov eax,ecx
							and ecx,0fffffffeh
							sub eax,ecx
							shr ecx,1

				 @@:		movapd xmm0,xmmword ptr [ebx]			;; x = xmm0		
							movapd xmm1,xmmword ptr [log2e_pd]
							mulpd xmm1,xmm0							;; a = xmm1
							movapd xmm2,xmm1						;; a = xmm2
							xorpd xmm7,xmm7
							cmpltpd xmm2, xmm7
							movapd xmm6,xmmword ptr [one_pd]
							andpd xmm2,xmm6							;; p = xmm2
							subpd xmm1,xmm2							;; a = xmm1
							cvttpd2dq xmm7, xmm1					;; k = xmm7
							cvtdq2pd xmm2, xmm7						;; p = xmm2

							movapd xmm3,xmmword ptr [c1_pd]
							movapd xmm4,xmmword ptr [c2_pd]
							movapd xmm6,xmm2

							mulpd xmm6,xmm3							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0
							movapd xmm6,xmm2

							mulpd xmm6,xmm4							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0

							movapd xmm3,xmmword ptr [m_ecoef_pd]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 16]
							movapd xmm6,xmm0
							mulpd xmm6,xmm3
							addpd xmm6,xmm4							;; a = xmm6

							movapd xmm3,xmmword ptr [m_ecoef_pd + 32]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 48]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 64]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 80]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							paddd xmm7,xmmword ptr [int_tentwothree]
							pslld xmm7,20
							pshufd xmm7, xmm7, 01110010b
							mulpd xmm6,xmm7

							movapd xmmword ptr [edx],xmm6
							
							add ebx,16
							add edx,16
							dec ecx
							jnz @B

							mov ecx,eax
				too_short:	or ecx,ecx	
							mov eax,1
							jz done

							movapd xmm0,xmmword ptr [ebx]			;; x = xmm0		
							movapd xmm1,xmmword ptr [log2e_pd]
							mulpd xmm1,xmm0							;; a = xmm1
							movapd xmm2,xmm1						;; a = xmm2
							xorpd xmm7,xmm7
							cmpltpd xmm2, xmm7
							movapd xmm6,xmmword ptr [one_pd]
							andpd xmm2,xmm6							;; p = xmm2
							subpd xmm1,xmm2							;; a = xmm1
							cvttpd2dq xmm7, xmm1					;; k = xmm7
							cvtdq2pd xmm2, xmm7						;; p = xmm2

							movapd xmm3,xmmword ptr [c1_pd]
							movapd xmm4,xmmword ptr [c2_pd]
							movapd xmm6,xmm2

							mulpd xmm6,xmm3							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0
							movapd xmm6,xmm2

							mulpd xmm6,xmm4							;; a = xmm6
							subpd xmm0,xmm6							;; x = xmm0

							movapd xmm3,xmmword ptr [m_ecoef_pd]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 16]
							movapd xmm6,xmm0
							mulpd xmm6,xmm3
							addpd xmm6,xmm4							;; a = xmm6

							movapd xmm3,xmmword ptr [m_ecoef_pd + 32]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 48]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							movapd xmm3,xmmword ptr [m_ecoef_pd + 64]
							movapd xmm4,xmmword ptr [m_ecoef_pd + 80]
							mulpd xmm6,xmm0
							addpd xmm6,xmm3
							mulpd xmm6,xmm0
							addpd xmm6,xmm4							;; a = xmm6	

							paddd xmm7,xmmword ptr [int_tentwothree]
							pslld xmm7,20
							pshufd xmm7, xmm7, 01110010b
							mulpd xmm6,xmm7

							movsd real8 ptr [edx],xmm6

				done:		ret
exp_fast_sse_pd				endp
							end
						