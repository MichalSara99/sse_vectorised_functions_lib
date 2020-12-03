								.model flat,c
								.const
								align 16
;; =========================================================== GENERAL ====================================================

int_abs_mask_ps					dword	7fffffffh,7fffffffh,7fffffffh,7fffffffh	
int_abs_mask_pd					qword	7fffffffffffffffh,7fffffffffffffffh

								.code

;;			extern "C" bool maxs_sse_ps(float const* x,float const* y, int n, float *out);
maxs_sse_ps						proc
								push ebp
								mov ebp,esp
								push ebx
								push esi

								xor eax,eax

								mov ecx,[ebp + 16]
								cmp ecx,4
								jl Done

								mov ebx,[ebp + 8]
								test ebx,0fh
								jnz Done

								mov esi,[ebp + 12]
								test esi,0fh
								jnz Done

								mov edx,[ebp + 20]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

					@@:			movaps xmm0,xmmword ptr [ebx]
								movaps xmm1,xmmword ptr [esi]
								maxps xmm0,xmm1
								movaps xmmword ptr [edx],xmm0
								add ebx,16
								add esi,16
								add edx,16
								sub ecx,4
								jnz @B

								mov eax,1

				Done:			pop esi
								pop ebx
								mov esp,ebp
								pop ebp
								ret
maxs_sse_ps						endp

;;			extern "C" bool maxs_sse_pd(float const* x,float const* y, int n, float *out);
maxs_sse_pd						proc
								push ebp
								mov ebp,esp
								push ebx
								push esi

								xor eax,eax

								mov ecx,[ebp + 16]
								cmp ecx,2
								jl Done

								mov ebx,[ebp + 8]
								test ebx,0fh
								jnz Done

								mov esi,[ebp + 12]
								test esi,0fh
								jnz Done

								mov edx,[ebp + 20]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

					@@:			movapd xmm0,xmmword ptr [ebx]
								movapd xmm1,xmmword ptr [esi]
								maxpd xmm0,xmm1
								movapd xmmword ptr [edx],xmm0
								add ebx,16
								add esi,16
								add edx,16
								sub ecx,2
								jnz @B

								mov eax,1

				Done:			pop esi
								pop ebx
								mov esp,ebp
								pop ebp
								ret
maxs_sse_pd						endp

;;			extern "C" bool mins_sse_ps(float const* x,float const* y, int n, float *out);
mins_sse_ps						proc
								push ebp
								mov ebp,esp
								push ebx
								push esi

								xor eax,eax

								mov ecx,[ebp + 16]
								cmp ecx,4
								jl Done

								mov ebx,[ebp + 8]
								test ebx,0fh
								jnz Done

								mov esi,[ebp + 12]
								test esi,0fh
								jnz Done

								mov edx,[ebp + 20]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

					@@:			movaps xmm0,xmmword ptr [ebx]
								movaps xmm1,xmmword ptr [esi]
								minps xmm0,xmm1
								movaps xmmword ptr [edx],xmm0
								add ebx,16
								add esi,16
								add edx,16
								sub ecx,4
								jnz @B

								mov eax,1

				Done:			pop esi
								pop ebx
								mov esp,ebp
								pop ebp
								ret
mins_sse_ps						endp

;;			extern "C" bool mins_sse_pd(float const* x,float const* y, int n, float *out);
mins_sse_pd						proc
								push ebp
								mov ebp,esp
								push ebx
								push esi

								xor eax,eax

								mov ecx,[ebp + 16]
								cmp ecx,2
								jl Done

								mov ebx,[ebp + 8]
								test ebx,0fh
								jnz Done

								mov esi,[ebp + 12]
								test esi,0fh
								jnz Done

								mov edx,[ebp + 20]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

					@@:			movapd xmm0,xmmword ptr [ebx]
								movapd xmm1,xmmword ptr [esi]
								minpd xmm0,xmm1
								movapd xmmword ptr [edx],xmm0
								add ebx,16
								add esi,16
								add edx,16
								sub ecx,2
								jnz @B

								mov eax,1

				Done:			pop esi
								pop ebx
								mov esp,ebp
								pop ebp
								ret
mins_sse_pd						endp

;;			extern "C" bool min_sse_ps(float const* x, int n, float* out);
min_sse_ps						proc
								push ebp
								mov ebp,esp

								xor eax,eax

								mov ecx,[ebp + 12]
								cmp ecx,4
								jl Done

								mov edx,[ebp + 8]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

								movaps xmm7,xmmword ptr [edx]
								minps xmm7,xmm7
								add edx,16
								sub ecx,4
								jz Final

					@@:			movaps xmm0,xmmword ptr [edx]
								minps xmm7,xmm0
								add edx,16
								sub ecx,4
								jnz @B

				Final:			movhlps xmm6,xmm7
								minps xmm7,xmm6
								movaps xmm6,xmm7
								shufps xmm6,xmm6,00000001b
								minss xmm7,xmm6
								mov edx,[ebp + 16]
								movss real4 ptr [edx],xmm7

								mov eax,1

				Done:			mov esp,ebp
								pop ebp
								ret
min_sse_ps						endp

