Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38055.1793175648370257822
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Oct 2026 01:20:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=MSPBm5fR;
 dkim=pass header.i=@oss.qualcomm.com header.s=google header.b=PA8ok7lk;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: anuj.mittal@oss.qualcomm.com)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S8JwK0611863
	for <bitbake-devel@lists.openembedded.org>; Wed, 28 Oct 2026 08:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pH5hG4X8v3vw1Gqbtw3eyMOSeAB/FIH2p3nxfJa6t6o=; b=MSPBm5fRTWgDvsqZ
	To5JsUhoBZuCKoSKcvhBS9g6hJ070Aes7jffnr58lJJiBde8iHSeNnt0KypfsrxM
	gfrY2h/dYuhPJlrTrIFMFXHsSeqL5waMF/4e2VgyAOQXTUYBzlqDtcBgFqsqtvqN
	qvVsWF3rcwyHVoCOeYckxePymFhJZBSghOpu1hasM7cCzbKt5Rh+MAKX6DuWxhgc
	709F5zLUYPnIONQGDNda4xhel2YUo/KL4N3JfqGyiOlHkSbFD9jrV4mZJpBatFzF
	ZhWhORmv5SQafyKauY+yFKqJw1cF7+2VCzT8V3O9o31Dma0bcpBh+OeoGBvkw43Q
	R69XyA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkbhw8era-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 28 Oct 2026 08:20:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5339739b343so16754411cf.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Oct 2026 01:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793175647; cv=none;
        d=google.com; s=arc-20260327;
        b=IKwURKH6wnBAmpzSDkpfq8dctULRFdRMRIPa98T21rMZRWoJDf74PgKDW+xaNiAnBy
         8JJI0fa2Cp9tPoiOlxJuxGzf/QI8HPfInl2Q7bsXYhWgL9H8hfs/yUqvjn4l7Pvio1Qu
         ucJRZLbOyhcPs6XaLQh3kWAEHKiT/1urMYJhnzeWK/OT2F+XwnOnSqdmanuUghncZcKQ
         sbjFhk1N2awi4vy6e+Lu7LtAJTWEpfJWXbwhrHe48mqD8zKRno5q1F70kql+MfVeQEM4
         Nw1WMMVSmm2Cs8WVdkqWlN48GPRG2ICcbT68sr42tjkvcwMVrm0wvCXsCJc4XyKtQBZS
         1RSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pH5hG4X8v3vw1Gqbtw3eyMOSeAB/FIH2p3nxfJa6t6o=;
        fh=JhOfHytN90CCvbyJ+d+0Ur/WZWg2YEviRlSxYWkYK0A=;
        b=Puvba7mUHK8gN5uTPyFgYB/4J/mmSFtdNHb+dTdWoqBK6vrYx9498KY/wtaBiVAMtB
         /WPRcqLfpMPwrLfxhRXiZv3vlSJqFfKCr1BHZo0pmZY/2wOZxW74NI3OSX9KeJkWCyOd
         mZWSBkhf0RhQZQ90CSVcHxuMIc087feXIdPjxLdEufAcCr6/nttc1CJ40Ag4pe2TTPmd
         4lRRDXnRxg6qQSkX5uFdElNf2Xu07JMCaHpWtMCpbV/KXmEXy9+Mr3iUCx3tQMCwUahW
         7DIfRy76Pxm5PSoMvBg/EBHCHSM0qlppOHG7xYnDmx+D2MqtHnNoR83MPXuf4prUJ26s
         U1vw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793175647; x=1793780447; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pH5hG4X8v3vw1Gqbtw3eyMOSeAB/FIH2p3nxfJa6t6o=;
        b=PA8ok7lkxFVhiE+fBnDpizxF3y0MJAbDAc6WxAjT9UeumL6tkZvj4WY2zcKr5yBZCh
         G1mIJl2zCFJ1UMwQgu5uFaTKI0drDOuFS99ANRTRYNSG2OJgVtvOz7dxaZ3e+s12z8p6
         IOjgXnDfdUrshTsBNx3Jqhb7nn0sjZwe1+0HgjAKkv8jpHjejDuMIdfcsgcajWCw2Hfs
         qa9qT9FZDYTORl48Pr3lTRN+zETJ5YkB1E0ZJ10v7zIlhzzAHz6mz3WPkp0DuZXRNdum
         xfFNiWtlusKFL/nzh9+ZwTjHeRX2lxXLlzL8AW4uW42KrPO9+pSXAUynp4oqxAtUxRLi
         h+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793175647; x=1793780447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pH5hG4X8v3vw1Gqbtw3eyMOSeAB/FIH2p3nxfJa6t6o=;
        b=ydvM5iXuCJ+eI3cpgYxyS+HNvjbQmygFZ7pcXnGuzxfocMZrfLs7BIaOifP2a2O353
         q+RUtoWNfZGEbhWbVZhDogsz+OVpwCX6L+Ij/bpkQMiL9HE0xkNmllG/D1Y7Xe9hlAro
         VCeLcV49dCpz721ZGe3yaXAtlXo8+TQzGCTCBq+vSU7ljA+cFUOT9R9bgedvJkI21Tzl
         DA79xe54oBKu2CzLrCD2hM0a/qhgr15GSKauqpwroXwbzYPKCz+IkKaoDFc78RRMLueY
         zjggYRG+m2qDCt4n27yZrmwZZH7ISz/9GPo20ZVC/CM9APcGwoN93jXFUb17bF1wG82a
         Q0KA==
