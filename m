Return-Path: <t_dufff@yahoo.ca>
Received: from sonic309-16.consmr.mail.bf2.yahoo.com
	(sonic309-16.consmr.mail.bf2.yahoo.com [74.6.129.126])
	by mail.openembedded.org (Postfix) with ESMTP id 67A59782E1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Jul 2017 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048;
	t=1500929882; bh=O0CzQv2sTDFetXn9nOH32MhJTCtePt5szwIo0PxClDw=;
	h=Date:From:Reply-To:To:Subject:References:From:Subject;
	b=D0KZuowRb1QVyCCX9K970LmLBWMOWL7OQMNq0eYpbgMWEt8VcX4Cj8wwzx5SOfUZjobkZ0X93COUOrGYKPPpuPzMqIY4MEh7sOU3CAFT2+1/eglU/r0t277hvoc8wzokkkZPezZA6WeA4oSgLdHO6SwgMtsSX2KJWAdzrRphJKB3UIIVYgBAui32y9SjFTfMgqFtQSO2eHu6lxzHUJm+U25abAovoR7ugkD2/jsE5ihYClFgO6YdkIST3iS/+TxkF3voNc1Hk6LP2GlUGH4yhHyUhNCxH4lV16nVndxfRDAM5Y5kCd7ylzKqlkucYi1Ut/2yTmiKOMCOf555E9dgzA==
X-YMail-OSG: btpvOQcVM1kZFPx.1RYr9r3EMkx9U2Jt6pv4QN3QbhzJbmj0M7kNDxvWp7iHz3z
	z3oITWHdP8lQ6ukOfTCqem0sLb8vPcpP8ui7GpewODo_7yNrO5sbZr6hWpIeYlU2fuUNvzB_qfvG
	wk80GercHFp5VOlWqQ_.9tokRWbRMdAbQFgYGqevKnsnvtQ_Em2XIoi2PTMt9B8jR86E.fYQ5Hax
	BNAZHJSP6mARAhuW1bcJP4f_pqjcesbLEyUHLvJtr2SBd3O8JDFpXSscKKXj3NMDB7wTgBzkFNZR
	6E2ksRQF4erby6gL6Uxds25RR4fZL2DUb3Yblw21oNEUrPYVL4j.1PtF28wf6z9QlWulcinwAQg4
	lakd94i4P1oZ9R.vKDBVliLzsJoy3kgLj0zXNBAaXTD3sZv89_elK.tBjvMmAtAcFqpkSQ95MBF6
	c7zUWhHuWVwk4X0tH4iySasuYl_pHBSe678wbHPlE_0DiHA3mnIkwS5HpwsxlH3zVyf_5BRQGZig
	A_01nBV3ucQPJ7EYoZ6zYb5HCPuikcvCdzA--
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic309.consmr.mail.bf2.yahoo.com with HTTP;
	Mon, 24 Jul 2017 20:58:02 +0000
