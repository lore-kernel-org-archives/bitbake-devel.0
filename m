Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SArc8-0001ys-Di
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 00:40:17 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 16:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124076805"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 16:31:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 16:31:06 -0700
Message-Id: <138185b2c5a7bd79919a70cf6a7786fd27978c8d.1332458487.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
Subject: [PATCH 1/9] lib/bb/ui/icons: add new icons for use in Hob, autocrop some existing ones
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
X-List-Received-Date: Thu, 22 Mar 2012 23:40:17 -0000

Add add-hover and remove-hover icons for the Layer Selection Dialogue.
Autocrop layers_hover, packages_hover and recipe_hover images.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/icons/indicators/add-hover.png    |  Bin 0 -> 1212 bytes
 lib/bb/ui/icons/indicators/remove-hover.png |  Bin 0 -> 2809 bytes
 lib/bb/ui/icons/layers/layers_hover.png     |  Bin 5390 -> 5257 bytes
 lib/bb/ui/icons/packages/packages_hover.png |  Bin 7308 -> 7121 bytes
 lib/bb/ui/icons/recipe/recipe_hover.png     |  Bin 5003 -> 4866 bytes
 5 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 lib/bb/ui/icons/indicators/add-hover.png
 create mode 100644 lib/bb/ui/icons/indicators/remove-hover.png

diff --git a/lib/bb/ui/icons/indicators/add-hover.png b/lib/bb/ui/icons/indicators/add-hover.png
new file mode 100644
index 0000000000000000000000000000000000000000..526df770d15e987affb17aa359b48fa991676d07
GIT binary patch
literal 1212
zcmV;t1Vj6YP)<h;3K|Lk000e1NJLTq0012T0015c1^@s6&<7Qv00001b5ch_0Itp)
z=>Px#24YJ`L;(K){{a7>y{D4^000SaNLh0L01FcU01FcV0GgZ_00007bV*G`2iyY|
z5-uABI<vU|00cZqL_t(Y$F*0xjvPf4J$38VUERI&*qsF<TMnGqNS1M8ksx6*{0k8A
z3-|-P8R7$+kR!)N&Pi+}A{;wF2n$%t(z5n+Pj^*U6+zRz(|FijFUuX3W`gc}>ejvI
z)EO3I#6KfX^5HjQ44iXFC83r6UP_sB!9k1=Vu1G^&N<k|e(aoEdhhY7dWGXc;DjI|
zD5a2^6pO{;L(aL@T7wG?-+EYUQB@Uge{wr}@a=<T(=;cg+zc9VR6TKmR1!r|VE3I}
zZj3>eWl&ndIfrst;^5!_+dJE&w1Rc^Y@qAG7=uy@S)O4&pJO_kVmh57NfI<ogTuo^
zaKWLqhEfWg^K$?tHYCmS9Fyq;v-u3h7}RwQMhsO|K}rcB1Q=uI015^of)D~qE2L?P
z{)mYP^{R%}8bk!*bShB7+s5DR-Zb^64LU7Qj1e(LgcuOQ+KS<51MxgTaa3Il-5LRh
z4!HlEsi*4`$T=VNDq>u1j1i2nK|}->CxdQJw?E*V-{PEuhyVr@TgC7|q7xWnpc4(o
z7-L}FF^4cxtS673e4eK1VU}gMc;Vu>;)r3Bt#5x4SKq(-*^B)bcct1q@=7TbMS(oe
zLA;w#07I2T1f>;-)7R746r6K3O)~<GF%Igrv$OM!xPJZmrKkSspfW_`HcKIqrYVZ8
z0>&5!Ax6_Hgg~06n9XM3oTDfTw5}b4hKQzVP*oMKUAuNkWG2Jz?k*<N35+psfO5_u
zrG!p2GLu0{IjWR%4r2@u0b>lDbMW4eC>27$YPG`QpNGiv971V@t;rVV^Et9C0~cc%
zBSs)1aKRyk1Y=!K`@}>9DJ8NzgHAMp?`X6hzV#@}5-~>TL_-K6kR-{VG(w7v`r9u6
z@ZJyL{Y})%;3m;%+ZHj#PA-M)DAPaqZyZ}s)Kg@5XYKnqmFjaxM2O3mFaNSwEPl)L
z96Hf&^t7*#i16&$vv(O|L_`B{PlYR2uKd9m3!A`02(XRC^1>2Y>z`SS@fLuOPNPVB
zdwX9oFd>8haq4*2wy@UX?w5D(O=r{PDboDNHXX^GPwyP5hY-+OBg-=EEOwlfQY1+N
zAq2elsOuV4S>fi*o9{h(^yv4xuJQ1@hi@-~&wqV>#8V}anGBQZ1gYtUO-c#QdFPL;
zLs^z6s}lSB`zXuuY})(s<;#&G*}{T|uv)FqPkRWRDYMREwOXNG)i^jf!0T79&jz}D
zy&QoO5sWdg)}n1&c<%?$zNgMPRAq&7dB#eeb0as{14SP@@~>ZOJ`9^^+jjKs`CQ_N
z10RQl_&+&^HDP$eIjr5Q=jt3bR@jTc8LZNYW;?_%{`+7pdKYi4MPnN{=eofP9s%LM
zTTlQ9KESmO_xA4nz&SU93otsmZCclY5i9TCzkjOAPXz6!vZ))~xN+l)V_LHGtsiX6
aaq$<Pz=q4^7&NT_0000<MNUMnLSTYc+AEI$

literal 0
HcmV?d00001

diff --git a/lib/bb/ui/icons/indicators/remove-hover.png b/lib/bb/ui/icons/indicators/remove-hover.png
new file mode 100644
index 0000000000000000000000000000000000000000..aa57c6998259206a578eaa6af1a0ee77f160d9cb
GIT binary patch
literal 2809
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
LNkvXXu0mjf0|Q_@

literal 0
HcmV?d00001

diff --git a/lib/bb/ui/icons/layers/layers_hover.png b/lib/bb/ui/icons/layers/layers_hover.png
index 5e5c3b93ec83c0d557cb09519868b434144cd56a..0bf3ce0dbc9cb52b74c8815ad65958cc3b14c721 100644
GIT binary patch
delta 2613
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
XolcwJk{Vx$00000NkvXXu0mjfI5Fh%

delta 2750
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
Eg3--4ga7~l

diff --git a/lib/bb/ui/icons/packages/packages_hover.png b/lib/bb/ui/icons/packages/packages_hover.png
index f71db227d5d7e030734814e968b588af5e082ce5..c081165f34e9743c5550902c8318e2a80b6fcd4d 100644
GIT binary patch
delta 4492
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

delta 4683
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
N002ovPDHLkV1lYu6ubZc

diff --git a/lib/bb/ui/icons/recipe/recipe_hover.png b/lib/bb/ui/icons/recipe/recipe_hover.png
index 246bfd5b3480cb1f2e982572ae918e3039c87d7b..7e48da9af0bfdc763279f41e0aaf11a5c6fd611d 100644
GIT binary patch
delta 2219
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

delta 2360
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

-- 
1.7.7.6



