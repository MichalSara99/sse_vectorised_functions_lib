include asm_x86_incs/basic_functions.inc

.code
;;			extern "C" bool maxs_sse_ps(float const* x,float const* y, int n, float *out);
maxs_sse_ps						proc uses ebx esi,
											x_ptr:ptr real4, 
											y_ptr:ptr real4,
											n_arg:dword,
											out_ptr:ptr real4

								xor eax,eax
								;; first three checks are for alignment => this will be 
								;; removed once it is guaranteed through C++ object
								mov ebx,x_ptr
								test ebx,0fh
								jnz done

								mov esi,y_ptr
								test esi,0fh
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

					@@:			movaps xmm0,xmmword ptr [ebx]
								movaps xmm1,xmmword ptr [esi]
								maxps xmm0,xmm1
								movaps xmmword ptr [edx],xmm0
								add ebx,16
								add esi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [ebx]
								movaps xmm1,xmmword ptr [esi]
								maxps xmm0,xmm1

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left
								jmp done

				one_left:		movss real4 ptr [edx],xmm0
								jmp done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2	
								jmp done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm3,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2
								movss real4 ptr [edx + 8],xmm3

				done:			ret
maxs_sse_ps						endp

;;			extern "C" bool maxs_sse_pd(float const* x,float const* y, int n, float *out);
maxs_sse_pd						proc uses ebx esi,
											x_ptr:ptr real8, 
											y_ptr:ptr real8,
											n_arg:dword,
											out_ptr:ptr real8

								xor eax,eax
								;; first three checks are for alignment => this will be 
								;; removed once it is guaranteed through C++ object
								mov ebx,x_ptr
								test ebx,0fh
								jnz done

								mov esi,y_ptr
								test esi,0fh
								jnz done

								mov edx,out_ptr
								test edx,0fh
								jnz done

								mov ecx,n_arg
								cmp ecx,2
								jl too_short

								mov eax,ecx
								and ecx,0fffffffeh
								shr ecx,1
								and eax,1h

					@@:			movapd xmm0,xmmword ptr [ebx]
								movapd xmm1,xmmword ptr [esi]
								maxpd xmm0,xmm1
								movapd xmmword ptr [edx],xmm0
								add ebx,16
								add esi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
			too_short:			or ecx,ecx
								mov eax,1
								jz done

								movapd xmm0,xmmword ptr [ebx]
								movapd xmm1,xmmword ptr [esi]
								maxpd xmm0,xmm1
								movsd real8 ptr [edx],xmm0

				done:			ret
maxs_sse_pd						endp

;;			extern "C" bool mins_sse_ps(float const* x,float const* y, int n, float *out);
mins_sse_ps						proc uses ebx esi,
											x_ptr:ptr real4, 
											y_ptr:ptr real4,
											n_arg:dword,
											out_ptr:ptr real4
								xor eax,eax

								mov ebx,x_ptr
								test ebx,0fh
								jnz done

								mov esi,y_ptr
								test esi,0fh
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

					@@:			movaps xmm0,xmmword ptr [ebx]
								movaps xmm1,xmmword ptr [esi]
								minps xmm0,xmm1
								movaps xmmword ptr [edx],xmm0
								add ebx,16
								add esi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [ebx]
								movaps xmm1,xmmword ptr [esi]
								minps xmm0,xmm1

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm0
								jmp short done

				two_left:		insertps xmm1,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm1
								jmp short done

				three_left:		insertps xmm1,xmm0,01000000b
								insertps xmm2,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm1
								movss real4 ptr [edx + 8],xmm2

				done:			ret
mins_sse_ps						endp