Date: Mon, 24 Jul 2017 20:57:59 +0000 (UTC)
From: kris duff <t_dufff@yahoo.ca>
Reply-To: kris duff <t_dufff@yahoo.ca>
To: Bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <1586964508.4210312.1500929879478@mail.yahoo.com>
MIME-Version: 1.0
References: <1586964508.4210312.1500929879478.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.10121 YahooMailNeo Mozilla/5.0 (Windows NT 6.1; Win64;
	x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115
	Safari/537.36
Subject: korgoth : php + postgresql = ERROR: php-5.6.23-r0 do_configure: This autoconf log indicates errors, it looked at host include and/or library paths while determining system capabilities.
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 24 Jul 2017 20:58:01 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_4210311_1860078380.1500929879475"

------=_Part_4210311_1860078380.1500929879475
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
I am trying to install PHP with postgresql in my image.
I newly upgraded my image from dizzy to korgoth. I never have been sucessfu=
ll porting php + postgresql on my last image.
So support postgresql and not mariadb, I have created a php_5.6.23.bbappend=
. The content of that file is below.
PACKAGECONFIG +=3D "pgsql"
bitbake return this error :
ERROR: php-5.6.23-r0 do_configure: This autoconf log indicates errors, it l=
ooked at host include and/or library paths while determining system capabil=
ities.Rerun configure task after fixing this.ERROR: php-5.6.23-r0 do_config=
ure: Function failed: do_qa_configureERROR: Logfile of failure stored in: /=
home/krogoth/build/tmp/work/core2-64-poky-linux/php/5.6.23-r0/temp/log.do_c=
onfigure.1851ERROR: Task 791 (/home/krogoth/poky/meta-openembedded/meta-oe/=
recipes-devtools/php/php_5.6.23.bb, do_configure) failed with exit code '1'

In config.log from the build directory, I can see the following error that =
trigger insane.bbclass :
warning: library search path "/usr/lib/x86_64-linux-gnu" is unsafe for cros=
s-compilation

and looking for the configure line : I can see this : -L/usr/lib/x86_64-lin=
ux-gnu
I is very bad, but what can I do to understand where come from that -L ? =
=C2=A0If I don't include packageconfig pgsql it works well for mariadb.
Any hints ?
Thank you a lot
Kris

------=_Part_4210311_1860078380.1500929879475
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;font=
-size:16px"><div id=3D"yui_3_16_0_ym19_1_1500929372499_15856">Hi,</div><div=
 id=3D"yui_3_16_0_ym19_1_1500929372499_15856"><br></div><div id=3D"yui_3_16=
_0_ym19_1_1500929372499_15856">I am trying to install PHP with postgresql i=
n my image.</div><div id=3D"yui_3_16_0_ym19_1_1500929372499_15856"><br></di=
v><div id=3D"yui_3_16_0_ym19_1_1500929372499_15856" dir=3D"ltr">I newly upg=
raded my image from dizzy to korgoth. I never have been sucessfull porting =
php + postgresql on my last image.</div><div id=3D"yui_3_16_0_ym19_1_150092=
9372499_15856" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_1_150092937=
2499_15856" dir=3D"ltr">So support postgresql and not mariadb, I have creat=
ed a php_5.6.23.bbappend. The content of that file is below.</div><div id=
=3D"yui_3_16_0_ym19_1_1500929372499_15856" dir=3D"ltr"><br></div><div id=3D=
"yui_3_16_0_ym19_1_1500929372499_15856" dir=3D"ltr">PACKAGECONFIG +=3D "pgs=
ql"</div><div id=3D"yui_3_16_0_ym19_1_1500929372499_15856" dir=3D"ltr"><br>=
</div><div id=3D"yui_3_16_0_ym19_1_1500929372499_15856" dir=3D"ltr">bitbake=
 return this error :</div><div id=3D"yui_3_16_0_ym19_1_1500929372499_15856"=
 dir=3D"ltr"><br></div><div dir=3D"ltr" id=3D"yui_3_16_0_ym19_1_15009293724=
99_25557">ERROR: php-5.6.23-r0 do_configure: This autoconf log indicates er=
rors, it looked at host include and/or library paths while determining syst=
em capabilities.</div><div dir=3D"ltr" id=3D"yui_3_16_0_ym19_1_150092937249=
9_25558">Rerun configure task after fixing this.</div><div dir=3D"ltr" id=
=3D"yui_3_16_0_ym19_1_1500929372499_25559">ERROR: php-5.6.23-r0 do_configur=
e: Function failed: do_qa_configure</div><div dir=3D"ltr" id=3D"yui_3_16_0_=
ym19_1_1500929372499_25560">ERROR: Logfile of failure stored in: /home/krog=
oth/build/tmp/work/core2-64-poky-linux/php/5.6.23-r0/temp/log.do_configure.=
1851</div><div dir=3D"ltr" id=3D"yui_3_16_0_ym19_1_1500929372499_25561">ERR=
OR: Task 791 (/home/krogoth/poky/meta-openembedded/meta-oe/recipes-devtools=
/php/php_5.6.23.bb, do_configure) failed with exit code '1'</div><div dir=
=3D"ltr" id=3D"yui_3_16_0_ym19_1_1500929372499_25562"><br id=3D"yui_3_16_0_=
ym19_1_1500929372499_25563"></div><div id=3D"yui_3_16_0_ym19_1_150092937249=
9_15856" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_1_1500929372499_1=
5856" dir=3D"ltr">In config.log from the build directory, I can see the fol=
lowing error that trigger insane.bbclass :</div><div id=3D"yui_3_16_0_ym19_=
1_1500929372499_15856" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_1_1=
500929372499_15856" dir=3D"ltr">warning: library search path "/usr/lib/x86_=
64-linux-gnu" is unsafe for cross-compilation<br></div><div id=3D"yui_3_16_=
0_ym19_1_1500929372499_15856" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_y=
m19_1_1500929372499_15856" dir=3D"ltr">and looking for the configure line :=
 I can see this : -L/usr/lib/x86_64-linux-gnu</div><div id=3D"yui_3_16_0_ym=
19_1_1500929372499_15856" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_=
1_1500929372499_15856" dir=3D"ltr">I is very bad, but what can I do to unde=
rstand where come from that -L ? &nbsp;If I don't include packageconfig pgs=
ql it works well for mariadb.</div><div id=3D"yui_3_16_0_ym19_1_15009293724=
99_15856" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_1_1500929372499_=
15856" dir=3D"ltr">Any hints ?</div><div id=3D"yui_3_16_0_ym19_1_1500929372=
499_15856" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_1_1500929372499=
_15856" dir=3D"ltr">Thank you a lot</div><div id=3D"yui_3_16_0_ym19_1_15009=
29372499_15856" dir=3D"ltr"><br></div><div id=3D"yui_3_16_0_ym19_1_15009293=
72499_15856" dir=3D"ltr">Kris</div></div></body></html>

------=_Part_4210311_1860078380.1500929879475--