X-Gm-Message-State: AFq9FYJ1ygQ+oHJqYifM4HJparllr8YksbfVPXyzF96HHrnXD4wsYN4B
	s1AP3+xwlbL6dSviVs+npYtSvCUz2p6x5Qtv7Ig6En2ozkWQxKUX8jr/CgfvVKwjmiz+t7dti+F
	iiKkecVjsAlnN752XWqJmIdb3v3e8Xf7qf751p2femQpxDkkIwGAkmGGV4+5HybYPrmogJ0mL3b
	xgdixoZi+0bS2Np/meRyR5SyE5kEQ4P+3wl+GM3s6CcE6VHeB009wM
X-Gm-Gg: AYBFou0NUnNrRv0TWYuZ+KNejXzXwQPjvB9lqPmXsGo2mQSDf37EQwMjMQhNpBBvhC/
	s7usIJGHtj2TzBeab+XCIh56VM+cgG0X2MHWnm820Gpek5LTtq3Kbp47foRBZbtMifjershYygt
	6eoVPFsuCNJ9XiSV5fv3iWbHWMNOwzRENQaygxHRLIDI6iyQ7d4Jedg0+C1g==
X-Received: by 2002:ac8:5f8c:0:b0:533:8e6b:260e with SMTP id d75a77b69052e-53fcbbeb006mr28702021cf.31.1793175646590;
        Wed, 28 Oct 2026 01:20:46 -0700 (PDT)
X-Received: by 2002:ac8:5f8c:0:b0:533:8e6b:260e with SMTP id
 d75a77b69052e-53fcbbeb006mr28701751cf.31.1793175646018; Wed, 28 Oct 2026
 01:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790495160.git.yoann.congal@smile.fr> <c7029045baa2fd986e7cb5b52f6ba74571cdf728.1790495161.git.yoann.congal@smile.fr>
In-Reply-To: <c7029045baa2fd986e7cb5b52f6ba74571cdf728.1790495161.git.yoann.congal@smile.fr>
From: Anuj Mittal <anuj.mittal@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 16:20:34 +0800
X-Gm-Features: AclHuK929_OHwhkYb_zA_N1jpaGHMLMdTwW23fJ8R5e0Q-I0DAFejaVfPmN7Juk
Message-ID: <CA+s=J=whmg0nSR89ctAqvL+G1abnFMz_r9ue4t1u0bxc-7ggzg@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][wrynose][2.18][PATCH 5/6] data: Fix
 expandKeys recursion issue
