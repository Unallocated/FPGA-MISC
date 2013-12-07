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
static const char *ng0 = "/root/FPGA-MISC/Serial_SRAM/test_one.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );


static void work_a_3601322884_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    int t15;
    int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned char t19;
    static char *nl0[] = {&&LAB25, &&LAB26, &&LAB27, &&LAB28, &&LAB29};

LAB0:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 3072U);
    t3 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 5584);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(80, ng0);
    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(81, ng0);
    t1 = (t0 + 5664);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(82, ng0);
    t1 = (t0 + 5728);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(83, ng0);
    t1 = (t0 + 5792);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(84, ng0);
    t1 = (t0 + 9227);
    t5 = (t0 + 4288U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    memcpy(t5, t1, 2U);
    goto LAB3;

LAB5:    xsi_set_current_line(86, ng0);
    t2 = (t0 + 4288U);
    t5 = *((char **)t2);
    t2 = (t0 + 9229);
    t4 = 1;
    if (2U == 2U)
        goto LAB10;

LAB11:    t4 = 0;

LAB12:    if (t4 != 0)
        goto LAB7;

LAB9:    t1 = (t0 + 4288U);
    t2 = *((char **)t1);
    t1 = (t0 + 9233);
    t3 = 1;
    if (2U == 2U)
        goto LAB18;

LAB19:    t3 = 0;

LAB20:    if (t3 != 0)
        goto LAB16;

LAB17:    xsi_set_current_line(93, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (char *)((nl0) + t3);
    goto **((char **)t1);

LAB7:    xsi_set_current_line(87, ng0);
    t10 = (t0 + 5856);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(88, ng0);
    t1 = (t0 + 9231);
    t5 = (t0 + 4288U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    memcpy(t5, t1, 2U);

LAB8:    goto LAB3;

LAB10:    t8 = 0;

LAB13:    if (t8 < 2U)
        goto LAB14;
    else
        goto LAB12;

LAB14:    t7 = (t5 + t8);
    t9 = (t2 + t8);
    if (*((unsigned char *)t7) != *((unsigned char *)t9))
        goto LAB11;

LAB15:    t8 = (t8 + 1);
    goto LAB13;

LAB16:    xsi_set_current_line(90, ng0);
    t9 = (t0 + 5856);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t9);
    xsi_set_current_line(91, ng0);
    t1 = (t0 + 9235);
    t5 = (t0 + 4288U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    memcpy(t5, t1, 2U);
    goto LAB8;

LAB18:    t8 = 0;

LAB21:    if (t8 < 2U)
        goto LAB22;
    else
        goto LAB20;

LAB22:    t6 = (t2 + t8);
    t7 = (t1 + t8);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB19;

LAB23:    t8 = (t8 + 1);
    goto LAB21;

LAB24:    goto LAB8;

LAB25:    xsi_set_current_line(95, ng0);
    t5 = (t0 + 5728);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(96, ng0);
    t1 = (t0 + 5792);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(97, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 7;
    xsi_set_current_line(98, ng0);
    t1 = (t0 + 5920);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(99, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB30;

LAB32:
LAB31:    goto LAB24;

LAB26:    xsi_set_current_line(108, ng0);
    t1 = (t0 + 5792);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(109, ng0);
    t1 = (t0 + 5728);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(110, ng0);
    t1 = (t0 + 4168U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB33;

LAB35:    xsi_set_current_line(113, ng0);
    t1 = (t0 + 3568U);
    t2 = *((char **)t1);
    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t15 = *((int *)t5);
    t16 = (t15 - 7);
    t8 = (t16 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t15);
    t17 = (1U * t8);
    t18 = (0 + t17);
    t1 = (t2 + t18);
    t3 = *((unsigned char *)t1);
    t6 = (t0 + 5920);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = t3;
    xsi_driver_first_trans_fast_port(t6);

LAB34:    xsi_set_current_line(116, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t3 = (t15 == 0);
    if (t3 != 0)
        goto LAB36;

LAB38:    xsi_set_current_line(120, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t16 = (t15 - 1);
    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t16;

LAB37:    xsi_set_current_line(123, ng0);
    t1 = (t0 + 9237);
    t5 = (t0 + 4288U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    memcpy(t5, t1, 2U);
    goto LAB24;

LAB27:    xsi_set_current_line(125, ng0);
    t1 = (t0 + 3928U);
    t2 = *((char **)t1);
    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t15 = *((int *)t5);
    t16 = (t15 - 15);
    t8 = (t16 * -1);
    xsi_vhdl_check_range_of_index(15, 0, -1, t15);
    t17 = (1U * t8);
    t18 = (0 + t17);
    t1 = (t2 + t18);
    t3 = *((unsigned char *)t1);
    t6 = (t0 + 5920);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = t3;
    xsi_driver_first_trans_fast_port(t6);
    xsi_set_current_line(126, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t3 = (t15 == 0);
    if (t3 != 0)
        goto LAB46;

LAB48:    xsi_set_current_line(134, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t16 = (t15 - 1);
    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t16;

LAB47:    xsi_set_current_line(137, ng0);
    t1 = (t0 + 9239);
    t5 = (t0 + 4288U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    memcpy(t5, t1, 2U);
    goto LAB24;

LAB28:    xsi_set_current_line(139, ng0);
    t1 = (t0 + 4048U);
    t2 = *((char **)t1);
    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t15 = *((int *)t5);
    t16 = (t15 - 7);
    t8 = (t16 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t15);
    t17 = (1U * t8);
    t18 = (0 + t17);
    t1 = (t2 + t18);
    t3 = *((unsigned char *)t1);
    t6 = (t0 + 5920);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = t3;
    xsi_driver_first_trans_fast_port(t6);
    xsi_set_current_line(140, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t3 = (t15 == 0);
    if (t3 != 0)
        goto LAB59;

LAB61:    xsi_set_current_line(144, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t16 = (t15 - 1);
    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t16;

LAB60:    xsi_set_current_line(147, ng0);
    t1 = (t0 + 9241);
    t5 = (t0 + 4288U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    memcpy(t5, t1, 2U);
    goto LAB24;

LAB29:    xsi_set_current_line(149, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 4048U);
    t5 = *((char **)t1);
    t1 = (t0 + 3808U);
    t6 = *((char **)t1);
    t15 = *((int *)t6);
    t16 = (t15 - 7);
    t8 = (t16 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t15);
    t17 = (1U * t8);
    t18 = (0 + t17);
    t1 = (t5 + t18);
    *((unsigned char *)t1) = t3;
    xsi_set_current_line(150, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t3 = (t15 == 0);
    if (t3 != 0)
        goto LAB62;

LAB64:    xsi_set_current_line(155, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t15 = *((int *)t2);
    t16 = (t15 - 1);
    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t16;

LAB63:    xsi_set_current_line(157, ng0);
    t1 = (t0 + 9243);
    t5 = (t0 + 4288U);
    t6 = *((char **)t5);
    t5 = (t6 + 0);
    memcpy(t5, t1, 2U);
    goto LAB24;

LAB30:    xsi_set_current_line(100, ng0);
    t1 = (t0 + 5664);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    *((unsigned char *)t9) = (unsigned char)1;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(101, ng0);
    t1 = (t0 + 5792);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(102, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 4168U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((unsigned char *)t1) = t3;
    xsi_set_current_line(103, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 4048U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    memcpy(t1, t2, 8U);
    xsi_set_current_line(104, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 3928U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    memcpy(t1, t2, 16U);
    goto LAB31;

LAB33:    xsi_set_current_line(111, ng0);
    t1 = (t0 + 3688U);
    t5 = *((char **)t1);
    t1 = (t0 + 3808U);
    t6 = *((char **)t1);
    t15 = *((int *)t6);
    t16 = (t15 - 7);
    t8 = (t16 * -1);
    xsi_vhdl_check_range_of_index(7, 0, -1, t15);
    t17 = (1U * t8);
    t18 = (0 + t17);
    t1 = (t5 + t18);
    t19 = *((unsigned char *)t1);
    t7 = (t0 + 5920);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = t19;
    xsi_driver_first_trans_fast_port(t7);
    goto LAB34;

LAB36:    xsi_set_current_line(117, ng0);
    if (15 > 0)
        goto LAB39;

LAB40:    if (-1 == -1)
        goto LAB44;

LAB45:    t16 = 0;

LAB41:    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t16;
    xsi_set_current_line(118, ng0);
    t1 = (t0 + 5664);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB37;

LAB39:    if (-1 == 1)
        goto LAB42;

LAB43:    t16 = 15;
    goto LAB41;

LAB42:    t16 = 0;
    goto LAB41;

LAB44:    t16 = 15;
    goto LAB41;

LAB46:    xsi_set_current_line(127, ng0);
    if (7 > 0)
        goto LAB49;

LAB50:    if (-1 == -1)
        goto LAB54;

LAB55:    t16 = 0;

LAB51:    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = t16;
    xsi_set_current_line(128, ng0);
    t1 = (t0 + 4168U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB56;

LAB58:    xsi_set_current_line(131, ng0);
    t1 = (t0 + 5664);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)4;
    xsi_driver_first_trans_fast(t1);

LAB57:    goto LAB47;

LAB49:    if (-1 == 1)
        goto LAB52;

LAB53:    t16 = 7;
    goto LAB51;

LAB52:    t16 = 0;
    goto LAB51;

LAB54:    t16 = 7;
    goto LAB51;

LAB56:    xsi_set_current_line(129, ng0);
    t1 = (t0 + 5664);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);
    goto LAB57;

LAB59:    xsi_set_current_line(141, ng0);
    t1 = (t0 + 3808U);
    t5 = *((char **)t1);
    t1 = (t5 + 0);
    *((int *)t1) = 0;
    xsi_set_current_line(142, ng0);
    t1 = (t0 + 5664);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    goto LAB60;

LAB62:    xsi_set_current_line(151, ng0);
    t1 = (t0 + 5664);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    *((unsigned char *)t9) = (unsigned char)0;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(152, ng0);
    t1 = (t0 + 4048U);
    t2 = *((char **)t1);
    t1 = (t0 + 5984);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t9 = *((char **)t7);
    memcpy(t9, t2, 8U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(153, ng0);
    t1 = (t0 + 3808U);
    t2 = *((char **)t1);
    t1 = (t2 + 0);
    *((int *)t1) = 0;
    goto LAB63;

}


extern void work_a_3601322884_3212880686_init()
{
	static char *pe[] = {(void *)work_a_3601322884_3212880686_p_0};
	xsi_register_didat("work_a_3601322884_3212880686", "isim/test_isim_beh.exe.sim/work/a_3601322884_3212880686.didat");
	xsi_register_executes(pe);
}
