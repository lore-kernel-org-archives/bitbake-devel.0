Return-Path: <enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E478C3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 13:34:18 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web10.79899.1720445651429137315
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jul 2024 06:34:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=IBFY2ims;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: enguerrand.de-ribaucourt@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BF6EE9C5D1A;
	Mon,  8 Jul 2024 09:34:10 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id WKda4T7pnbAi; Mon,  8 Jul 2024 09:34:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 8E5039C5D29;
	Mon,  8 Jul 2024 09:34:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8E5039C5D29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1720445646; bh=n/Hwvskytf09nuz62VplftoeOvsCyqBozG9cz3Z+i7Q=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=IBFY2imsA+f39loLIyiux7ZpSt7sxYSyog1FkWOpHAx9CqxtsoHW716nZrsErx4Rk
	 Bj3xeRyfWy8U+yliobQNxyNPmKGX5zvoD21WEoma4wRjZNU+mKU47WJ2hEP3PsEAoC
	 aCE86UV/vT8vX3AEziQpEr6hLSbwoZ0qt08wqc9K1NKIJmFk8dGlJPu9iCsDk6L7v/
	 08CFNd7NG7tj+ZFsUuVSI2SQSO1f+qoQ3B8aD7aC+h4mSRWNeUdHwnGNwPaHIiZ8Vx
	 54yXxeZfl5Mx+GYJ5eJo1Z61oG0VySz+Kza7d+HU+xmKqIOP0Lh8nG05eju8OdHO2u
	 zWwShu8KL0aLA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7Zh8bpdu_SWe; Mon,  8 Jul 2024 09:34:06 -0400 (EDT)
Received: from sfl-deribaucourt.rennes.sfl (80-15-101-118.ftth.fr.orangecustomers.net [80.15.101.118])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CF2999C5BAC;
	Mon,  8 Jul 2024 09:34:05 -0400 (EDT)
From: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Cc: tanguy.raufflet@savoirfairelinux.com,
	richard.purdie@linuxfoundation.org,
	Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Subject: [PATCH v2 4/4] recipetool: licenses: add common-licenses md5sums
Date: Mon,  8 Jul 2024 15:33:57 +0200
Message-Id: <20240708133357.306422-5-enguerrand.de-ribaucourt@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708133357.306422-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
References: <20240708133357.306422-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 13:34:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16405

Recipetool matches the md5sum of LICENSE or COPYING files for new
recipes based on this csv. It hasn't been updated in a long time.

Compute the md5sum of all files in meta/files/common-licenses so
that more licenses can be matched.

Lines have been sorted alphabetically. Some duplicates were removed with
the more specific license.
(Ex: GPL-2.0-only superseeds GPL-2.0-or-later)

Co-authored-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Tanguy Raufflet <tanguy.raufflet@savoirfairelinux.com>
Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirf=
airelinux.com>
---
 scripts/lib/recipetool/licenses.csv | 461 ++++++++++++++++++++++++++++
 1 file changed, 461 insertions(+)

diff --git a/scripts/lib/recipetool/licenses.csv b/scripts/lib/recipetool=
/licenses.csv
index 80851111b3..2e981d1d63 100644
--- a/scripts/lib/recipetool/licenses.csv
+++ b/scripts/lib/recipetool/licenses.csv
@@ -1,37 +1,498 @@
+009338acda935b3c3a3255af957e6c14,CC-BY-ND-3.0
+009f8a570c2c8e46e505ce6907e4a6e0,OLDAP-1.2
+031c73abe1c92133bd0f02f41a6a5d11,MIT-feh
+03322744a1a73f36ebf29f98cced39a4,GFDL-1.1-only
+03cfa4f20a1ba9d1744c8c970c64e41e,BSD-3-Clause-No-Nuclear-Warranty
+04ba39e3fcdbb1e46c78d56ebc24bcf1,OSL-1.1
+0518d409dae93098cca8dfa932f3ab1b,BSD-2-Clause-Patent
+0557f9d92cf58f2ccdd50f62f8ac0b28,Proprietary
 0636e73ff0215e8d672dc4c32c317bb3,GPL-2.0-only
+0639f02ead7321f9b56065a4c82ab0dc,NBPL-1.0
+06bcb8ed1dec352d24e92f6f39cd138f,AGPL-1.0-only
+06fadd9ae6adbcd5d8d545dac90b15f6,FSF-Unlimited
+07eb6510e14fe74a376fb67157b806a0,Imlib2
+0835ade698e0bcf8506ecda2f7b4f302,MIT
+08ae6a95b08b6b8db33b3ac4700fbeb1,JSON
+0926fd147301b2a65e45e21adb3a6f14,NTP
+09c3ec64e4c518cd72657a2cb1e85095,MTLL
+0a05801c8261ddd5a92e1d9b764d5ad3,SMLNJ
+0bcd48c3bdfef0c9d9fd17726e4b7dab,Apache-2.0-with-LLVM-exception
+0bdd9acccdaec449aedffb518252fa12,CUA-OPL-1.0
+0cce6826431e2f999d7f42258d77511d,AFL-1.2
+0ce1025be0c66b99b205fe41dc9a623a,UCL-1.0
+0ceb3372c9595f0a8067e55da801e4a1,CC0-1.0
+0cf627bfee18ca2ff60e2988ac0feab0,Unicode-DFS-2015
+0e15cb5da9d4f3d5fa9cfa353c837150,Spencer-94
+0e617697318e3f050743deb4b9b817da,gSOAP-1
+0f358dd6677661d482934070c7eeaeec,MIT-advertising
+105fc57d3f4d3122db32912f3e6107d0,Ruby
+1083add59b39991c748ea70a92166959,GFDL-1.3
+11478da101cc77bf8e09ff33b315c3c6,OGL-UK-1.0
+116ebacb8f62900f2668fc68520b23da,SCEA
+1186cebccc11532af57c2bc2e3a2de4a,OGL-Canada-2.0
+127b1c00c0dad2b0296f4e909cc4a547,Intel-ACPI
+12a46e25465f5b0543e1de5823ba3bb3,AFL-3.0
+12b4ec50384c800bc568f519671b120c,Libpng
 12f884d2ae1ff87c09e5b7ccc2c4ca7e,GPL-2.0-only
