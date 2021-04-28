include asm_x86_incs/basic_operations.inc

.code
;;				extern "C" bool mul_sse_ps(float const* x, float const* y, int n, float* out);
mul_sse_ps						proc uses esi edi,
											x_ptr:ptr real4, 
											y_ptr:ptr real4,
											n_arg:dword,
											out_ptr:ptr real4
								xor eax,eax

								mov esi,x_ptr
								test esi,0fh
								jnz done

								mov edi,y_ptr
								test edi,0fh
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

					@@:			movaps xmm0,xmmword ptr [esi]
								movaps xmm1,xmmword ptr [edi]
								mulps xmm0,xmm1
								movaps xmmword ptr [edx],xmm0
								add esi,16
								add edi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [esi]
								movaps xmm1,xmmword ptr [edi]
								mulps xmm0,xmm1

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2
								movss real4 ptr [edx + 8],xmm4

				done:			ret
mul_sse_ps						endp

;;				extern "C" bool mul_sse_pd(double const* x, double const* y, int n, double* out);
mul_sse_pd						proc uses esi edi,
											x_ptr:ptr real8, 
											y_ptr:ptr real8,
											n_arg:dword,
											out_ptr:ptr real8

								xor eax,eax

								mov esi,x_ptr
								test esi,0fh
								jnz done

								mov edi,y_ptr
								test edi,0fh
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

					@@:			movapd xmm0,xmmword ptr [esi]
								movapd xmm1,xmmword ptr [edi]
								mulpd xmm0,xmm1
								movapd xmmword ptr [edx],xmm0
								add esi,16
								add edi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movapd xmm0,xmmword ptr [esi]
								movapd xmm1,xmmword ptr [edi]
								mulpd xmm0,xmm1
								movsd real8 ptr [edx],xmm0

				done:			ret
mul_sse_pd						endp

;;				extern "C" bool div_sse_ps(float const* x, float const* y, int n, float* out);
div_sse_ps						proc uses esi edi,
											x_ptr:ptr real4, 
											y_ptr:ptr real4,
											n_arg:dword,
											out_ptr:ptr real4
								
								xor eax,eax

								mov esi,x_ptr
								test esi,0fh
								jnz done

								mov edi,y_ptr
								test edi,0fh
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

					@@:			movaps xmm0,xmmword ptr [esi]
								movaps xmm1,xmmword ptr [edi]
								divps xmm0,xmm1
								movaps xmmword ptr [edx],xmm0
								add esi,16
								add edi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [esi]
								movaps xmm1,xmmword ptr [edi]
								divps xmm0,xmm1

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2
								movss real4 ptr [edx + 8],xmm4

				done:			ret
div_sse_ps						endp

;;				extern "C" bool div_sse_pd(double const* x, double const* y, int n, double* out);
div_sse_pd						proc uses esi edi,
											x_ptr:ptr real8, 
											y_ptr:ptr real8,
											n_arg:dword,
											out_ptr:ptr real8
								
								xor eax,eax

								mov esi,x_ptr
								test esi,0fh
								jnz done

								mov edi,y_ptr
								test edi,0fh
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

					@@:			movapd xmm0,xmmword ptr [esi]
								movapd xmm1,xmmword ptr [edi]
								divpd xmm0,xmm1
								movapd xmmword ptr [edx],xmm0
								add esi,16
								add edi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movapd xmm0,xmmword ptr [esi]
								movapd xmm1,xmmword ptr [edi]
								divpd xmm0,xmm1
								movsd real8 ptr [edx],xmm0

				done:			ret
div_sse_pd						endp

;;				extern "C" bool add_sse_ps(float const* x, float const* y, int n, float* out);
add_sse_ps						proc uses esi edi,
										x_ptr:ptr real4, 
										y_ptr:ptr real4,
										n_arg:dword,
										out_ptr:ptr real4
								
								xor eax,eax

								mov esi,x_ptr
								test esi,0fh
								jnz done

								mov edi,y_ptr
								test edi,0fh
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

					@@:			movaps xmm0,xmmword ptr [esi]
								movaps xmm1,xmmword ptr [edi]
								addps xmm0,xmm1
								movaps xmmword ptr [edx],xmm0
								add esi,16
								add edi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
				too_short:		or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [esi]
								movaps xmm1,xmmword ptr [edi]
								addps xmm0,xmm1

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2
								movss real4 ptr [edx + 8],xmm4

				done:			ret
add_sse_ps						endp

;;				extern "C" bool add_sse_pd(double const* x, double const* y, int n, double* out);
add_sse_pd						proc uses esi edi,
											x_ptr:ptr real8, 
											y_ptr:ptr real8,
											n_arg:dword,
											out_ptr:ptr real8
								
								xor eax,eax

								mov esi,x_ptr
								test esi,0fh
								jnz done

								mov edi,y_ptr
								test edi,0fh
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

					@@:			movapd xmm0,xmmword ptr [esi]
								movapd xmm1,xmmword ptr [edi]
								addpd xmm0,xmm1
								movapd xmmword ptr [edx],xmm0
								add esi,16
								add edi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
			too_short:			or ecx,ecx
								mov eax,1
								jz done

								movapd xmm0,xmmword ptr [esi]
								movapd xmm1,xmmword ptr [edi]
								addpd xmm0,xmm1

								movsd real8 ptr [edx],xmm0

				done:			ret