To: yoann.congal@smile.fr
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: IA3F29rXJdSym_Q-qDlbmCzXE0jnLx76
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzMyBTYWx0ZWRfXznomY3aMWV+7
 4nG7o9CvkTDbT9sT85TdjB3L94C+9VrpPO+0i+KnHaryusafU4PAMoowAAINh8FGGvslvWI0T8b
 /difr1iPfk0uP3Riq2Mvl0Gyad4hvAo=
X-Authority-Analysis: v=2.4 cv=V+joQuni c=1 sm=1 tr=0 ts=6ae1b05f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=Q4-j1AaZAAAA:8 a=ag1SF4gXAAAA:8 a=pGLkceISAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=PLALoFQk8q7E1n4nDioA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=Yupwre4RP9_Eg_Bd0iYG:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: IA3F29rXJdSym_Q-qDlbmCzXE0jnLx76
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzMyBTYWx0ZWRfX1G6iIaJU5XtF
 XhcSPYYiHLCYpvZa9Nj21lxga/zQTyMHdD6kSRpv/T/fNfA/Sj+HC5ImaLlCZXNb+s4YZQvFAY3
 cg0iL+AuOgSLxeGJfLWe1K/tx1hE2tBfDH9TTY98JaSRUKBTmtei/EjEyI/tzyzcEHWiFaSGhKA
 QggRHq1RpDg+xGzEwoXvWq2SMvRoyfCSBPcG6lsuoGNXntpYk7RdiaFLOCc45EeGFuNEdKCYOuq
 c70jwdbWWqfkyIVzSjUGZ/l4RM9SvTjC2/SeYuhWSFi2rHuJdztfmVXWNpLW5eXaal6ee7OLegr
 0KLZwAaDeCbvBL5nsLPn6ODPmqvB6Lh+j+0VzA2XeK47NfI0GK6kktIZtdxT8C/ptrZWd7pmGdY
 WewtHBgPhkWsDRkmn+NoNXlUUwZ+YAQVn8oL22XngJPmDcYTcp69cMTbzGgepRG3FU0JQfRDDk3
 g6kChIpkqGH1aRl8AIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280033
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 28 Oct 2026 08:20:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20382

Hi Yoann