+147016579566640a7c38f035cf962d40,OFL-1.0
+1490533ce18e36ff799448a8152e5f38,CC-BY-2.5-AU
+14c42911132e8c9008911385aede6449,GPL-2.0-with-GCC-exception
+159ff0ac8f0ae99f92b7e604b3bf02b6,LGPLLR
+15fb3db10a51d0e9ab512a93c9f62925,Simple-2.0
+1773e417ed280d37fb3d4ecadb61d2c4,ZPL-1.1
+17b18da2d8b2c43c598aa7583229ef1b,IPA
+17c115db2c7fcf47125deff9367911fb,BSD-3-Clause-No-Nuclear-License
+1862e5c7c0a6fc7198e4e11f1d58a8ed,Zend-2.0
 18810669f13b87348459e611d31ab760,GPL-2.0-only
+188c8d0bb34589c566accc8322a90f28,RHeCos-1
+1899cb922af9857069381a10e9360db9,D-FSL-1.0
+1a4b0fc1c32cee1fe94f3751b6ccccf7,Plexus
+1a69b36c2473705eb993f4d259f7023a,NASA-1.3
+1a6d268fd218675ffea8be556788b780,LGPL-2.1-only
+1b5fdec70ee13ad8a91667f16c1959d7,NCSA
+1bb6df63159c36c499a4abce384f1035,CC-BY-NC-SA-3.0-IGO
+1c76c4cc354acaac30ed4d5eefea7245,GPL-3.0-or-later
+1cbb64231c94198653282f3ccab88ffb,Sleepycat
+1d1e8bc7e9a4c17f74f873850b116618,eGenix
+1d38e87ed8d522c49f04e1efe0fab3ab,MPL-1.1
+1d4b5ff798479b5b920b5a2d19a65efd,Zimbra-1.4
+1d63716e5a0d424380c8c275b38a684d,Nokia
+1d7133ce407ae41a40678ce53fe146cc,Xnet
+1da3cf8ad50cd8d5d1de3cfc53196d01,BSD-4-Clause-UC
+1ec0cd6f3f76fe56633e150ff591eefe,OLDAP-2.6
+1fa0b366e67cd5d33008da416010adc8,CC-BY-NC-ND-1.0
+1fba3066d8be1a052125a4991003470b,BSD-Protection
+22c9d6c03512270a0c604dfbbe6c2fe1,MulanPSL-1.0
+232368338ef6dc99de71c2e05ff12176,FSFAP
+233c45084b5126b70b8cddbe0852754b,OSET-PL-2.1
 252890d9eee26aab7b432e8b8a616475,LGPL-2.0-only
+2680fce30f17e5fed9bcebd9336e5b78,OFL-1.1-no-RFN
+26811b5196ae54d9ac179032300a411e,TMate
+269cdab4af6748677acce51d9aa13552,SGI-1
+272dea2b67586002978254bc04648ab2,MIT-Modern-Variant
+2742d70a4d048c85e63db1e64a436726,Bahyph
+277261f4a7c6c099822f8f5cb0180da0,CC-BY-NC-SA-4.0
+27b46022df7bdef61a1e404fc3573f83,BSD-3-Clause-Modification
+29046009c1f269661e7b74196fb8f6a0,psutils
+292e8c58674d178944fa3c553a574ab3,ZPL-2.0
+29bea97bd15f0be0384506ba9aa59a9b,CC-BY-SA-3.0-AT
+2a288b1ecac1b81b88207d41ed6f62bb,CECILL-1.1
+2a2abdb5818c49e694d97e402f5fc312,Parity-6.0.0
+2a45f725f5ea99a831c06aa6be09f368,HPND-sell-variant
+2a4f4fd2128ea2f65047ee63fbca9f68,LGPL-2.1-or-later
+2b7c132b054e26675ec8644159bfe90a,Net-SNMP
+2c2cb8af4def8c0bb0c3046ac2c8d514,ImageMagick
+2c7b116933227ab8e62498a916bbfa55,CC-BY-ND-2.0
 2d5025d4aa3495befef8f17206a5b0a1,LGPL-2.1-only
+2db9c02b79795b5997be787ab4e3b130,OLDAP-2.7
+2dd765ca47a05140be15ebafddbeadfe,EPL-2.0
+2e1cd3c142f3ee0c48ac10ad0edfd6a2,CECILL-1.0
+2e3afbc9f35f84c6c6ca5f21cd16f9a5,BUSL-1.1
+2f1142c57bde236bb44607b0207636a9,xinetd
+30c0b8a5048cc2f4be5ff15ef0d8cf61,GPL-1.0-or-later
+316c504405600d20049616655cb331e4,APSL-1.1
 3214f080875748938ba060314b4f727d,LGPL-2.0-only
