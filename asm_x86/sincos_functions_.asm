include asm_x86_incs/sincos_functions.inc
							.code
;;		extern "C" bool cos_sse_pd(double const* x, int n, double* out);

cos_sse_pd					proc uses ebx,
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

							xorpd xmm7,xmm7

					@@:		movapd xmm7,xmmword ptr [one_pd]
							movapd xmm1,xmmword ptr [ebx]
							movapd xmm3,xmm1
							divpd xmm3,xmmword ptr [two_pi_pd]
							roundpd xmm3,xmm3,0011b
							mulpd xmm3,xmmword ptr [two_pi_pd]
							subpd xmm1,xmm3
							andpd xmm1,xmmword ptr [absMask_pd]        
							movapd xmm2,xmm1						;; xmm2 = x
							mulpd xmm1,xmmword ptr [two_o_pi_pd]
							cvttpd2dq xmm3,xmm1
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; xmm3
							cvtdq2pd xmm4,xmm3						;; xmm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							cvtdq2pd xmm3,xmm3
							xorpd xmm3,xmmword ptr [minusMask_pd] 
							cvtpd2dq xmm3,xmm3
							por xmm3,xmmword ptr [int_one]
							cvtdq2pd xmm6,xmm3						;; xmm6 = 1,-1

							mulpd xmm4,xmmword ptr [pi_pd]
							subpd xmm4,xmm2
							movapd xmm1,xmm4

							mulpd xmm1,xmm1
							movapd xmm2,xmm1
							movapd xmm0,xmmword ptr [m_ccoeff_pd]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+16]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+32]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+48]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
						    mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+64]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
						    movapd xmm0,xmmword ptr [m_ccoeff_pd+80]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							
							mulpd xmm7,xmm6
							movapd xmmword ptr [edx],xmm7

							add ebx,16
							add edx,16
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx
							mov eax,1
							jz done

							movapd xmm7,xmmword ptr [one_pd]
							movapd xmm1,xmmword ptr [ebx]
							movapd xmm3,xmm1
							divpd xmm3,xmmword ptr [two_pi_pd]
							roundpd xmm3,xmm3,0011b
							mulpd xmm3,xmmword ptr [two_pi_pd]
							subpd xmm1,xmm3
							andpd xmm1,xmmword ptr [absMask_pd]        
							movapd xmm2,xmm1						;; xmm2 = x
							mulpd xmm1,xmmword ptr [two_o_pi_pd]
							cvttpd2dq xmm3,xmm1
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; xmm3
							cvtdq2pd xmm4,xmm3						;; xmm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							cvtdq2pd xmm3,xmm3
							xorpd xmm3,xmmword ptr [minusMask_pd] 
							cvtpd2dq xmm3,xmm3
							por xmm3,xmmword ptr [int_one]
							cvtdq2pd xmm6,xmm3						;; xmm6 = 1,-1

							mulpd xmm4,xmmword ptr [pi_pd]
							subpd xmm4,xmm2
							movapd xmm1,xmm4

							mulpd xmm1,xmm1
							movapd xmm2,xmm1
							movapd xmm0,xmmword ptr [m_ccoeff_pd]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+16]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+32]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+48]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
						    mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+64]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
						    movapd xmm0,xmmword ptr [m_ccoeff_pd+80]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							
							mulpd xmm7,xmm6
							movsd real8 ptr [edx],xmm7

				done:		ret
cos_sse_pd					endp

;;		extern "C" bool cos_sse_ps(float const* x, int n, float* out);

