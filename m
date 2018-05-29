Return-Path: <kumar.ugesh003@yahoo.com>
Received: from sonic304-20.consmr.mail.sg3.yahoo.com
	(sonic304-20.consmr.mail.sg3.yahoo.com [106.10.242.210])
	by mail.openembedded.org (Postfix) with ESMTP id 8DE6D60234
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 May 2018 16:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1527612758; bh=Pi5nqJksdrAw/SMtkVeirYy9VPzo5JgJXoc/ZUxexfM=;
	h=Date:From:To:Subject:References:From:Subject;
	b=gKYjckRq6dR7NQ4i8BE+YtVRmPZs7LDGR1F9IqGzNlRThC5cjCUv/csBxT6vBs7j2WCUjyj0/uE2Cr05+Y6X8/2IZ7mjgc/eUzN/AUw2sEvLtnbKuNCTVoeUS+Sp6sRZpi0uGTriYnRrkKI3iQcuDJvV7gNfv/usrywhurWXP2Oy+E//7syrOho9rAm1soLA9aW11Q0Pe+tawyBo3zsmT2uoDEVfJJhvrDnamUoXEnZGLBaM7txXaS/Vty4GC1EVTd03jMaQvTaC6x1+dMn7zm2TkVztfijsyo40GwDLDlGTaDocNfb8vi56tMu3CUPnZN/mDgRGYegl9is3bYDLQQ==
X-YMail-OSG: PlOStT4VM1lyX_CPvfN2g9u0DsF1EXLWNQBKANIPMMiVm5pvQpEXVzjF.eanGE5
	AAGZR9PIQpYu69m8qdNshnV59XRo2TwQMGqhGe3TAqTznrapkAxJeD2yBpXaPRE41vQv2wmKto92
	EPUDXSVMwQIOTs3gsuynwyTrtvEbZWb43.HbIr4axcbN3T3_JAjGrdpoCWkCdMQGQ3XqMLZnab5u
	pXrtDnqpi5pzDvKrofQzv70GUeYI.Z9nXHFnOQ2sU8krzllefaAkWQBdCNg0XdROAHFcKGa1k0XS
	rZb5puyZFxg7L5zJNKouIS4ITwEc_oRmMfMVHWLk6Hp0896qgpfzy6mYLRjaVEpB6B_1pTqbARzw
	kcFVSS3CP2QudpFroIpHVdEmnsYjVhYZ7_N5pOerIr2fGlhMIoEQNmDTzin4wLZ0tDy8LJk3Dd6X
	qsmQ.6UCf_MAetfmik2XnYwXUtQpLmjOI9cEp.9zq_YnZq21gbR.7lAWkhs3YUwMY2wVu3KM6W81
	kQtkC7bEo.eJZdKHQsou9p.bgM8zPFM9KbmaPaAW3Q.lwcgwlDHld5VHyQmoRSXd54KWqvfFJZnl
	84G40DfqNcBsFKkMYk.xOIvyMwdG67cxNBpwYahhdoXVaF4OcsGorke1EOUmjBsQlJZZu8DK6sEf
	FuZdhx2zj
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic304.consmr.mail.sg3.yahoo.com with HTTP;
	Tue, 29 May 2018 16:52:38 +0000
Date: Tue, 29 May 2018 16:52:35 +0000 (UTC)
From: Ugesh Reddy <kumar.ugesh003@yahoo.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Message-ID: <341002747.6964097.1527612755247@mail.yahoo.com>
MIME-Version: 1.0
References: <341002747.6964097.1527612755247.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.11871 YMailNorrin Mozilla/5.0 (X11;
	Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu
	Chromium/64.0.3282.167 Chrome/64.0.3282.167 Safari/537.36
Subject: Enabling the Macro in .bb
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
X-List-Received-Date: Tue, 29 May 2018 16:52:39 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_6964096_662226489.1527612755246"

------=_Part_6964096_662226489.1527612755246
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,=C2=A0 I have the source code were the part of the code kept inside t=
he #ifdef SOME_MACRO=C2=A0 and what would be the correct place to define SO=
ME_MACRO=C2=A0 this macro?note: This define is specific to the recipe.
Regrds,Ugesh

------=_Part_6964096_662226489.1527612755246
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"font-family:Helvetica Neue, Helvetic=
a, Arial, sans-serif;font-size:16px;"><div><span><div style=3D"color: rgb(0=
, 0, 0); font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, sans-se=
rif; font-size: 16px;"><font size=3D"2">Hello,</font></div><div style=3D"co=
lor: rgb(0, 0, 0); font-family: &quot;Helvetica Neue&quot;, Helvetica, Aria=
l, sans-serif; font-size: 16px;"><font size=3D"2">&nbsp; I have the source =
code were the part of the code kept inside the #ifdef SOME_MACRO&nbsp; and =
what would be the correct place to define SOME_MACRO&nbsp; this macro?</fon=
t></div><div style=3D"color: rgb(0, 0, 0); font-family: &quot;Helvetica Neu=
e&quot;, Helvetica, Arial, sans-serif; font-size: 16px;"><font size=3D"2">n=
ote: This define is specific to the recipe.</font></div><div style=3D"color=
: rgb(0, 0, 0); font-family: &quot;Helvetica Neue&quot;, Helvetica, Arial, =
sans-serif; font-size: 16px;"><font size=3D"2"><br></font></div><div style=
=3D"color: rgb(0, 0, 0); font-family: &quot;Helvetica Neue&quot;, Helvetica=
, Arial, sans-serif; font-size: 16px;"><font size=3D"2">Regrds,</font></div=
><div style=3D"color: rgb(0, 0, 0); font-family: &quot;Helvetica Neue&quot;=
, Helvetica, Arial, sans-serif; font-size: 16px;"><font size=3D"2">Ugesh</f=
ont></div></span><br></div></div></body></html>

------=_Part_6964096_662226489.1527612755246--