+3248afbd148270ac7337a6f3e2558be5,CC-BY-SA-3.0
+3363e286b5882ec667a6ebd86e0d9d91,PHP-3.01
+33afa953f9a9ec1c45cff66877723a83,CC-BY-NC-SA-2.0
+342660b06b8c7717c974c19366c80e7a,CECILL-2.1
+343ae07b73a164814623299eeab1e1d9,BitTorrent-1.0
+3535ded4dbb8b9b8c08d529cfd963c83,MS-RL
+3728762dff91f7fc2c26e5470e4fde9d,LAL-1.3
+38534e9743a6e7d2e4d5127d8868e92b,O-UDA-1.0
 385c55653886acac3821999a3ccd17b3,Artistic-1.0 | GPL-2.0-only
 393a5ca445f6965873eca0259a17f833,GPL-2.0-only
+39ac307a6de92199a3ec5ec7e6eeec03,FreeBSD-DOC
+3af632aae8cf01feb6ce2ed44bb7ed2e,SSH-OpenSSH
+3b51ba0e7718dfed153b9a6bcd786cef,CC-PDDC
 3b83ef96387f14655fc854ddc3c6bd57,Apache-2.0
 3bf50002aefd002f49e7bb854063f7e7,LGPL-2.0-only
+3d2da0636f9877a48662c3d180b642d7,NLOD-2.0
+3d473a68d189d64108d78e13c464dd04,PDDL-1.0
+3da0ce0907d870523c2cc5d94d32fad1,Leptonica
+3e11ab81fc86be2c56da7edcb522c967,OLDAP-1.3
+3f12b8134016fd7ba5a010afd690abaa,EUPL-1.1
+3f2f9df7619f1e43eadba2b5c617542e,ODC-By-1.0
+3fb1f5b70ed355def0c7510f0c3ff868,CC-BY-NC-2.5
+405086898d0a61076de2337982808055,ParaTypeFFL-1.3
+40588981e1072d3175e79de8e95d3fb0,SugarCRM-1
+4084714af41157e38872e798eb3fe1b1,CC-BY-SA-4.0
+4157c4506f2d3cf0da1dc51015431b0c,BitstreamVera
+417075eb69f70fcf5a50388bb516af12,LPPL-1.2
+41fa1e32337666d37d19786aebbf3923,EUPL-1.2
+42d04076301ef38862a32199ac00734c,OSL-1.0
+42f47bd574b2eb4a27f42dde3f85d0b2,NPOSL-3.0
+430cb4ba3b3436686366675e95e88673,MakeIndex
 4325afd396febcb659c36b49533135d4,GPL-2.0-only
+438ec6d864bbb958a49df939a56511cf,OSL-3.0
+43c7610db53c3693e0ba4467d7874db9,EPICS
+448c42d4ca4be6f8fb40e0620c8b145f,Linux-OpenIB
+452e1b423688222dcfc3cb9462c92902,bzip2-1.0.4
+4640dac12cf15ff1fc48e2d812d20cd9,GD
+466df5bc4f94b4bad27a2c278fa09f56,DRL-1.0
+470951e1489bb4c347db388f7202c8cc,NOSL
+476efe3fc49aa495b544c2b3da04b8f1,DSDP
+47ed22fa8e5b1ca0cc42ea9c1c1f3aee,xpp
+47f8ee5890ce16863a73c26ea20ea500,OLDAP-2.3
+485f57c05469db83127ef16446766d4f,SGI-B-1.0
+4867a4ecc3b7a760c1e7808a34a58587,SimPL-2.0
+4985c047ad0e40d607a6407b34f18b9a,CC-BY-NC-ND-3.0-IGO
+498d26a501c10739d57fca1c9d80bbc2,ODbL-1.0
+49d7927bc671238531c941f5282a9c62,CC-BY-NC-SA-2.5
+4b1d0384b406508a63e51f7c69687700,W3C
+4b571d5d786c50fbe70381b8c504be7d,CPAL-1.0
+4b962f28acfe06428def53679d1161a5,Fair
+4c6793f966f41313b86a41f9322ee887,TORQUE-1.1
+4d85ad1f393add71dc66bcf78e3ee584,ICU
+4e467e07f5ace155ec63e5c9b1f0ecd1,RSCPL
+4eb1764f3e65fafa1a25057f9082f2ae,OpenSSL
+4eec9c9b063500c9dab38ae621d0b2d6,NRL
 4fbd65380cdd255951079008b364516c,LGPL-2.1-only
+503577dcf1b97fe29e64519f3eb52f93,LiLiQ-P-1.1
+504de64ba3e2c39bb65485686b0e3a33,CNRI-Python
+512a10c9665b4efb9a18d0591d0d2295,psfrag
+5166e505dd5e2073ab1f97b1a6b31755,ZPL-2.1
+5295cd12fc5acc87bf1cf754455a1c56,CPL-1.0
+530c4ffdf84728fd9a65f868ad4ea7ba,gSOAP-1.3b
+5390dc64dbc02ea720da9862c2d833e3,CC-BY-NC-SA-2.0-UK
+546f3980b6203a38e6315ca736813822,CC-BY-ND-2.5
+548a9d1db10cc0a84810c313a0e9266f,pkgconf
 54c7042be62e169199200bc6477f04d1,BSD-3-Clause
+550794465ba0ec5312d6919e203a55f9,BSD-3-Clause
+5569e16f406c52cda34c6707068fd2da,VSL-1.0
 55ca817ccb7d5b5b66355690e9abc605,LGPL-2.0-only
