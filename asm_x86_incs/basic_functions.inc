.model flat,c

;; ============================= CONSTANTS =================================
.const 
align 16	
abs_mask_ps					dword	7fffffffh,7fffffffh,7fffffffh,7fffffffh	
abs_mask_pd					qword	7fffffffffffffffh,7fffffffffffffffh

;; ============================ PROTOTYPES =================================

maxs_sse_ps proto,
		x_ptr:ptr real4, 
		y_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

maxs_sse_pd proto,
		x_ptr:ptr real8, 
		y_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

mins_sse_ps proto,
		x_ptr:ptr real4, 
		y_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

mins_sse_pd proto,
		x_ptr:ptr real8, 
		y_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

abs_sse_ps proto,
		x_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

abs_sse_pd proto,
		x_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

sqrt_sse_ps proto,
		x_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

sqrt_sse_pd proto,
		x_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

sqrpow_sse_ps proto,
		x_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

sqrpow_sse_pd proto,
		x_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