On Sun, Sep 27, 2026 at 3:47=E2=80=AFPM Yoann Congal via
lists.openembedded.org <yoann.congal=3Dsmile.fr@lists.openembedded.org>
wrote:
>
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> Using an variable expansion in override such as:
>
> RDEPENDS:${PN}:append:pn-packagegroup-cross-canadian-${MACHINE} =3D ' XXX=
'
>
> wasn't functioning correctly. Looking through the code, renameVar does
> work correctly but it doesn't work if called multiple times on the sub
> components of the variable.
>
> expandKeys will already recurse variables so we need to ensure renameVar
> doesn't also do that as things break if we do it multiple times.
>
> Change the code to avoid recursion in renameVar which should also have
> a small performance improvement.
>
> Test case from Nguyen Minh Tien <zizuzacker@gmail.com>
>
> [YOCTO #14867]

This would require the oe-core change 7944665886 ("recipe_sanity: Drop
rename overwrite detection") to be picked as well otherwise it leads
to errors for layers using the class in wrynose.

I've sent a backport request.

Thanks,

Anuj


>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> (cherry picked from commit a3c6a020da9a352d0474e85bc0591b4a174cb0c0)
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> ---
>  lib/bb/data.py       |  2 +-
>  lib/bb/data_smart.py |  5 +++--
>  lib/bb/tests/data.py | 25 +++++++++++++++++++++++++
>  3 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/data.py b/lib/bb/data.py
> index 7c01e6bf8..f81f44eac 100644
> --- a/lib/bb/data.py
> +++ b/lib/bb/data.py
> @@ -94,7 +94,7 @@ def expandKeys(alterdata, readdata =3D None):
>              val =3D alterdata.getVar(key, False)
>              if val is not None:
>                  bb.warn("Variable key %s (%s) replaces original key %s (=
%s)." % (key, val, ekey, newval))
> -        alterdata.renameVar(key, ekey)
> +        alterdata.renameVar(key, ekey, recurse=3DFalse)
>
>  def inheritFromOS(d, savedenv, permitted):
>      """Inherit variables from the initial environment."""
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 110dfa111..e26b0659a 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -661,7 +661,7 @@ class DataSmart(MutableMapping):
>      def getVar(self, var, expand=3DTrue, noweakdefault=3DFalse, parsing=
=3DFalse):
>          return self.getVarFlag(var, "_content", expand, noweakdefault, p=
arsing)
>
> -    def renameVar(self, key, newkey, **loginfo):
> +    def renameVar(self, key, newkey, recurse=3DTrue, **loginfo):
>          """
>          Rename the variable key to newkey
>          """
> @@ -693,7 +693,8 @@ class DataSmart(MutableMapping):
>              self.overridedata[newkey] =3D []
>              for (v, o) in self.overridedata[key]:
>                  self.overridedata[newkey].append([v.replace(key, newkey)=
, o])
> -                self.renameVar(v, v.replace(key, newkey))
> +                if recurse:
> +                    self.renameVar(v, v.replace(key, newkey))
>
>          if ':' in newkey and val is None:
>              self._setvar_update_overrides(newkey, **loginfo)
> diff --git a/lib/bb/tests/data.py b/lib/bb/tests/data.py
> index a83c71e2c..491774747 100644
> --- a/lib/bb/tests/data.py
> +++ b/lib/bb/tests/data.py
> @@ -406,6 +406,31 @@ class TestOverrides(unittest.TestCase):
>          bb.data.expandKeys(self.d)
>          self.assertEqual(self.d.getVar("VERSION"), "2")
>
> +    # Test an :append whose override name is only resolved by key expans=
ion
> +    def test_append_in_expanded_override(self):
> +        self.d.setVar("MACHINE", "qemux86")
> +        self.d.setVar("PN", "gizmo")
> +        self.d.setVar("OVERRIDES", "gizmo:pn-gizmo-qemux86")
> +        self.d.setVar("TEST:${PN}", "base")
> +        self.d.setVar("TEST:${PN}:append:pn-gizmo-${MACHINE}", " appende=
d")
> +        bb.data.expandKeys(self.d)
> +        self.assertEqual(self.d.getVar("TEST"), "base appended")
> +
> +    # Test renaming to a key which is itself not expanded yet, as native=
.bbclass
> +    # does. The dependent override keys must be left for expandKeys() to=
 rename.
> +    def test_rename_to_unexpanded_key_with_override(self):
> +        self.d.setVar("BPN", "gizmo")
> +        self.d.setVar("PN", "gizmo-native")
> +        self.d.setVar("OVERRIDES", "class-target")
> +        self.d.setVar("TEST:${PN}-lib", "base")
> +        self.d.setVar("TEST:${PN}-lib:class-target", "target")
> +        with LogRecord() as logs:
> +            self.d.renameVar("TEST:${PN}-lib", "TEST:${BPN}-lib-native")
> +            bb.data.expandKeys(self.d)
> +            self.assertFalse(logContains("renameVar with equivalent keys=
", logs))
> +            self.assertFalse(logContains("replaces original key", logs))
> +        self.assertEqual(self.d.getVar("TEST:gizmo-lib-native"), "target=
")
> +
>      def test_remove_with_override(self):
>          self.d.setVar("TEST:bar", "testvalue2")
>          self.d.setVar("TEST:some_val", "testvalue3 testvalue5")
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20264): https://lists.openembedded.org/g/bitbake-deve=
l/message/20264
> Mute This Topic: https://lists.openembedded.org/mt/121452884/3616702
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [anuj.m=
ittal@oss.qualcomm.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