+5697702d6857a5ecf98636ef2a8ff46b,CC-BY-ND-1.0
+569f0c2c33934ff2511e1b129eb4b77d,Entessa
+574109ac4bdff61f9c3e0de892ecbd19,CECILL-2.0
+57f8d5e2b3e98ac6e088986c12bf94e6,EPL-1.0
+58d6eb73a04d4011a4dfdded022807e9,Wsuipa
 59530bdf33659b29e73d4adb9f9f6552,GPL-2.0-only
+5caf8a85d16fc7c611f34630a69540a0,RPSL-1.0
+5e79ee07b35e45e708fcc631c0df4e1e,CC-BY-SA-2.5
+5eb5f8dea32c3a159c3a108c7cba0d59,OLDAP-2.2.1
+5efb1ce72bf097f37048e2f1ad8d132c,OGL-UK-2.0
 5f30f0716dfdd0d91eb439ebec522ec2,LGPL-2.0-only
+5f5dd7bd973dff1594131b1e9c7981f1,SGI-B-2.0
+5f7b23ac10d8f7cde16737bc896bb6fb,TCL
+60c2ef26ff098732959ecfaca4ee293f,CC-BY-NC-1.0
+60c3fab2573aae2a88d7f8c69462de88,Crossword
+6133e6794362eff6641708cfcc075b80,GPL-2.0-with-classpath-exception
+61cc638ff95ff4f38f243855bcec4317,Apache-1.1
+624d9e67e8ac41a78f6b6c2c55a83a2b,BSD-4-Clause
+62bdcd9066e57359cd473e6b7cf69bd3,gnuplot
+634398b133bc1f789f32b278f56fc7df,CPOL-1.02
+6363734dbce8fd58d7c497ae65b16cdf,UCB
+645ff84670453dc664c934a11b9fd001,NetCDF
+65a7df9ad57aacf825fd252c4c33288c,BSL-1.0
+661853fdec2fe9c75df5e7019d349e8b,OCCT-PL
+666362dc5dba74f477af0f44fb85bd22,Unicode-TOU
+676cb7fcf1214ecbe3be420dd5a5b967,GPL-2-with-bison-exception
+676d28582e2dca824e7e309a9865eeb1,Vim
+679365ce5f061c65ce9b2beadb728dc6,CC-BY-NC-SA-1.0
+681ffad43a0addd90f1bebf45675104e,CC-BY-SA-1.0
+684260b3c3c7bf281830da24273d7401,SSPL-1.0
+6945436e301008b0d5bf87b1cc19673e,CDL-1.0
+69e416df0eb517ff13bbb9219da29344,ECL-2.0
 6a6a8e020838b23406c81b19c1d46df6,LGPL-3.0-only
+6a836b2e19f087226df57a014fb871e4,CECILL-B
+6af0c687e05a9af2d3777291cc10341b,CC-BY-3.0-DE
+6b7695daeb4ad458f48d002b1db4bb30,OGDL-Taiwan-1.0
+6c0ff3dae045b3a23cc028a090a7e5b8,SugarCRM-1.1.3
+6c74c6bad0b7f7503f1b80a33c6d6079,OSL-2.0
+6c766ae145b1f282b87773c4fa1ecfd5,AMPAS
+6d2d9952d88b50a51a5c73dc431d06c7,LGPL-2.0-or-later
+6e1bac3dc21fcc4fa049cf5c407eb7a2,GPL-3-with-bison-exception
+6e55b9520d6dadbecd149143b00455dc,RPL-1.5
+6f6d3079515dea35945b13250baf4eff,OLDAP-2.5
+7000797b47d74a5ce02dbae91e4814c9,LPL-1.02
+70f2c3d8942e777809af967d95c66876,SHL-0.5
+71be4bd600c03804e058629b45707e56,NTP-0
+7246f848faa4e9c9fc0ea91122d6e680,Unlicense
+73f1eb20517c55bf9493b7dd6e480788,AGPL-3.0-only
+73f709359181c00178478e8a3b20cda4,CNRI-Jython
+74b1b7a7ee537a16390ed514498bf23c,MulanPSL-2.0
+75075c6d5013fdd3248ae5d6f7a98cd5,CC-BY-NC-ND-2.0
 751419260aa954499f7abaabaa882bbe,GPL-2.0-only
+76c1502273262a5ebefb50dfb20d7c4f,PSF-2.0
+7726eda4b16466f32b70b16bfdb5eb0a,diffmark
+781b4a0e6dc50518d9b876a0877d22f1,MPL-1.0
+78a514775377e847ce6058f458fb5972,BSD-3-Clause-Open-MPI
+79040043c56d4fef36975020dc270420,HaskellReport
+7993e3336259bdb618ad5a1afc872165,WTFPL
+7a08c1d5cc0f8a43d4a02d65fab6e22e,APAFML
+7a434440b651f4a472ca93716d01033a,BSD-3-Clause-Clear
+7afe16775d3dbf5b387812e43d12e235,OLDAP-2.0
+7c1ad6a95981815dbe65a27eefac6bb3,Eurosym
+7cbd681f5f0006d6611ac0ebb9ef1816,etalab-2.0
+7ddd727dfd24eb311bcc7f5fd1f8ff67,ADSL
+7f208af1ee34d97c36ae4ba616d99b15,Newsletr
 7fbc338309ac38fefcd64b04bb903e34,LGPL-2.1-only