cos_sse_ps					proc uses ebx,
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

							xorps xmm7,xmm7

					@@:		movaps xmm7,xmmword ptr [one_ps]
							movaps xmm1,xmmword ptr [ebx]
							movaps xmm3,xmm1
							divps xmm3,xmmword ptr [two_pi_ps]
							roundps xmm3,xmm3,0011b
							mulps xmm3,xmmword ptr [two_pi_ps]
							subps xmm1,xmm3
							andps xmm1,xmmword ptr [absMask_ps]        
							movaps xmm2,xmm1						;; xmm2 = x
							mulps xmm1,xmmword ptr [two_o_pi_ps]
							cvttps2dq xmm3,xmm1
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; xmm3
							cvtdq2ps xmm4,xmm3						;; xmm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							cvtdq2ps xmm3,xmm3
							xorps xmm3,xmmword ptr [minusMask_ps] 
							cvtps2dq xmm3,xmm3
							por xmm3,xmmword ptr [int_one]
							cvtdq2ps xmm6,xmm3						;; xmm6 = 1,-1

							mulps xmm4,xmmword ptr [pi_ps]
							subps xmm4,xmm2
							movaps xmm1,xmm4

							mulps xmm1,xmm1
							movaps xmm2,xmm1
							movaps xmm0,xmmword ptr [m_ccoeff_ps]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+16]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+32]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+48]
							divps xmm1,xmm0
							addps xmm7,xmm1
						    mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+64]
							divps xmm1,xmm0
							addps xmm7,xmm1
							
							mulps xmm7,xmm6
							movaps xmmword ptr [edx],xmm7

							add ebx,16
							add edx,16
							dec ecx
							jnz @B

							mov ecx,eax
		too_short:			or ecx,ecx
							mov eax,1
							jz done

							movaps xmm7,xmmword ptr [one_ps]
							movaps xmm1,xmmword ptr [ebx]
							movaps xmm3,xmm1
							divps xmm3,xmmword ptr [two_pi_ps]
							roundps xmm3,xmm3,0011b
							mulps xmm3,xmmword ptr [two_pi_ps]
							subps xmm1,xmm3
							andps xmm1,xmmword ptr [absMask_ps]        
							movaps xmm2,xmm1						;; xmm2 = x
							mulps xmm1,xmmword ptr [two_o_pi_ps]
							cvttps2dq xmm3,xmm1
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; xmm3
							cvtdq2ps xmm4,xmm3						;; xmm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							cvtdq2ps xmm3,xmm3
							xorps xmm3,xmmword ptr [minusMask_ps] 
							cvtps2dq xmm3,xmm3
							por xmm3,xmmword ptr [int_one]
							cvtdq2ps xmm6,xmm3						;; xmm6 = 1,-1

							mulps xmm4,xmmword ptr [pi_ps]
							subps xmm4,xmm2
							movaps xmm1,xmm4

							mulps xmm1,xmm1
							movaps xmm2,xmm1
							movaps xmm0,xmmword ptr [m_ccoeff_ps]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+16]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+32]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+48]
							divps xmm1,xmm0
							addps xmm7,xmm1
						    mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+64]
							divps xmm1,xmm0
							addps xmm7,xmm1
							
							mulps xmm7,xmm6

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
							je short three_left

			one_left:		movss real4 ptr [edx],xmm7
							jmp short done
			two_left:		insertps xmm2,xmm7,01000000b
							movss real4 ptr [edx],xmm7
							movss real4 ptr [edx + 4],xmm2	
							jmp short done
			three_left:		insertps xmm2,xmm7,01000000b
							insertps xmm4,xmm7,10000000b
							movss real4 ptr [edx],xmm7
							movss real4 ptr [edx + 4],xmm2
							movss real4 ptr [edx + 8],xmm4

				done:		ret
cos_sse_ps					endp

