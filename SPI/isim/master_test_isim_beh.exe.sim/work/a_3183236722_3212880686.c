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
static const char *ng0 = "/root/FPGA-MISC/SPI/master.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_3183236722_3212880686_p_0(char *t0)
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
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    unsigned char t14;
    unsigned char t15;
    unsigned char t16;
    unsigned char t17;
    char *t18;
    int t19;
    int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    static char *nl0[] = {&&LAB21, &&LAB19, &&LAB20};
    static char *nl1[] = {&&LAB29, &&LAB30};

LAB0:    xsi_set_current_line(38, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t11 = *((unsigned char *)t2);
    t12 = (t11 == (unsigned char)3);
    if (t12 == 1)
        goto LAB10;

LAB11:    t4 = (unsigned char)0;

LAB12:    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:    t1 = (t0 + 992U);
    t3 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB16;

LAB17:
LAB3:    xsi_set_current_line(104, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 3928U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((unsigned char *)t1) = t3;
    t1 = (t0 + 5344);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(39, ng0);
    t1 = xsi_get_transient_memory(8U);
    memset(t1, 0, 8U);
    t5 = t1;
    memset(t5, (unsigned char)2, 8U);
    t6 = (t0 + 5424);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 8U);
    xsi_driver_first_trans_fast_port(t6);
    xsi_set_current_line(40, ng0);
    t1 = (t0 + 5488);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(41, ng0);
    t1 = (t0 + 5552);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(43, ng0);
    t1 = (t0 + 1672U);
    t7 = *((char **)t1);
    t17 = *((unsigned char *)t7);
    t1 = (t0 + 5616);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t18 = *((char **)t10);
    *((unsigned char *)t18) = t17;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(44, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 5680);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 8U);
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(45, ng0);
    t1 = (t0 + 5744);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(46, ng0);
    t1 = (t0 + 5488);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(49, ng0);
    t3 = ((unsigned char)1 == (unsigned char)1);
    if (t3 != 0)
        goto LAB13;

LAB15:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 5808);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB14:    goto LAB3;

LAB7:    t1 = (t0 + 3928U);
    t6 = *((char **)t1);
    t15 = *((unsigned char *)t6);
    t16 = (t15 == (unsigned char)2);
    t3 = t16;
    goto LAB9;

LAB10:    t1 = (t0 + 2792U);
    t5 = *((char **)t1);
    t13 = *((unsigned char *)t5);
    t14 = (t13 == (unsigned char)0);
    t4 = t14;
    goto LAB12;

LAB13:    xsi_set_current_line(50, ng0);
    t1 = (t0 + 5808);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB14;

LAB16:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 2952U);
    t5 = *((char **)t2);
    t4 = *((unsigned char *)t5);
    t2 = (char *)((nl0) + t4);
    goto **((char **)t2);

LAB18:    goto LAB3;

LAB19:    xsi_set_current_line(58, ng0);
    t11 = ((unsigned char)1 == (unsigned char)1);
    if (t11 != 0)
        goto LAB22;

LAB24:    xsi_set_current_line(61, ng0);
    t1 = (t0 + 5872);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB23:    xsi_set_current_line(64, ng0);
    t1 = (t0 + 5552);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB18;

LAB20:    xsi_set_current_line(66, ng0);
    t3 = ((unsigned char)1 == (unsigned char)1);
    if (t3 != 0)
        goto LAB25;

LAB27:    xsi_set_current_line(69, ng0);
    t1 = (t0 + 5872);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);

LAB26:    xsi_set_current_line(72, ng0);
    t1 = (t0 + 5552);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB18;

LAB21:    xsi_set_current_line(74, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (char *)((nl1) + t3);
    goto **((char **)t1);

LAB22:    xsi_set_current_line(59, ng0);
    t6 = (t0 + 5872);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t6);
    goto LAB23;

LAB25:    xsi_set_current_line(67, ng0);
    t1 = (t0 + 5872);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB26;

LAB28:    goto LAB18;

LAB29:    xsi_set_current_line(76, ng0);
    t5 = (t0 + 5936);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t5);
    xsi_set_current_line(77, ng0);
    t3 = ((unsigned char)1 == (unsigned char)1);
    if (t3 != 0)
        goto LAB31;

LAB33:    xsi_set_current_line(80, ng0);
    t1 = (t0 + 5808);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);

LAB32:    xsi_set_current_line(83, ng0);
    t1 = (t0 + 5744);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(84, ng0);
    t19 = (8 - 1);
    t1 = (t0 + 4048U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = t19;
    goto LAB28;

LAB30:    xsi_set_current_line(86, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB34;

LAB36:    xsi_set_current_line(89, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 4048U);
    t5 = *((char **)t1);
    t19 = *((int *)t5);
    t20 = (t19 - 7);
    t21 = (t20 * -1);
    t22 = (1 * t21);
    t23 = (0U + t22);
    t1 = (t0 + 5424);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t3;
    xsi_driver_first_trans_delta(t1, t23, 1, 0LL);

LAB35:    xsi_set_current_line(92, ng0);
    t1 = (t0 + 4048U);
    t2 = *((char **)t1);
    t19 = *((int *)t2);
    t3 = (t19 == 0);
    if (t3 != 0)
        goto LAB37;

LAB39:    xsi_set_current_line(95, ng0);
    t1 = (t0 + 4048U);
    t2 = *((char **)t1);
    t19 = *((int *)t2);
    t20 = (t19 - 1);
    t1 = (t0 + 4048U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t20;

LAB38:    xsi_set_current_line(98, ng0);
    t1 = (t0 + 5552);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    goto LAB28;

LAB31:    xsi_set_current_line(78, ng0);
    t1 = (t0 + 5808);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB32;

LAB34:    xsi_set_current_line(87, ng0);
    t1 = (t0 + 3112U);
    t5 = *((char **)t1);
    t1 = (t0 + 4048U);
    t6 = *((char **)t1);
    t19 = *((int *)t6);
    t20 = (t19 - 7);
    t21 = (t20 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t19);
    t22 = (1U * t21);
    t23 = (0 + t22);
    t1 = (t5 + t23);
    t11 = *((unsigned char *)t1);
    t7 = (t0 + 5936);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t18 = *((char **)t10);
    *((unsigned char *)t18) = t11;
    xsi_driver_first_trans_fast_port(t7);
    goto LAB35;

LAB37:    xsi_set_current_line(93, ng0);
    t1 = (t0 + 5488);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB38;

}


extern void work_a_3183236722_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3183236722_3212880686_p_0};
	xsi_register_didat("work_a_3183236722_3212880686", "isim/master_test_isim_beh.exe.sim/work/a_3183236722_3212880686.didat");
	xsi_register_executes(pe);
}