+801f80980d171dd6425610833a22dbe6,GPL-2.0-only
+8037c42e05a5d4bfce06a44729fb6f1a,Sendmail
+80d8974849ea3017effd4ad4d2d68a40,CC-BY-SA-2.0-UK
+815ca599c9df247a0c7f619bab123dad,MPL-2.0
+8189d67787b0c83874474b40ecec6262,UPL-1.0
+818e598c8efea97a0f3b1c1b106512f9,NCGL-UK-2.0
+81ff49c3141b3ab7cd5e5ae49ecbc6a6,SAX-PD
+824e3ef3ffe56fe63fd0be5fadca32c3,QPL-1.0
+837570c48d6e224a531b1c5cb31f6831,MIT-enna
+83a1c8ea099b3b58beb6e55dcbe4c15f,Info-ZIP
+83b1f59c3c52689f5652193e0cd5b1cf,TCP-wrappers
+841c5495611ae95b13e80fa4a0627333,bzip2-1.0.6
+842cffb135d8acfd5cd3ef4281efd140,Giftware
+84b4d2c6ef954a2d4081e775a270d0d0,libselinux-1.0
+8743a2c359037d4d329a31e79eabeffe,copyleft-next-0.3.0
+87f08485cf6ba3c63a00eda8ecba7f1d,X11
+87f239f408daca8a157858e192597633,Zlib
+8830efada678f2f7e6eb7039960418dc,CERN-OHL-1.2
+88dfbf7b73c924dc62b8ae9c3bb0337b,AML
+89aea4e17d99a7cacdbeed46a0096b10,Apache-2.0
+89cdf2938f9fba06ef01be9d75801a54,XSkat
+8bbc66f0ba93cec26ef526117e280266,Artistic-2.0
+8bd7e96fbef6cf386505b6dfba6586a2,Adobe-2006
+8c3ea41d02fa9c9253c692351e5940e7,eCos-2.0
+8c667bd3adc7d359cdfb47f4bbd0080a,CC-BY-NC-SA-3.0-DE
 8ca43cbc842c2336e835926c2166c28b,GPL-2.0-only
+8db32780d0d8bbbdce0fa415e514cb89,Beerware
+8e1670967a54b3eb1c60afea27ad2837,W3C-19980720
+8e2e8e1428b39cd78927c2ad28734ff7,LPPL-1.3a
+8f131eff08616d0a4bd642e2707aab2d,ANTLR-PD
+8f45290f66a01a2bd7d3c1a1bee379e5,Motosoto
+8fce5ee68aa617ceaffa5fe6aa788492,TAPR-OHL-1.0
+8fda9a719e1497545e396d0b5d92eaef,AFL-1.1
+8feedd169dbd5738981843bd7d931f9f,Artistic-1.0-Perl
+907371994d651afe53e98adc27824669,Unicode-DFS-2016
+90cddeecef52748c37563b99d2ef1fc4,ANTLR-PD-fallback
+911d82bafafd8b8f2f65d02b6c5dad22,OCLC-2.0
+914d6ca25a35f8c9ee454b52c4e91a3b,Parity-7.0.0
+91501a731d1de5dba677333b7ab0ced7,AMDPLPA
+919f113fcb44c5df8b732d335ebb2797,TU-Berlin-1.0
+91b70218e0db8e063ed88cd532cb801d,MIT-CMU
+91fdbe190a1f86c68e25bc9b1b1893ce,Multics
+9263bb4eebce865da8626ad537b97d8d,LPPL-1.0
+92710048faf09c7db6fbab0b5c68e722,MirOS
+92be1547ea59dfa6f5fa3eb511436611,OGC-1.0
+92cedb99d0471a8acd4ecc7c84b5b3cb,BitTorrent-1.1
+9342e66a3fb8ddeebe449a85366f4acc,RSA-MD
+93f8b671a4e8b1d10e37898c4662e2e2,BSD-3-Clause-Attribution
+9427b8ccf5cf3df47c29110424c9641a,LGPL-2.0-only
+9475885294e17c0cc0067820d042792e,unfs3
+94c046e511122aa69212ae137b55eb9a,JasPer-2.0
 94d55d512a9ba36caa9b7df079bae19f,GPL-2.0-only
+9567c64d58e18a81951c75d00c10fa98,ErlPL-1.1
+95d7aba50e99d173b2a5f125d24a911a,GFDL-1.2
+95e9f67f2840df3a3a09a77ef3aea34b,BlueOak-1.0.0
+963c6a9e5347d93674eda37494dee7f8,copyleft-next-0.3.1
+966c02a95037a9c7ad75a7597aea9c5f,GPL-2.0-with-autoconf-exception
+97a5de7e45c7791fed51f0430da5e021,SGI-B-1.1
+97ba797de74f88a17676473fab224843,Spencer-86
+9803b6df768c3b9adea1260c48449bcd,Naumen
+980c7c3833ef8c21d425cb30a71cf41e,NAIST-2003
+9844d8451b9d4eff66d8f8ef4a55a206,Caldera
+98566c42efca5f49dfd5c8c8f040b419,Glide
+99367d4750dbf0ae6cc74209ddd52f6d,OPUBL-1.0
+9a1fb0fb6574c976ad51dfe77a0b89a3,libpng-2.0
 9ac2e7cff1ddaf48b6eab6028f23ef88,GPL-2.0-only
