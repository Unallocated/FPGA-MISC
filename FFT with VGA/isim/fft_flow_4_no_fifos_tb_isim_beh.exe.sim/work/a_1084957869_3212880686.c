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
static const char *ng0 = "/root/FPGA-MISC/FFT with VGA/vga_configurable.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );


static void work_a_1084957869_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(48, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t11 = (t0 + 2792U);
    t12 = *((char **)t11);
    t11 = (t0 + 6016);
    t13 = (t11 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t12, 3U);
    xsi_driver_first_trans_fast_port(t11);

LAB2:    t17 = (t0 + 5888);
    *((int *)t17) = 1;

LAB1:    return;
LAB3:    t1 = xsi_get_transient_memory(3U);
    memset(t1, 0, 3U);
    t5 = t1;
    memset(t5, (unsigned char)2, 3U);
    t6 = (t0 + 6016);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 3U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_1084957869_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(49, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t11 = (t0 + 2632U);
    t12 = *((char **)t11);
    t11 = (t0 + 6080);
    t13 = (t11 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t12, 3U);
    xsi_driver_first_trans_fast_port(t11);

LAB2:    t17 = (t0 + 5904);
    *((int *)t17) = 1;

LAB1:    return;
LAB3:    t1 = xsi_get_transient_memory(3U);
    memset(t1, 0, 3U);
    t5 = t1;
    memset(t5, (unsigned char)2, 3U);
    t6 = (t0 + 6080);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 3U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_1084957869_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB3;

LAB4:
LAB5:    t11 = (t0 + 2472U);
    t12 = *((char **)t11);
    t11 = (t0 + 6144);
    t13 = (t11 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t12, 2U);
    xsi_driver_first_trans_fast_port(t11);

LAB2:    t17 = (t0 + 5920);
    *((int *)t17) = 1;

LAB1:    return;
LAB3:    t1 = xsi_get_transient_memory(2U);
    memset(t1, 0, 2U);
    t5 = t1;
    memset(t5, (unsigned char)2, 2U);
    t6 = (t0 + 6144);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 2U);
    xsi_driver_first_trans_fast_port(t6);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_1084957869_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    int t6;
    char *t7;
    unsigned int t8;
    char *t9;
    int t10;
    char *t11;
    char *t12;
    unsigned int t13;
    char *t14;
    unsigned char t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    int t21;
    int t22;
    unsigned char t23;
    int t24;
    unsigned int t25;
    int t26;
    unsigned int t27;
    char *t28;
    int t29;
    int t30;
    char *t31;
    unsigned int t33;
    char *t34;
    int t35;
    int t36;
    unsigned char t37;
    char *t38;
    char *t39;
    int t40;
    char *t41;
    unsigned int t42;
    char *t43;
    int t44;
    char *t45;
    char *t46;
    unsigned int t47;
    char *t48;
    int t49;
    int t50;
    unsigned char t51;
    char *t52;
    char *t53;
    int t54;
    char *t55;
    unsigned int t56;
    char *t57;
    int t58;
    char *t59;
    unsigned int t61;
    char *t62;
    int t63;
    int t64;
    char *t65;
    unsigned int t67;
    char *t68;
    int t69;
    int t70;
    unsigned char t71;
    char *t72;
    char *t73;
    char *t74;
    char *t75;
    char *t76;

LAB0:    xsi_set_current_line(60, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 992U);
    t3 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 5936);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(62, ng0);
    t1 = (t0 + 3728U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(63, ng0);
    t1 = (t0 + 3848U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    goto LAB3;

LAB5:    xsi_set_current_line(66, ng0);
    t2 = (t0 + 3728U);
    t5 = *((char **)t2);
    t6 = *((int *)t5);
    t2 = (t0 + 9808);
    t8 = (0 + 0U);
    t9 = (t2 + t8);
    t10 = *((int *)t9);
    t4 = (t6 < t10);
    if (t4 != 0)
        goto LAB7;

LAB9:    xsi_set_current_line(69, ng0);
    t1 = (t0 + 9888);
    t8 = (0 + 16U);
    t5 = (t1 + t8);
    t3 = *((unsigned char *)t5);
    t4 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t3);
    t7 = (t0 + 6208);
    t9 = (t7 + 56U);
    t11 = *((char **)t9);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    *((unsigned char *)t14) = t4;
    xsi_driver_first_trans_fast_port(t7);

LAB8:    xsi_set_current_line(73, ng0);
    t1 = (t0 + 3848U);
    t2 = *((char **)t1);
    t6 = *((int *)t2);
    t1 = (t0 + 9928);
    t8 = (0 + 20U);
    t7 = (t1 + t8);
    t10 = *((int *)t7);
    t3 = (t6 < t10);
    if (t3 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(76, ng0);
    t1 = (t0 + 10008);
    t8 = (0 + 36U);
    t5 = (t1 + t8);
    t3 = *((unsigned char *)t5);
    t4 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t3);
    t7 = (t0 + 6272);
    t9 = (t7 + 56U);
    t11 = *((char **)t9);
    t12 = (t11 + 56U);
    t14 = *((char **)t12);
    *((unsigned char *)t14) = t4;
    xsi_driver_first_trans_fast_port(t7);

LAB11:    xsi_set_current_line(80, ng0);
    t1 = (t0 + 3728U);
    t2 = *((char **)t1);
    t6 = *((int *)t2);
    t1 = (t0 + 10048);
    t8 = (0 + 0U);
    t7 = (t1 + t8);
    t10 = *((int *)t7);
    t9 = (t0 + 10088);
    t13 = (0 + 8U);
    t12 = (t9 + t13);
    t21 = *((int *)t12);
    t22 = (t10 + t21);
    t23 = (t6 > t22);
    if (t23 == 1)
        goto LAB22;

LAB23:    t15 = (unsigned char)0;

LAB24:    if (t15 == 1)
        goto LAB19;

LAB20:    t4 = (unsigned char)0;

LAB21:    if (t4 == 1)
        goto LAB16;

LAB17:    t3 = (unsigned char)0;

LAB18:    if (t3 != 0)
        goto LAB13;

LAB15:    xsi_set_current_line(92, ng0);
    t1 = (t0 + 6336);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t7 = (t5 + 56U);
    t9 = *((char **)t7);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(94, ng0);
    t6 = (-(1));
    t1 = (t0 + 6400);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t7 = (t5 + 56U);
    t9 = *((char **)t7);
    *((int *)t9) = t6;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(95, ng0);
    t6 = (-(1));
    t1 = (t0 + 6464);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t7 = (t5 + 56U);
    t9 = *((char **)t7);
    *((int *)t9) = t6;
    xsi_driver_first_trans_fast_port(t1);

LAB14:    xsi_set_current_line(99, ng0);
    t1 = (t0 + 3728U);
    t2 = *((char **)t1);
    t6 = *((int *)t2);
    t1 = (t0 + 10608);
    t8 = (0 + 4U);
    t7 = (t1 + t8);
    t10 = *((int *)t7);
    t9 = (t0 + 10648);
    t13 = (0 + 8U);
    t12 = (t9 + t13);
    t21 = *((int *)t12);
    t22 = (t10 + t21);
    t14 = (t0 + 10688);
    t25 = (0 + 0U);
    t17 = (t14 + t25);
    t24 = *((int *)t17);
    t26 = (t22 + t24);
    t18 = (t0 + 10728);
    t27 = (0 + 12U);
    t20 = (t18 + t27);
    t29 = *((int *)t20);
    t30 = (t26 + t29);
    t35 = (t30 - 1);
    t3 = (t6 == t35);
    if (t3 != 0)
        goto LAB25;

LAB27:    xsi_set_current_line(113, ng0);
    t1 = (t0 + 3728U);
    t2 = *((char **)t1);
    t6 = *((int *)t2);
    t10 = (t6 + 1);
    t1 = (t0 + 3728U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t10;

LAB26:    goto LAB3;

LAB7:    xsi_set_current_line(67, ng0);
    t11 = (t0 + 9848);
    t13 = (0 + 16U);
    t14 = (t11 + t13);
    t15 = *((unsigned char *)t14);
    t16 = (t0 + 6208);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = t15;
    xsi_driver_first_trans_fast_port(t16);
    goto LAB8;

LAB10:    xsi_set_current_line(74, ng0);
    t9 = (t0 + 9968);
    t13 = (0 + 36U);
    t12 = (t9 + t13);
    t4 = *((unsigned char *)t12);
    t14 = (t0 + 6272);
    t16 = (t14 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = t4;
    xsi_driver_first_trans_fast_port(t14);
    goto LAB11;

LAB13:    xsi_set_current_line(86, ng0);
    t72 = (t0 + 6336);
    t73 = (t72 + 56U);
    t74 = *((char **)t73);
    t75 = (t74 + 56U);
    t76 = *((char **)t75);
    *((unsigned char *)t76) = (unsigned char)3;
    xsi_driver_first_trans_fast(t72);
    xsi_set_current_line(88, ng0);
    t1 = (t0 + 3728U);
    t2 = *((char **)t1);
    t6 = *((int *)t2);
    t1 = (t0 + 10448);
    t8 = (0 + 0U);
    t7 = (t1 + t8);
    t10 = *((int *)t7);
    t21 = (t6 - t10);
    t9 = (t0 + 10488);
    t13 = (0 + 8U);
    t12 = (t9 + t13);
    t22 = *((int *)t12);
    t24 = (t21 - t22);
    t14 = (t0 + 6400);
    t16 = (t14 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    *((int *)t19) = t24;
    xsi_driver_first_trans_fast_port(t14);
    xsi_set_current_line(89, ng0);
    t1 = (t0 + 3848U);
    t2 = *((char **)t1);
    t6 = *((int *)t2);
    t1 = (t0 + 10528);
    t8 = (0 + 20U);
    t7 = (t1 + t8);
    t10 = *((int *)t7);
    t21 = (t6 - t10);
    t9 = (t0 + 10568);
    t13 = (0 + 28U);
    t12 = (t9 + t13);
    t22 = *((int *)t12);
    t24 = (t21 - t22);
    t14 = (t0 + 6464);
    t16 = (t14 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    *((int *)t19) = t24;
    xsi_driver_first_trans_fast_port(t14);
    goto LAB14;

LAB16:    t52 = (t0 + 3848U);
    t53 = *((char **)t52);
    t54 = *((int *)t53);
    t52 = (t0 + 10328);
    t56 = (0 + 20U);
    t57 = (t52 + t56);
    t58 = *((int *)t57);
    t59 = (t0 + 10368);
    t61 = (0 + 28U);
    t62 = (t59 + t61);
    t63 = *((int *)t62);
    t64 = (t58 + t63);
    t65 = (t0 + 10408);
    t67 = (0 + 32U);
    t68 = (t65 + t67);
    t69 = *((int *)t68);
    t70 = (t64 + t69);
    t71 = (t54 < t70);
    t3 = t71;
    goto LAB18;

LAB19:    t38 = (t0 + 3848U);
    t39 = *((char **)t38);
    t40 = *((int *)t39);
    t38 = (t0 + 10248);
    t42 = (0 + 20U);
    t43 = (t38 + t42);
    t44 = *((int *)t43);
    t45 = (t0 + 10288);
    t47 = (0 + 28U);
    t48 = (t45 + t47);
    t49 = *((int *)t48);
    t50 = (t44 + t49);
    t51 = (t40 > t50);
    t4 = t51;
    goto LAB21;

LAB22:    t14 = (t0 + 3728U);
    t16 = *((char **)t14);
    t24 = *((int *)t16);
    t14 = (t0 + 10128);
    t25 = (0 + 0U);
    t18 = (t14 + t25);
    t26 = *((int *)t18);
    t19 = (t0 + 10168);
    t27 = (0 + 8U);
    t28 = (t19 + t27);
    t29 = *((int *)t28);
    t30 = (t26 + t29);
    t31 = (t0 + 10208);
    t33 = (0 + 12U);
    t34 = (t31 + t33);
    t35 = *((int *)t34);
    t36 = (t30 + t35);
    t37 = (t24 < t36);
    t15 = t37;
    goto LAB24;

LAB25:    xsi_set_current_line(101, ng0);
    t28 = (t0 + 3848U);
    t31 = *((char **)t28);
    t36 = *((int *)t31);
    t28 = (t0 + 10768);
    t33 = (0 + 24U);
    t34 = (t28 + t33);
    t40 = *((int *)t34);
    t38 = (t0 + 10808);
    t42 = (0 + 28U);
    t41 = (t38 + t42);
    t44 = *((int *)t41);
    t49 = (t40 + t44);
    t43 = (t0 + 10848);
    t47 = (0 + 20U);
    t46 = (t43 + t47);
    t50 = *((int *)t46);
    t54 = (t49 + t50);
    t48 = (t0 + 10888);
    t56 = (0 + 32U);
    t53 = (t48 + t56);
    t58 = *((int *)t53);
    t63 = (t54 + t58);
    t64 = (t63 - 1);
    t4 = (t36 == t64);
    if (t4 != 0)
        goto LAB28;

LAB30:    xsi_set_current_line(106, ng0);
    t1 = (t0 + 3848U);
    t2 = *((char **)t1);
    t6 = *((int *)t2);
    t10 = (t6 + 1);
    t1 = (t0 + 3848U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t10;

LAB29:    xsi_set_current_line(110, ng0);
    t1 = (t0 + 3728U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    goto LAB26;

LAB28:    xsi_set_current_line(103, ng0);
    t55 = (t0 + 3848U);
    t57 = *((char **)t55);
    t55 = (t57 + 0);
    *((int *)t55) = 0;
    goto LAB29;

}


extern void work_a_1084957869_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1084957869_3212880686_p_0,(void *)work_a_1084957869_3212880686_p_1,(void *)work_a_1084957869_3212880686_p_2,(void *)work_a_1084957869_3212880686_p_3};
	xsi_register_didat("work_a_1084957869_3212880686", "isim/fft_flow_4_no_fifos_tb_isim_beh.exe.sim/work/a_1084957869_3212880686.didat");
	xsi_register_executes(pe);
}