;;			extern "C" bool min_sse_pd(double const* x, int n, double* out);
min_sse_pd						proc
								push ebp
								mov ebp,esp

								xor eax,eax

								mov ecx,[ebp + 12]
								cmp ecx,2
								jl Done

								mov edx,[ebp + 8]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

								movapd xmm7,xmmword ptr [edx]
								minpd xmm7,xmm7
								add edx,16
								sub ecx,2
								jz Final

					@@:			movapd xmm0,xmmword ptr [edx]
								minpd xmm7,xmm0
								add edx,16
								sub ecx,2
								jnz @B

				Final:			movapd xmm6,xmm7
								shufpd xmm6,xmm6,00000001b
								minsd xmm7,xmm6
								mov edx,[ebp + 16]
								movsd real8 ptr [edx],xmm7

								mov eax,1

				Done:			mov esp,ebp
								pop ebp
								ret
min_sse_pd						endp

;;			extern "C" bool max_sse_ps(float const* x, int n, float* out);
max_sse_ps						proc
								push ebp
								mov ebp,esp

								xor eax,eax

								mov ecx,[ebp + 12]
								cmp ecx,4
								jl Done

								mov edx,[ebp + 8]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

								movaps xmm7,xmmword ptr [edx]
								maxps xmm7,xmm7
								add edx,16
								sub ecx,4
								jz Final

					@@:			movaps xmm0,xmmword ptr [edx]
								maxps xmm7,xmm0
								add edx,16
								sub ecx,4
								jnz @B

				Final:			movhlps xmm6,xmm7
								maxps xmm7,xmm6
								movaps xmm6,xmm7
								shufps xmm6,xmm6,00000001b
								maxss xmm7,xmm6
								mov edx,[ebp + 16]
								movss real4 ptr [edx],xmm7

								mov eax,1

				Done:			mov esp,ebp
								pop ebp
								ret
max_sse_ps						endp

;;			extern "C" bool max_sse_pd(double const* x, int n, double* out);
max_sse_pd						proc
								push ebp
								mov ebp,esp

								xor eax,eax

								mov ecx,[ebp + 12]
								cmp ecx,2
								jl Done

								mov edx,[ebp + 8]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

								movapd xmm7,xmmword ptr [edx]
								maxpd xmm7,xmm7
								add edx,16
								sub ecx,2
								jz Final

					@@:			movapd xmm0,xmmword ptr [edx]
								maxpd xmm7,xmm0
								add edx,16
								sub ecx,2
								jnz @B

				Final:			movapd xmm6,xmm7
								shufpd xmm6,xmm6,00000001b
								maxsd xmm7,xmm6
								mov edx,[ebp + 16]
								movsd real8 ptr [edx],xmm7

								mov eax,1

				Done:			mov esp,ebp
								pop ebp
								ret
max_sse_pd						endp

;;			extern "C" bool abs_sse_ps(float const* x, int n, float* out);
abs_sse_ps						proc
								push ebp
								mov ebp,esp
								push ebx
		
								xor eax,eax

								mov ecx,[ebp + 12]
								cmp ecx,4
								jl Done

								mov ebx,[ebp + 8]
								test ebx,0fh
								jnz Done

								mov edx,[ebp + 16]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

					@@:			movaps xmm0,xmmword ptr [ebx]
								andps xmm0,xmmword ptr [int_abs_mask_ps]
								movaps xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								sub ecx,4
								jnz @B

								mov eax,1
								
				Done:			pop ebx
								mov esp,ebp
								pop ebp
								ret
abs_sse_ps						endp

;;			extern "C" bool abs_sse_pd(double const* x, int n, double* out);
abs_sse_pd						proc
								push ebp
								mov ebp,esp
								push ebx
		
								xor eax,eax

								mov ecx,[ebp + 12]
								cmp ecx,2
								jl Done

								mov ebx,[ebp + 8]
								test ebx,0fh
								jnz Done

								mov edx,[ebp + 16]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

					@@:			movapd xmm0,xmmword ptr [ebx]
								andpd xmm0,xmmword ptr [int_abs_mask_ps]
								movapd xmmword ptr [edx],xmm0
								add ebx,16
								add edx,16
								sub ecx,2
								jnz @B


								mov eax,1
								
				Done:			pop ebx
								mov esp,ebp
								pop ebp
								ret
abs_sse_pd						endp


;;			extern "C" bool sqrt_sse_pd(double const* x, int n, double* out);
sqrt_sse_pd						proc
								push ebp
								mov ebp,esp
								push ebx

								xor eax,eax

								mov ecx,[ebp + 12]
								cmp ecx,2
								jl Done

								mov ebx,[ebp + 8]
								test ebx,0fh
								jnz Done

								mov edx,[ebp + 16]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

					@@:			movapd xmm0,xmmword ptr [ebx]
								sqrtpd xmm0,xmm0
								movapd xmmword ptr [edx],xmm0

								add ebx,16
								add edx,16
								sub ecx,2
								jnz @B

								mov eax,1

				Done:			pop ebx
								mov esp,ebp
								pop ebp
								ret
sqrt_sse_pd						endp

;;			extern "C" bool sqrt_sse_ps(float const* x, int n, float* out);
sqrt_sse_ps						proc
								push ebp
								mov ebp,esp
								push ebx

								xor eax,eax

								mov ecx,[ebp + 12]
								cmp ecx,4
								jl Done

								mov ebx,[ebp + 8]
								test ebx,0fh
								jnz Done

								mov edx,[ebp + 16]
								test edx,0fh
								jnz Done

								and ecx,0fffffffeh

					@@:			movaps xmm0,xmmword ptr [ebx]
								sqrtps xmm0,xmm0
								movaps xmmword ptr [edx],xmm0

								add ebx,16
								add edx,16
								sub ecx,4
								jnz @B

								mov eax,1

				Done:			pop ebx
								mov esp,ebp
								pop ebp
								ret
sqrt_sse_ps						endp
								end