+9b33bbd06fb58995fb0e299cd38d1838,CC-BY-4.0
+9b6186c48020a9763693332dc4998bc0,EUPL-1.0
+9bc4bd6ef1047c3135cb0b38c17b5f1f,OLDAP-2.0.1
+9c52a15851488b9d3d4d1ff2ce9ebe63,CERN-OHL-W-2.0
+9c7f16ad544b4c9090db061524c4ecbf,GLWTPL
+9cd2300481960fbf3551fee571e0df12,WXwindows
+9cf3c6d8e5e6cbe7cdef8bc218adfc8d,APSL-1.2
+9e4ccb2a5e3ae7d2c4f2ad3f0a8e18c2,Glulxe
+9e4f9cb55403f300a83fb063d1bf1833,Sendmail-8.23
+9ef6c560d1e6dd249eb0a55335500690,EFL-1.0
+9f58808219e9a42ff1228309d6f83dc6,GFDL-1.2-only
 9f604d8a4f8e74f4f5140845a21b6674,LGPL-2.0-only
+9f7a9503b805de9158a2a31a2cef4b70,Apache-1.0
+9ff23a699fca546a380855dd40d12d4f,W3C-20150513
+a06b3606273d78257b0e374217de1087,AAL
+a1038f0f4a3de1fe9e79e2180c40f10c,CC-BY-NC-ND-3.0
+a1cf4d4c2be36962b02896f7f49175f6,OML
+a297b240f382dcdad5bb563a6fa7c3c5,OLDAP-2.1
+a3771b929b1097b53210a4e8da10ed60,CAL-1.0
+a3ab534f25ad82cb6dcfb470a9b2bca0,BSD-3-Clause-LBNL
+a3bc2710d63fa2d3b31618271833da3d,Xerox
+a4448b13b2efa2608ad7372e7e1efd5b,CC-BY-NC-ND-3.0-DE
+a4af3f9f0c0fc9de318e4df46665906e,AGPL-3.0-or-later
+a4f510523c0a44fd4335cbdf941adc9d,PHP-3.0
+a5c8025e305fb49e6d405769358851f6,Python-2.0
+a6eeeed43d498c22a835382533356462,XSL
 a6f89e2100d9b6cdffcea4f398e37343,LGPL-2.1-only
+a7741479921adbee9d03dce48364756d,CC-BY-SA-3.0-DE
+a7c50bba311e4b09d48a526eedcef837,MIT-open-group
+a7f2ef6cf86decfa93ef9f759b59d566,XFree86-1.0
+a85284103c73764f1dc551531a50dba5,APL-1.0
+a9c78964f52e27f4c01140a1a16da8e2,PostgreSQL
+aa229f2c4e4966e222a3f04ff7a8083c,SISSL-1.2
+ab85f6aeae6fce4e9ac8d74990974b86,CC-BY-ND-4.0
+abedf927be332ceb1e491cfba353d6e8,Adobe
+ac16bb7393ecc02c0ad56743f5c7fcd1,CC-BY-3.0-AT
+ac3866fa352ea7b071a9e93172e66dd5,bzip2-1.0.5
+acdf1e4398bd93dc137e271c50316324,OPL-1.0
+ad6660e511dcfe55a177fd53377dea59,Dotseqn
+adacc2c4dd508d9986cfd9465317cd6a,BSD-2-Clause-Views
+ae098e6f49fc0720cbe27319dffe2f48,MITNFA
+aef5f35c9272f508be848cd99e0151df,GPL-3.0-with-GCC-exception
+af880a0f040cb16dc39e66580e1ef6e0,LAL-1.2
+afe664d64109562c3fa9c309bd7f73bc,CC-BY-NC-ND-4.0
+b0566961d94a087aad56740181a35527,dvipdfm
+b059d3cb468ee0d9e6a2c71250ae8107,OASIS
+b05ce303130dcb84b2c437d439bedc2d,NLPL
+b16f082a74b67070bf552dd5a0a6967d,CERN-OHL-P-2.0
 b234ee4d69f5fce4486a80fdaf4a4263,GPL-2.0-only
+b285975b5e439d99c95bcba5b5a8cf39,CC-BY-NC-SA-3.0
+b3597d12946881e13cb3b548d1173851,PD
+b474f10b305d72c6c423807177646dc0,Borceux
+b55b967482208bb2abce2233534a01a0,IBM-pibs
+b597b18461d4ca652c43297c1e22b80c,DSSSL
+b73783010a430cadaabdc8ec0c0748f8,SSH-short
+b79db37a058b24d186ed078d34982463,CC-BY-2.0
+b80cf26a858bf07912ac604409ff4ffa,Hippocratic-2.1
+b8fb22ace48b0b589b0cc6c70e50f73c,Adobe-Glyph
+b948675029f79c64840e78881e91e1d4,SMAIL_GPL
+b99383975855adc28712577c9cd56485,libtiff
+b99c5ef67fc401e28669fc5d3fe2270e,OLDAP-2.2
+b9cbca4f1a399b0c17b3521736e67848,MS-PL
+ba2fa6fe055623756de43a298d88a8b3,LPPL-1.3c
+bb17eba7b7f83e0c108c4df52fdd7694,JPNIC
+bb28ada4fbb5c3f52c233899b2e410a5,OLDAP-2.8
 bbb461211a33b134d42ed5ee802b37ff,LGPL-2.1-only
