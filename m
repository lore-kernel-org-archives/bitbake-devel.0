Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAXcm-0000Mz-86
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 03:19:36 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 19:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131778624"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.222])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 19:10:38 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 19:10:33 -0700
Message-Id: <6688e1ab38002332d09f3283687b116c657643f6.1332381654.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
Subject: [PATCH 08/10] lib/bb/ui/crumbs: add icons for use in the layer dialogue
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 22 Mar 2012 02:19:38 -0000

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py         |    2 ++
 lib/bb/ui/icons/indicators/add.png    |  Bin 0 -> 1176 bytes
 lib/bb/ui/icons/indicators/remove.png |  Bin 0 -> 1971 bytes
 3 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 lib/bb/ui/icons/indicators/add.png
 create mode 100644 lib/bb/ui/icons/indicators/remove.png

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index df3f607..f283325 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -53,6 +53,8 @@ class hic:
     ICON_INFO_HOVER_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('info/info_hover.png'))
     ICON_INDI_CONFIRM_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('indicators/confirmation.png'))
     ICON_INDI_ERROR_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('indicators/error.png'))
+    ICON_INDI_REMOVE              = os.path.join(HOB_ICON_BASE_DIR, ('indicators/remove.png'))
+    ICON_INDI_ADD                 = os.path.join(HOB_ICON_BASE_DIR, ('indicators/add.png'))
 
 class hcc:
 
diff --git a/lib/bb/ui/icons/indicators/add.png b/lib/bb/ui/icons/indicators/add.png
new file mode 100644
index 0000000000000000000000000000000000000000..31e7090d616fcca92456ed11ecc6aabc1b015039
GIT binary patch
literal 1176
zcmV;J1ZVq+P)<h;3K|Lk000e1NJLTq0012T0015c1^@s6&<7Qv00001b5ch_0Itp)
z=>Px#24YJ`L;(K){{a7>y{D4^000SaNLh0L01FcU01FcV0GgZ_00007bV*G`2iyY{
z79k~8f3@!b00bCGL_t(Y$E}vVZX`t%g-`u=_w)?b*j^CQW)93c!K}0*LBf`nm%xv~
z0}vu|N91S&Cw>775gN(j0gzTCUZizkykq*Os_rFdx@UT3Y|q$~)ankZ>#KX~o^wku
zGv-I;vhG_50i_hQ)-cBWqP5PIQV>#ri4iFxgaBXruR{nEBEqDY;J%^pz>rcxYmFpH
zFy0)0DTHv=S}3IuV}$n}Wm)3&H?Ie8ett8l>-wQ3SA!a3Fc=K5wY8;;HAvGG#u$VU
zP!t6|+<d_1cvD(y5khzzlrfWX0cfL<qzQ(jAqIm1hQlGOv+%XYWHM<sW(|~S(*EQ~
z+cUM+BFi%5!yKcJMo5wbRaHR<fwC;2wT4z2Li`WV7A%#7(hb}>2j?6BptKE82mv9*
zN>GV)2LsD0ex0H3T6iA9#GOPa5@L*qvH2#VW+SxPhU7ZY5m5uA*g+#j5Ye;%`H_(-
zrFxQS&x)BrO#MjPC;><zd;i`E9p$6Xl~S*ylua=Rfiz3I3C0?@#6cSkW)=V%@GMM8
zoSmH=*~I?sYKQI3?S7(|r<o%9UGMJhetY@u@;jqVv&*^SGsYmxGNfq=h^CT>sEblS
zKx+*m`Z3RQNGaiK-`6^$aj)R<?Bi!Y>Ak(Z=ePgdB27|gqameSNVRhgS(d?B2Pq|(
z88JpMGlUed#v&g!z%0uaT#1?CYmc%j@#3==&$UY&Ha0de$OmxFEkLD|&`QHt1M6%L
zN<<Jsz&eYZb2#e|LTFMy6Dbj)u4>%g-Xcj7Xk!f0EJZ%Zk)#QfoGS#;fR$8GO7(!<
znMw)gT$|>F3XT*}ni50=V+^#E5=I+XYteR(c{iGUw*@hqy4EV&EX`}R)v__B$y`@i
zOpO6ZUO10s@MUxEGKOw#W-u6fXJ_Zn@pychrppVd)t`_87Z(?wFtco>H7kYv{r$g`
zQZ$=|Zd1hY!J{lnj7Fokf|*|d_-YknIyyS~fg)+CWUrt?2sl1I{(gIVd$PhZ=VDn(
zUVia%8l`HQc;XU_$79c6ZA_zSB7*lGRaxQi@bJ@<laqJedz}AvzP=4!U0qElXx-^F
zNfT(*9Dxv`y&It@3zTJv>+5S&W%W4ky}7yRL0dPfstRNXN-GE<5MxB`YgAQ*x~?&q
zOi&cX<Dg|(_Mk!vwD+GDCZ+65-+PY`1FEX({ks-4hS<|71)BCwMXhmn-KN!H46*m`
z<NGO3`{YcgXrBM{M@%dA(e;}+rUtSMyl{(rDwM(9m8I>a?KA5%t46C=jkN8d0N}On
zjKPPdh<fmcZkNl<!DzGCPX`%JPfvf9Qf94ATN{iq!f11NaBy%_RTYY|cskS=gCt4t
q{_6eCJxB7#XgH#}u2EL^%jRFlS+4>mx`C(w0000<MNUMnLSTZjj~4;}

literal 0
HcmV?d00001

diff --git a/lib/bb/ui/icons/indicators/remove.png b/lib/bb/ui/icons/indicators/remove.png
new file mode 100644
index 0000000000000000000000000000000000000000..05c3c293d4bc0d9e8aac7b28fb25e43ff8a03320
GIT binary patch
literal 1971
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
FV1mkSswV&d

literal 0
HcmV?d00001

-- 
1.7.7.6