;;			extern "C" bool mins_sse_pd(float const* x,float const* y, int n, float *out);
mins_sse_pd						proc uses ebx esi,
											x_ptr:ptr real8, 
											y_ptr:ptr real8,
											n_arg:dword,
											out_ptr:ptr real8

								xor eax,eax

								mov ebx,x_ptr
								test ebx,0fh
								jnz done

								mov esi,y_ptr
								test esi,0fh
								jnz done

								mov edx,out_ptr
								test edx,0fh
								jnz done

								mov ecx,n_arg
								cmp ecx,2
								jl too_short

								mov eax,ecx
								and ecx,0fffffffeh
								shr ecx,1
								and eax,1h

					@@:			movapd xmm0,xmmword ptr [ebx]
								movapd xmm1,xmmword ptr [esi]
								minpd xmm0,xmm1
								movapd xmmword ptr [edx],xmm0
								add ebx,16
								add esi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
			too_short:			or ecx,ecx
								mov eax,1
								jz short done

								movapd xmm0,xmmword ptr [ebx]
								movapd xmm1,xmmword ptr [esi]
								minpd xmm0,xmm1
								movsd real8 ptr [edx],xmm0

				done:			ret
mins_sse_pd						endp


;;			extern "C" bool abs_sse_ps(float const* x, int n, float* out);
abs_sse_ps						proc uses ebx,
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

					@@:			movaps xmm0,xmmword ptr [ebx]
								andps xmm0,xmmword ptr [abs_mask_ps]
								movaps xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [ebx]
								andps xmm0,xmmword ptr [abs_mask_ps]
								
								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm0
								jmp short done

				two_left:		insertps xmm1,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm1
								jmp short done

				three_left:		insertps xmm1,xmm0,01000000b
								insertps xmm2,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm1
								movss real4 ptr [edx + 8],xmm2
			
				done:			ret
abs_sse_ps						endp

;;			extern "C" bool abs_sse_pd(double const* x, int n, double* out);
abs_sse_pd						proc uses ebx,
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

					@@:			movapd xmm0,xmmword ptr [ebx]
								andpd xmm0,xmmword ptr [abs_mask_pd]
								movapd xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movsd xmm0,real8 ptr [ebx]
								andpd xmm0,real8 ptr [abs_mask_pd]
								movsd real8 ptr [edx],xmm0
								
				done:			ret
abs_sse_pd						endp


;;			extern "C" bool sqrt_sse_pd(double const* x, int n, double* out);
sqrt_sse_pd						proc uses ebx,
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

					@@:			movapd xmm0,xmmword ptr [ebx]
								sqrtpd xmm0,xmm0
								movapd xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movsd xmm0,real8 ptr [ebx]
								sqrtsd xmm0,xmm0
								movsd real8 ptr [edx],xmm0

				done:			ret
sqrt_sse_pd						endp

;;			extern "C" bool sqrt_sse_ps(float const* x, int n, float* out);
sqrt_sse_ps						proc uses ebx,
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


					@@:			movaps xmm0,xmmword ptr [ebx]
								sqrtps xmm0,xmm0
								movaps xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [ebx]
								sqrtps xmm0,xmm0

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm0
								jmp short done

				two_left:		insertps xmm1,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm1
								jmp short done

				three_left:		insertps xmm1,xmm0,01000000b
								insertps xmm2,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm1
								movss real4 ptr [edx + 8],xmm2

				done:			ret
sqrt_sse_ps						endp

;;			extern "C" bool sqrpow_sse_pd(double const* x, int n, double* out);
sqrpow_sse_pd					proc uses ebx,
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

					@@:			movapd xmm0,xmmword ptr [ebx]
								mulpd xmm0,xmm0
								movapd xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movsd xmm0,real8 ptr [ebx]
								mulsd xmm0,xmm0
								movsd real8 ptr [edx],xmm0

				done:			ret
sqrpow_sse_pd					endp

;;			extern "C" bool sqrpow_sse_ps(float const* x, int n, float* out);
sqrpow_sse_ps					proc uses ebx,
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

					@@:			movaps xmm0,xmmword ptr [ebx]
								mulps xmm0,xmm0
								movaps xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [ebx]
								mulps xmm0,xmm0

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm0
								jmp short done

				two_left:		insertps xmm1,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm1
								jmp short done

				three_left:		insertps xmm1,xmm0,01000000b
								insertps xmm2,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm1
								movss real4 ptr [edx + 8],xmm2

				done:			ret
sqrpow_sse_ps					endp
								end