+bd6163c22201a119540db4a2606b3e1e,LiLiQ-Rplus-1.1
+be2715bfed742616b09ed26eddad5ad2,Abstyles
+be739b8845e6e98f99e206221fe9293b,IPL-1.0
+bf27f7347b03a9fb6376a71c26d5873e,CC-BY-2.5
+bf8e6fec4cb56805c785ffff285cd21f,iMatix
+bf93e21a513f6f923474e62fb920434d,GPL-2.0-with-font-exception
+bfccfe952269fff2b407dd11f2f3083b,LGPL-3.0-only
 bfe1f75d606912a4111c90743d6c7325,MPL-1.1-only
+c18a2eab9bf440520baecdebd5561fc5,CDDL-1.1
+c29f611ea2c44bddf31d68a885cc5d9b,SHL-0.51
+c2a08f01e6d3a42b0942bc5a5a32a3e5,BSD-3-Clause-No-Nuclear-License-2014
+c312e794b0018de67bc843148ecaeea7,CC-BY-ND-3.0-DE
+c3adfa3c8749946e60510facb64bd6cb,CC-BY-3.0-NL
+c503584d3ffbdc4e2ae2351c20e95783,APSL-1.0
+c51d3eef3be114124d11349ca0d7e117,LGPL-3.0-or-later
+c59681d408c615434d0a6e492a7bddc7,RPL-1.1
+c5aab02dae304462b39031effdbc3e5c,Noweb
+c610791f6155b203309becfa6f6f3795,OGTSL
+c76c64e2cf99efcfb5e2b26aa86b12e6,zlib-acknowledgement
+c79ff39f19dfec6d293b95dea7b07891,GPL-3.0-only
+c8a6a9be92f163b6c1ed17d533daa86e,BSD-3-Clause-No-Military-License
+c8f36cbbff0b620fc60e775f65b478ac,OSL-2.1
+c9211dab3ae61e580f48432020784324,GFDL-1.1
 c93c0550bd3173f4504b2cbd8991e50b,GPL-2.0-only
+c9fd4fc0f8d1507270a46df37af8e8e4,CDLA-Permissive-2.0
+cb0f956653d716234754e8487eee962a,Afmparse
+cb641bc04cda31daea161b1bc15da69f,BSD-2-Clause
+ccfcd635757dbd4a5ba7526aa9d8feb6,Barr
+cd9fd5140672e5f5a7972f261415a4c8,CC-BY-NC-SA-2.0-FR
+cda03bbdc3c1951996392b872397b798,Artistic-1.0
+cde69c935d39daae103c6ca3bd5f759d,SMPPL
+ced5efc26449ecac834b4b71625a3410,Intel
+cf203289aa5ab7db7ddf321cafe3d815,EFL-2.0
+d12343a2d67cdff907091c77d9f929af,HTMLTIDY
+d20ec9a5ed8bbd938bad4415b18f5596,Rdisc
+d266657003c8e2b02f66ac8bdd9a2d03,MPL-2.0-no-copyleft-exception
 d32239bcb673463ab874e80d47fae504,GPL-3.0-only
+d4316699a62681192cd0a75a136e47bc,NIST-PD-fallback
+d5311495d952062e0e4fbba39cbf3de1,LGPL-3.0-with-zeromq-exception
+d5407b61870d6dc19d0bdc04ae4cc654,blessing
+d56cfe8f3043d810b4ea9efec2d443d4,BSD-4-Clause-Shortened
+d63919ac66adfeaf1f51e0c9ea9c19f9,ECL-1.0
+d63dcc9297f2efd6c18d1e560b807bc6,CDDL-1.0
 d7810fab7487fb0aad327b76f1be7cd7,GPL-2.0-only
+d7f86b208ceac65fdbe19b2b9fcf4b28,Zed
 d8045f3b8f929c1cb29a1e3fd737b499,LGPL-2.1-only
+d8cb48d540d878b981f2f6b8c09f8107,Saxpath
+d91509a59f42bb5341a8af8295f28211,CC-BY-SA-2.0
+d91547d52af2576c8050a25f4a8cf296,TOSL
+d93dee0d11742aa64d04dafeb9ad789d,CrystalStacker
+d97a6df8bcb5a3ffd6932e9ad9e3f6b6,VOSTROM
+d9e4412f125e3e6f14efba8ce7b4604f,GPL-2.0-with-OpenSSL-exception
+d9f6cdb08c684151d839756e8b04e8db,LPPL-1.1
+d9fc5ebaa95c14466091d25e0d34e688,IJG
+da1851bbe489fa73c523fe36236086a2,OLDAP-1.4
+da26b415cb0faf9bfe6829f0ffa409ec,GPL-3.0-with-autoconf-exception
+da42cb2460f2c6eea098e6705ed1c103,NLOD-1.0
+da4dd8d7a88833faa0c3253f951da0ec,OLDAP-2.2.2
+da665b47544b8cf138600d9e2aeefadd,CC-BY-NC-3.0
+db8d48938582bc7b10c608728da229d1,TU-Berlin-2.0
+db8def9d9625b54d39e485d2203a25bf,CDLA-Permissive-1.0
 db979804f025cf55aabec7129cb671ed,LGPL-2.0-only
