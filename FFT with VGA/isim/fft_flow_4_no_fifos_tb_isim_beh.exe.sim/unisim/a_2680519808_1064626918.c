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
extern char *IEEE_P_1242562249;
extern char *IEEE_P_2592010699;

int ieee_p_1242562249_sub_17802405650254020620_1035706684(char *, char *, char *);


static void unisim_a_2680519808_1064626918_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    char *t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:
LAB3:    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 1352U);
    t3 = *((char **)t1);
    t1 = (t0 + 6712U);
    t4 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t3, t1);
    t5 = (t4 - 31);
    t6 = (t5 * -1);
    xsi_vhdl_check_range_of_index(31, 0, -1, t4);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t9 = (t2 + t8);
    t10 = *((unsigned char *)t9);
    t11 = (t0 + 4328);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = t10;
    xsi_driver_first_trans_fast_port(t11);

LAB2:    t16 = (t0 + 4200);
    *((int *)t16) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void unisim_a_2680519808_1064626918_p_1(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:
LAB3:    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t3 = (31 - 31);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t0 + 4392);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t7;
    xsi_driver_first_trans_fast_port(t8);

LAB2:    t13 = (t0 + 4216);
    *((int *)t13) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void unisim_a_2680519808_1064626918_p_2(char *t0)
{
    char t35[16];
    char t36[16];
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    unsigned char t13;
    unsigned char t14;
    unsigned char t15;
    char *t16;
    unsigned char t17;
    unsigned char t18;
    char *t19;
    char *t20;
    unsigned char t21;
    unsigned char t22;
    unsigned char t23;
    char *t24;
    char *t25;
    unsigned char t26;
    unsigned char t27;
    char *t28;
    unsigned char t29;
    unsigned char t30;
    int64 t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    int t37;
    unsigned int t38;
    char *t39;
    char *t40;
    char *t41;
    char *t42;

LAB0:    t1 = (t0 + 3880U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2408U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    if (t4 != 0)
        goto LAB4;

LAB6:
LAB5:    t2 = (t0 + 1632U);
    t5 = xsi_signal_has_event(t2);
    if (t5 == 1)
        goto LAB29;

LAB30:    t4 = (unsigned char)0;

LAB31:    if (t4 != 0)
        goto LAB26;

LAB28:
LAB27:
LAB39:    t2 = (t0 + 4248);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB40;

LAB1:    return;
LAB4:
LAB9:    t2 = (t0 + 4232);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB10;
    goto LAB1;

LAB7:    t24 = (t0 + 4232);
    *((int *)t24) = 0;
    t2 = (t0 + 2408U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((unsigned char *)t2) = (unsigned char)0;
    goto LAB5;

LAB8:    t8 = (t0 + 1512U);
    t9 = *((char **)t8);
    t10 = *((unsigned char *)t9);
    t11 = (t10 == (unsigned char)3);
    if (t11 == 1)
        goto LAB17;

LAB18:    t8 = (t0 + 1512U);
    t12 = *((char **)t8);
    t13 = *((unsigned char *)t12);
    t14 = (t13 == (unsigned char)2);
    t7 = t14;

LAB19:    if (t7 == 1)
        goto LAB14;

LAB15:    t6 = (unsigned char)0;

LAB16:    if (t6 == 1)
        goto LAB11;

LAB12:    t5 = (unsigned char)0;

LAB13:    if (t5 == 1)
        goto LAB7;
    else
        goto LAB9;

LAB10:    goto LAB8;

LAB11:    t24 = (t0 + 1672U);
    t25 = *((char **)t24);
    t26 = *((unsigned char *)t25);
    t27 = (t26 == (unsigned char)2);
    if (t27 == 1)
        goto LAB23;

LAB24:    t24 = (t0 + 1672U);
    t28 = *((char **)t24);
    t29 = *((unsigned char *)t28);
    t30 = (t29 == (unsigned char)3);
    t23 = t30;

LAB25:    t5 = t23;
    goto LAB13;

LAB14:    t8 = (t0 + 1632U);
    t16 = xsi_signal_last_value(t8);
    t17 = *((unsigned char *)t16);
    t18 = (t17 == (unsigned char)2);
    if (t18 == 1)
        goto LAB20;

LAB21:    t19 = (t0 + 1632U);
    t20 = xsi_signal_last_value(t19);
    t21 = *((unsigned char *)t20);
    t22 = (t21 == (unsigned char)3);
    t15 = t22;

LAB22:    t6 = t15;
    goto LAB16;

LAB17:    t7 = (unsigned char)1;
    goto LAB19;

LAB20:    t15 = (unsigned char)1;
    goto LAB22;

LAB23:    t23 = (unsigned char)1;
    goto LAB25;

LAB26:    t3 = (t0 + 1512U);
    t9 = *((char **)t3);
    t10 = *((unsigned char *)t9);
    t11 = (t10 == (unsigned char)3);
    if (t11 != 0)
        goto LAB32;

LAB34:
LAB33:    goto LAB27;

LAB29:    t3 = (t0 + 1672U);
    t8 = *((char **)t3);
    t6 = *((unsigned char *)t8);
    t7 = (t6 == (unsigned char)3);
    t4 = t7;
    goto LAB31;

LAB32:    t31 = (100 * 1LL);
    t3 = (t0 + 1992U);
    t12 = *((char **)t3);
    t32 = (31 - 30);
    t33 = (t32 * 1U);
    t34 = (0 + t33);
    t3 = (t12 + t34);
    t16 = (t0 + 1832U);
    t19 = *((char **)t16);
    t13 = *((unsigned char *)t19);
    t20 = ((IEEE_P_2592010699) + 4000);
    t24 = (t36 + 0U);
    t25 = (t24 + 0U);
    *((int *)t25) = 30;
    t25 = (t24 + 4U);
    *((int *)t25) = 0;
    t25 = (t24 + 8U);
    *((int *)t25) = -1;
    t37 = (0 - 30);
    t38 = (t37 * -1);
    t38 = (t38 + 1);
    t25 = (t24 + 12U);
    *((unsigned int *)t25) = t38;
    t16 = xsi_base_array_concat(t16, t35, t20, (char)97, t3, t36, (char)99, t13, (char)101);
    t38 = (31U + 1U);
    t14 = (32U != t38);
    if (t14 == 1)
        goto LAB35;

LAB36:    t25 = (t0 + 4456);
    t28 = (t25 + 56U);
    t39 = *((char **)t28);
    t40 = (t39 + 56U);
    t41 = *((char **)t40);
    memcpy(t41, t16, 32U);
    xsi_driver_first_trans_delta(t25, 0U, 32U, t31);
    t42 = (t0 + 4456);
    xsi_driver_intertial_reject(t42, t31, t31);
    goto LAB33;

LAB35:    xsi_size_not_matching(32U, t38, 0);
    goto LAB36;

LAB37:    t3 = (t0 + 4248);
    *((int *)t3) = 0;
    goto LAB2;

LAB38:    goto LAB37;

LAB40:    goto LAB38;

}


extern void unisim_a_2680519808_1064626918_init()
{
	static char *pe[] = {(void *)unisim_a_2680519808_1064626918_p_0,(void *)unisim_a_2680519808_1064626918_p_1,(void *)unisim_a_2680519808_1064626918_p_2};
	xsi_register_didat("unisim_a_2680519808_1064626918", "isim/fft_flow_4_no_fifos_tb_isim_beh.exe.sim/unisim/a_2680519808_1064626918.didat");
	xsi_register_executes(pe);
}