;;		extern "C" bool sin_sse_pd(double const* x, int n, double* out);
sin_sse_pd					proc uses ebx,
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
							
							xorpd xmm7,xmm7

					@@:		movapd xmm7,xmmword ptr [one_pd]
							movapd xmm1,xmmword ptr [ebx]
							movapd xmm5,xmmword ptr [half_pi_pd]
							subpd xmm5,xmm1
							movapd xmm3,xmm5
							divpd xmm3,xmmword ptr [two_pi_pd]
							roundpd xmm3,xmm3,0011b
							mulpd xmm3,xmmword ptr [two_pi_pd]
							subpd xmm5,xmm3
							andpd xmm5,xmmword ptr [absMask_pd]        
							movapd xmm2,xmm5						;; xmm2 = x
							mulpd xmm5,xmmword ptr [two_o_pi_pd]
							cvttpd2dq xmm3,xmm5
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; xmm3
							cvtdq2pd xmm4,xmm3						;; xmm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							cvtdq2pd xmm3,xmm3
							xorpd xmm3,xmmword ptr [minusMask_pd] 
							cvtpd2dq xmm3,xmm3
							por xmm3,xmmword ptr [int_one]
							cvtdq2pd xmm6,xmm3						;; xmm6 = 1,-1

							mulpd xmm4,xmmword ptr [pi_pd]
							subpd xmm4,xmm2
							movapd xmm1,xmm4

							mulpd xmm1,xmm1
							movapd xmm2,xmm1
							movapd xmm0,xmmword ptr [m_ccoeff_pd]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+16]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+32]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+48]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
						    mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+64]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
						    movapd xmm0,xmmword ptr [m_ccoeff_pd+80]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							
							mulpd xmm7,xmm6
							movapd xmmword ptr [edx],xmm7

							add ebx,16
							add edx,16
							dec ecx
							jnz @B

							mov ecx,eax
		too_short:			or ecx,ecx
							mov eax,1
							jz done

							movapd xmm7,xmmword ptr [one_pd]
							movapd xmm1,xmmword ptr [ebx]
							movapd xmm5,xmmword ptr [half_pi_pd]
							subpd xmm5,xmm1
							movapd xmm3,xmm5
							divpd xmm3,xmmword ptr [two_pi_pd]
							roundpd xmm3,xmm3,0011b
							mulpd xmm3,xmmword ptr [two_pi_pd]
							subpd xmm5,xmm3
							andpd xmm5,xmmword ptr [absMask_pd]        
							movapd xmm2,xmm5						;; xmm2 = x
							mulpd xmm5,xmmword ptr [two_o_pi_pd]
							cvttpd2dq xmm3,xmm5
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; xmm3
							cvtdq2pd xmm4,xmm3						;; xmm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							cvtdq2pd xmm3,xmm3
							xorpd xmm3,xmmword ptr [minusMask_pd] 
							cvtpd2dq xmm3,xmm3
							por xmm3,xmmword ptr [int_one]
							cvtdq2pd xmm6,xmm3						;; xmm6 = 1,-1

							mulpd xmm4,xmmword ptr [pi_pd]
							subpd xmm4,xmm2
							movapd xmm1,xmm4

							mulpd xmm1,xmm1
							movapd xmm2,xmm1
							movapd xmm0,xmmword ptr [m_ccoeff_pd]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+16]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+32]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+48]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
						    mulpd xmm1,xmm2
							movapd xmm0,xmmword ptr [m_ccoeff_pd+64]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							mulpd xmm1,xmm2
						    movapd xmm0,xmmword ptr [m_ccoeff_pd+80]
							divpd xmm1,xmm0
							addpd xmm7,xmm1
							
							mulpd xmm7,xmm6
							movsd real8 ptr [edx],xmm7

				done:		ret
sin_sse_pd					endp