+dbb00b2869645074b4e695aec992df10,CATOSL-1.1
+dbb49d86a7b9dd0868cf565a3cdd90bd,OGL-UK-3.0
+dc74327e8d4dca295527a090d2af4ba4,FSFUL
+ddb159145fcbc01a88734aab1cb59174,Spencer-99
+de4d02d928802a50f2fe5bc021f81b21,CC-BY-NC-4.0
+de61e8e359a18f44efdb91f6d020e73b,CECILL-C
+dea3f591dd4e2a7a6c00644c29d38755,Artistic-1.0-cl8
+dfa02b5755629022e267f10b9c0a2ab7,CC-BY-3.0
+e06be17b8577bf6e2277a5c3c71b2d05,EDL-1.0
+e0771ae6a62dc8a2e50b1d450fea66b7,GFDL-1.3-only
+e0a34c06921abf8464e4e60b7097fc64,SNIA
+e1b141d75eb69dca77dedffa72ab8099,CC-BY-1.0
+e1ca9c263e0eb0d888ee6679bf8e8b14,RHeCos-1.1
+e332583a335d1c483a9a765eda62ce51,SWL
+e3cdd21422615e65cfb61d66efb6695b,NIST-PD
+e40039b90e182a056bcd9ad3e47ddd71,AFL-2.1
+e54c225891056b4b5b9aedf720324c48,CERN-OHL-S-2.0
+e86181756ea84a3a6c838c57187c0e48,CC-BY-3.0-US
+e892ccb8a79a01d14b523fe6d902e1cd,PolyForm-Small-Business-1.0.0
+e937cec4476e354e700e70f8184ba255,CC-BY-NC-3.0-DE
+e9e36a9de734199567a4d769498f743d,GPL-1.0-only
+eabd0ee63562be8b63dcf842f2ff7932,XFree86-1.1
+ead0c25f1f54544531a30118cf0f1c0a,Qhull
+eb44fbd1496ddcfd5d28b73ee48c849f,EUDatagrid
+eb459fd0027ee7bd45ddc87041d0dac0,CC-BY-NC-2.0
 eb723b61539feef013de476e68b5c50a,GPL-2.0-only
+eba216effbb501d5a27143374c96cec2,NGPL
+ebb580f32931868a8a238b01eeeedf29,DOC
 ebb5c50ab7cab4baeffba14977030c07,GPL-2.0-only
+ecfc027911d191ac143b128048e03420,SPL-1.0
+ed1e505c4fc33fec82d32064c8aeb15b,OLDAP-2.4
+edf587adfe362e8571448b184e222baf,OLDAP-1.1
+ef91d258f6a8d4d7f4db4d30adf38598,Latex2e
+efc38ad5089e7c3314adca7c4eb8351b,CNRI-Python-GPL-Compatible
+efd7b41ec0e3fde64acd215334ac4436,LPL-1.0
+f01c02e5eac69cff6b8c2cc474b8d468,AFL-2.0
+f0549e909c5da7d62703007d82e606cf,Aladdin
+f0aa4b452548cc5d53a7772a9a90b3c0,FSFULLR
+f0bf6b09ee8b02121ed10709d9e49d8b,FTL
+f163acc1f7bf0b7978bb29b2b46dd864,Frameworx-1.0
+f241646acc4eeceb4b2d1496385609ef,GL2PS
 f27defe1e96c2e1ecd4e0c9be8967949,GPL-3.0-only
+f30403bda2a18f780f897079cd662d57,mpich2
+f3b90e78ea0cffb20bf5cca7947a896d,ISC
+f41b3a5f969eb450434cf0e4f33449b9,MIT-0
+f4abd544e57b717e3211a8f71fb78051,YPL-1.1
+f590cf750bd365fdd1b41da8c7d4cd82,CERN-OHL-1.1
+f60e3dd4c8ecd9ef8c12216ad198b70e,Cube
+f633bbf0697ec33066b83adfa9ebe51d,ClArtistic
+f65304bc0e87e6700fe1e4ab5affdc6f,Interbase-1.0
+f667a3c3830a55a17ec3067709f4526c,0BSD
+f6971d785145ff1e92dc69dc4167da07,CC-BY-SA-2.1-JP
+f6d4e2e69d4b50159124bde6a16a11a9,CDLA-Sharing-1.0
+f7adb1397db248527ffed14d947e445c,curl
+f84539e411677753163564553d0314f4,Watcom-1.0
+f894ae2ca273737325e332d44dd5bdf3,C-UDA-1.0
+f89765972ccf05ec2c6727775bbd35e6,YPL-1.0
+f9339183804ba3d5e9769247477764f7,CC-BY-NC-ND-2.5
+f9c017c062c1b02462efb915d9f2cb63,NPL-1.1
+f9cbd56c0b114af37c44d6f127cd9fbe,FreeImage
+f9e4701d9a216a87ba145bbe25f54c58,APSL-2.0
+fa4f6eb8206bcfb6954542687e669418,PolyForm-Noncommercial-1.0.0
+faa364b3e3c6db0f74cc0e704ddf6b9c,HPND
+fac3a519e5e9eb96316656e0ca4f2b90,OFL-1.1
 fad9b3332be894bab9bc501572864b29,LGPL-2.1-only
+faf775436c2359467177f2e0dbd891c4,LiLiQ-R-1.1
+fb195e1b4b5cc0cb2c17c5a4fd793cd8,BSD-1-Clause
+fb9ceca80dbcd24694c510c689a6e19a,NPL-1.0
 fbc093901857fcd118f065f900982c24,LGPL-2.1-only
+fc018a7d79dee1e8498e07e632a83895,Condor-1.1
+fd1a6fb4c99f4f8f014b2c4aa2e0010a,Mup
+fded06bff75eb4a2899bd051e2e128f5,SISSL
+fe2ad80d298893f7c3958dc8cd5560b2,Zimbra-1.3
+fe8b41221d7524c70688f7d059ff6d87,BSD-Source-Code
+fed54355545ffd980b814dab4a3b312c,GPL-2.0-or-later
--=20
2.34.1