add_sse_pd						endp

;;				extern "C" bool sub_sse_ps(float const* x, float const* y, int n, float* out);
sub_sse_ps						proc uses esi edi,
											x_ptr:ptr real4, 
											y_ptr:ptr real4,
											n_arg:dword,
											out_ptr:ptr real4
								
								xor eax,eax

								mov esi,x_ptr
								test esi,0fh
								jnz done

								mov edi,y_ptr
								test edi,0fh
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

					@@:			movaps xmm0,xmmword ptr [esi]
								movaps xmm1,xmmword ptr [edi]
								subps xmm0,xmm1
								movaps xmmword ptr [edx],xmm0
								add esi,16
								add edi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
			too_short:			or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [esi]
								movaps xmm1,xmmword ptr [edi]
								subps xmm0,xmm1

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2
								movss real4 ptr [edx + 8],xmm4

				done:			ret
sub_sse_ps						endp

;;				extern "C" bool sub_sse_pd(double const* x, double const* y, int n, double* out);
sub_sse_pd						proc uses esi edi,
											x_ptr:ptr real8, 
											y_ptr:ptr real8,
											n_arg:dword,
											out_ptr:ptr real8
								
								xor eax,eax

								mov esi,x_ptr
								test esi,0fh
								jnz done

								mov edi,y_ptr
								test edi,0fh
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

					@@:			movapd xmm0,xmmword ptr [esi]
								movapd xmm1,xmmword ptr [edi]
								subpd xmm0,xmm1
								movapd xmmword ptr [edx],xmm0
								add esi,16
								add edi,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
			too_short:			or ecx,ecx
								mov eax,1
								jz done

								movapd xmm0,xmmword ptr [esi]
								movapd xmm1,xmmword ptr [edi]
								subpd xmm0,xmm1
								movsd real8 ptr [edx],xmm0

				done:			ret
sub_sse_pd						endp

;;			extern "C" bool neg_sse_pd(double const* x, int n, double* out);
neg_sse_pd						proc uses ebx,
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
								xorpd xmm0,xmmword ptr [int_neg_mask_pd]
								movapd xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
			too_short:			or ecx,ecx
								mov eax,1
								jz done

								movapd xmm0,xmmword ptr [ebx]
								xorpd xmm0,xmmword ptr [int_neg_mask_pd]
								movsd real8 ptr [edx],xmm0

				done:			ret
neg_sse_pd						endp

;;			extern "C" bool neg_sse_ps(float const* x, int n, float* out);
neg_sse_ps						proc uses ebx,
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
								xorps xmm0,xmmword ptr [int_neg_mask_ps]
								movaps xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
			too_short:			or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [ebx]
								xorps xmm0,xmmword ptr [int_neg_mask_ps]

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm0
								jmp short done
				two_left:		insertps xmm2,xmm0,01000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm0,01000000b
								insertps xmm4,xmm0,10000000b
								movss real4 ptr [edx],xmm0
								movss real4 ptr [edx + 4],xmm2
								movss real4 ptr [edx + 8],xmm4

				done:			ret
neg_sse_ps						endp

;;			extern "C" bool inv_sse_pd(double const* x, int n, double* out);
inv_sse_pd						proc uses ebx,
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
								movapd xmm1,xmmword ptr [plus_1_pd]
								divpd xmm1,xmm0
								movapd xmmword ptr [edx],xmm1
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
			too_short:			or ecx,ecx
								mov eax,1
								jz done

								movapd xmm0,xmmword ptr [ebx]
								movapd xmm1,xmmword ptr [plus_1_pd]
								divpd xmm1,xmm0
								movsd real8 ptr [edx],xmm1

				done:			ret
inv_sse_pd						endp

;;			extern "C" bool inv_sse_ps(float const* x, int n, float* out);
inv_sse_ps						proc uses ebx,
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
								movaps xmm1,xmmword ptr [plus_1_ps]
								divps xmm1,xmm0
								movaps xmmword ptr [edx],xmm1
								add ebx,16
								add edx,16
								dec ecx
								jnz @B

								mov ecx,eax
			too_short:			or ecx,ecx
								mov eax,1
								jz done

								movaps xmm0,xmmword ptr [ebx]
								movaps xmm1,xmmword ptr [plus_1_ps]
								divps xmm1,xmm0

								cmp ecx,1
								je short one_left
								cmp ecx,2
								je short two_left
								cmp ecx,3
								je short three_left

				one_left:		movss real4 ptr [edx],xmm1
								jmp short done
				two_left:		insertps xmm2,xmm1,01000000b
								movss real4 ptr [edx],xmm1
								movss real4 ptr [edx + 4],xmm2	
								jmp short done
				three_left:		insertps xmm2,xmm1,01000000b
								insertps xmm4,xmm1,10000000b
								movss real4 ptr [edx],xmm1
								movss real4 ptr [edx + 4],xmm2
								movss real4 ptr [edx + 8],xmm4

				done:			ret
inv_sse_ps						endp
								end