;;		extern "C" bool sin_sse_ps(float const* x, int n, float* out);
sin_sse_ps					proc uses ebx,
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
							
							xorpd xmm7,xmm7

					@@:		movaps xmm7,xmmword ptr [one_ps]
							movaps xmm1,xmmword ptr [ebx]
							movaps xmm5,xmmword ptr [half_pi_ps]
							subps xmm5,xmm1
							movaps xmm3,xmm5
							divps xmm3,xmmword ptr [two_pi_ps]
							roundps xmm3,xmm3,0011b
							mulps xmm3,xmmword ptr [two_pi_ps]
							subps xmm5,xmm3
							andps xmm5,xmmword ptr [absMask_ps]        
							movaps xmm2,xmm5						;; xmm2 = x
							mulps xmm5,xmmword ptr [two_o_pi_ps]
							cvttps2dq xmm3,xmm5
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; xmm3
							cvtdq2ps xmm4,xmm3						;; xmm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							cvtdq2ps xmm3,xmm3
							xorps xmm3,xmmword ptr [minusMask_ps] 
							cvtps2dq xmm3,xmm3
							por xmm3,xmmword ptr [int_one]
							cvtdq2ps xmm6,xmm3						;; xmm6 = 1,-1

							mulps xmm4,xmmword ptr [pi_ps]
							subps xmm4,xmm2
							movaps xmm1,xmm4

							mulps xmm1,xmm1
							movaps xmm2,xmm1
							movaps xmm0,xmmword ptr [m_ccoeff_ps]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+16]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+32]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+48]
							divps xmm1,xmm0
							addps xmm7,xmm1
						    mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+64]
							divps xmm1,xmm0
							addps xmm7,xmm1
							
							mulps xmm7,xmm6
							movaps xmmword ptr [edx],xmm7

							add ebx,16
							add edx,16
							dec ecx
							jnz @B

							mov ecx,eax
			too_short:		or ecx,ecx
							mov eax,1
							jz done

							movaps xmm7,xmmword ptr [one_ps]
							movaps xmm1,xmmword ptr [ebx]
							movaps xmm5,xmmword ptr [half_pi_ps]
							subps xmm5,xmm1
							movaps xmm3,xmm5
							divps xmm3,xmmword ptr [two_pi_ps]
							roundps xmm3,xmm3,0011b
							mulps xmm3,xmmword ptr [two_pi_ps]
							subps xmm5,xmm3
							andps xmm5,xmmword ptr [absMask_ps]        
							movaps xmm2,xmm5						;; xmm2 = x
							mulps xmm5,xmmword ptr [two_o_pi_ps]
							cvttps2dq xmm3,xmm5
							paddw xmm3,xmmword ptr [int_one]
							psrlw xmm3,1							;; xmm3
							cvtdq2ps xmm4,xmm3						;; xmm4 = 0,1,1,2
							pand xmm3,xmmword ptr [int_one]
							cvtdq2ps xmm3,xmm3
							xorps xmm3,xmmword ptr [minusMask_ps] 
							cvtps2dq xmm3,xmm3
							por xmm3,xmmword ptr [int_one]
							cvtdq2ps xmm6,xmm3						;; xmm6 = 1,-1

							mulps xmm4,xmmword ptr [pi_ps]
							subps xmm4,xmm2
							movaps xmm1,xmm4

							mulps xmm1,xmm1
							movaps xmm2,xmm1
							movaps xmm0,xmmword ptr [m_ccoeff_ps]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+16]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+32]
							divps xmm1,xmm0
							addps xmm7,xmm1
							mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+48]
							divps xmm1,xmm0
							addps xmm7,xmm1
						    mulps xmm1,xmm2
							movaps xmm0,xmmword ptr [m_ccoeff_ps+64]
							divps xmm1,xmm0
							addps xmm7,xmm1
							
							mulps xmm7,xmm6

							cmp ecx,1
							je short one_left
							cmp ecx,2
							je short two_left
							cmp ecx,3
							je short three_left

			one_left:		movss real4 ptr [edx],xmm7
							jmp short done
			two_left:		insertps xmm2,xmm7,01000000b
							movss real4 ptr [edx],xmm7
							movss real4 ptr [edx + 4],xmm2	
							jmp short done
			three_left:		insertps xmm2,xmm7,01000000b
							insertps xmm4,xmm7,10000000b
							movss real4 ptr [edx],xmm7
							movss real4 ptr [edx + 4],xmm2
							movss real4 ptr [edx + 8],xmm4

				done:		ret
sin_sse_ps					endp
							end
