.model flat,c
.const
align 16
;; =============== packed double precision floating point =================

plus_1_pd						real8	1.0,1.0
;; =============== packed single precision floating point =================

plus_1_ps						real4	1.0,1.0,1.0,1.0
;; ============================== GENERAL =================================

int_neg_mask_ps					dword	80000000h,80000000h,80000000h,80000000h
int_neg_mask_pd					qword	8000000000000000h,8000000000000000h

;; ============================ PROTOTYPES =================================

;; broadcast versions:
mul_br_sse_ps proto,
		x_ptr:ptr real4, 
		y_arg:real4,
		n_arg:dword,
		out_ptr:ptr real4

mul_br_sse_pd proto,
		x_ptr:ptr real8, 
		y_arg:real8,
		n_arg:dword,
		out_ptr:ptr real8

div_br_sse_ps proto,
		x_ptr:ptr real4, 
		y_arg:real4,
		n_arg:dword,
		out_ptr:ptr real4

div_br_sse_pd proto,
		x_ptr:ptr real8, 
		y_arg:real8,
		n_arg:dword,
		out_ptr:ptr real8

div_br_s_sse_ps proto,
		x_arg:real4, 
		y_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

div_br_s_sse_pd proto,
		x_arg:real8, 
		y_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

add_br_sse_ps proto,
		x_ptr:ptr real4, 
		y_arg:real4,
		n_arg:dword,
		out_ptr:ptr real4

add_br_sse_pd proto,
		x_ptr:ptr real8, 
		y_arg:real8,
		n_arg:dword,
		out_ptr:ptr real8

sub_br_sse_ps proto,
		x_ptr:ptr real4, 
		y_arg:real4,
		n_arg:dword,
		out_ptr:ptr real4

sub_br_sse_pd proto,
		x_ptr:ptr real8, 
		y_arg:real8,
		n_arg:dword,
		out_ptr:ptr real8

sub_br_s_sse_ps proto,
		x_arg:real4, 
		y_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

sub_br_s_sse_pd proto,
		x_arg:real8, 
		y_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

;; non-broadcast version:
mul_sse_ps proto,
		x_ptr:ptr real4, 
		y_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

mul_sse_pd proto,
		x_ptr:ptr real8, 
		y_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

div_sse_ps proto,
		x_ptr:ptr real4, 
		y_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

div_sse_pd proto,
		x_ptr:ptr real8, 
		y_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

add_sse_ps proto,
		x_ptr:ptr real4, 
		y_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

add_sse_pd proto,
		x_ptr:ptr real8, 
		y_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

sub_sse_ps proto,
		x_ptr:ptr real4, 
		y_ptr:ptr real4,
		n_arg:dword,
		out_ptr:ptr real4

sub_sse_pd proto,
		x_ptr:ptr real8, 
		y_ptr:ptr real8,
		n_arg:dword,
		out_ptr:ptr real8

neg_sse_ps proto,
		x_ptr:ptr real4, 
		n_arg:dword,
		out_ptr:ptr real4

neg_sse_pd proto,
		x_ptr:ptr real8, 
		n_arg:dword,
		out_ptr:ptr real8

inv_sse_ps proto,
		x_ptr:ptr real4, 
		n_arg:dword,
		out_ptr:ptr real4

inv_sse_pd proto,
		x_ptr:ptr real8, 
		n_arg:dword,
		out_ptr:ptr real8