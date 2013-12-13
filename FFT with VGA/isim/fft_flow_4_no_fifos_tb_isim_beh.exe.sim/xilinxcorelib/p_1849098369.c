/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
extern char *STD_STANDARD;



int xilinxcorelib_p_1849098369_sub_7116170453661372939_2298176007(char *t1, int t2)
{
    char t3[248];
    char t4[8];
    char t8[8];
    char t14[8];
    int t0;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t15;
    char *t16;
    char *t17;
    unsigned char t18;
    char *t19;
    int t21;
    int t22;
    unsigned char t23;
    int t24;

LAB0:    t5 = (t3 + 4U);
    t6 = ((STD_STANDARD) + 384);
    t7 = (t5 + 88U);
    *((char **)t7) = t6;
    t9 = (t5 + 56U);
    *((char **)t9) = t8;
    *((int *)t8) = 0;
    t10 = (t5 + 80U);
    *((unsigned int *)t10) = 4U;
    t11 = (t3 + 124U);
    t12 = ((STD_STANDARD) + 384);
    t13 = (t11 + 88U);
    *((char **)t13) = t12;
    t15 = (t11 + 56U);
    *((char **)t15) = t14;
    *((int *)t14) = 0;
    t16 = (t11 + 80U);
    *((unsigned int *)t16) = 4U;
    t17 = (t4 + 4U);
    *((int *)t17) = t2;
    t18 = (t2 >= 0);
    if (t18 == 0)
        goto LAB2;

LAB3:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 1;
    t6 = (t11 + 56U);
    t7 = *((char **)t6);
    t6 = (t7 + 0);
    *((int *)t6) = 2;

LAB4:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t21 = *((int *)t7);
    t18 = (t21 < 1000);
    if (t18 != 0)
        goto LAB5;

LAB7:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t21 = *((int *)t7);
    t0 = t21;

LAB1:    return t0;
LAB2:    t19 = (t1 + 3440);
    xsi_report(t19, 60U, (unsigned char)2);
    goto LAB3;

LAB5:    t6 = (t11 + 56U);
    t9 = *((char **)t6);
    t22 = *((int *)t9);
    t23 = (t22 >= t2);
    if (t23 != 0)
        goto LAB8;

LAB10:
LAB9:    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t21 = *((int *)t7);
    t22 = (t21 + 1);
    t6 = (t5 + 56U);
    t9 = *((char **)t6);
    t6 = (t9 + 0);
    *((int *)t6) = t22;
    t6 = (t11 + 56U);
    t7 = *((char **)t6);
    t21 = *((int *)t7);
    t6 = (t11 + 56U);
    t9 = *((char **)t6);
    t22 = *((int *)t9);
    t24 = (t21 + t22);
    t6 = (t11 + 56U);
    t10 = *((char **)t6);
    t6 = (t10 + 0);
    *((int *)t6) = t24;
    goto LAB4;

LAB6:;
LAB8:    t6 = (t5 + 56U);
    t10 = *((char **)t6);
    t24 = *((int *)t10);
    t0 = t24;
    goto LAB1;

LAB11:    goto LAB9;

LAB12:;
}


extern void xilinxcorelib_p_1849098369_init()
{
	static char *se[] = {(void *)xilinxcorelib_p_1849098369_sub_7116170453661372939_2298176007};
	xsi_register_didat("xilinxcorelib_p_1849098369", "isim/fft_flow_4_no_fifos_tb_isim_beh.exe.sim/xilinxcorelib/p_1849098369.didat");
	xsi_register_subprogram_executes(se);
}
