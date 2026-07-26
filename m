Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8400AC531C9
	for <webhook@archiver.kernel.org>; Sun, 26 Jul 2026 12:21:58 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9497.1785068509893474471
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jul 2026 05:21:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AaydpSPd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1280551f8f.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 26 Jul 2026 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1785068508; x=1785673308; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nZmvXQT6P6eTuXzyVBUsRe+Zy9IzCtltaQivfIY1YcM=;
        b=AaydpSPd51Q+bvstJ+7p9x+ijHYRHQMFZO1h/v2A4gcieo4rFyr12sEDcQH5n6X17d
         8vmswhM6pjdU9o6L//tZvI17jmiso/nlSWpJhPp/yMRBMr8lVM9LZv/4ASUBeEQjTbwz
         eK/tnxnKhK/jQAYtNwBx1uhvZJ0n+iAvsL06w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785068508; x=1785673308;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZmvXQT6P6eTuXzyVBUsRe+Zy9IzCtltaQivfIY1YcM=;
        b=R8WKTqpQTz99UBP9XDWn4UpmSVDg284a1Ne93azqDktwEVfAJ/WMMKLlxeA1LL+u5m
         7nx40vRYGy/gKQH5yJCoMvIKH8/StP9YWZR63MEQI204cO5YMjhnZLA5CsWxNohBp7TR
         Qz8bH3/+UTXBBywRMOnWkMVPzeB1fIAcTiXN85lV7FszeGEfFc0We7ejODgagzhvJI5k
         MupAwhgPLFZT7b221PsnpKgJdUD1l3FCpDOYPsHnaUMt2wcELFMLkeOvRoYditMOPImR
         xX3VOHJ4pM/zY2W0KFbFbbCA0ED2Gw0rZTF/XpxRFRFQw7bjFXTC2sXHcPn2UdbdT7SG
         I67A==
X-Forwarded-Encrypted: i=1; AHgh+RrsE6oQ/S99znJP0TBWo/01VlNl84RSLVscVh4lm3ZH8miKCeTNdllEPB6CBtkw7k3MqrEMbYxuf0BBBDfD@lists.openembedded.org
X-Gm-Message-State: AOJu0YwUQCArSa6QSaMHgdBGXo92XmO959Fk/1DmR2D2wgPUZwNX8nFL
	jFNdYJ5gFYrF14KhXd4cNtnqYIeQLJ6cNGLSu12rALH22PPmpqF/gNVVC8L0cHzVRXg=
X-Gm-Gg: AR+sD13s5SpRok1UsFvNV9UGzGW8TsEbTPBnLag64bweFiwfKhpkkM329cKmQy4jfr4
	RbXKAtff7bLXge+uxHKxcYI+rGP9c34JkekH76nyQ9EIIuyQRSgenuwvfdQZ5/G7G7PuO80U6vl
	8860IFuy9vlVGrAE84WZ4thI6o3mQLSOgPJa1npjVtIDW4MJuYaFTP3YEKHtxCMoYmmCD9am+UH
	N/uk1ewjFWf3FnDykgMxlZWLDoeDCgNjZE/uBFMlrTnuv+HqMb3gom1veOtAsTtSFtDWbJ9iqqL
	gzrAZxUkKlwbFT8l6XBfyVEYT+KEy2IQIvnQ9hMlWAq2+2TOsayLgHoo5Tgqk9BchvuM7HOVd+w
	DK/UI0dLAkanvzsI3yhckOcZVru1KJm1upTEXVOAZBIt/3v0nbk97YXrIn32UPRCGMEw0TDqH15
	/oLl2Nvw3j5TjdmVSF7y8N3datSiidCDjOANH8ighmVv9HSYFy/wn7ChGozryqy4zIDu4=
X-Received: by 2002:a05:6000:240f:b0:47f:7d49:1745 with SMTP id ffacd0b85a97d-47f9feb5145mr6248096f8f.23.1785068507765;
        Sun, 26 Jul 2026 05:21:47 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a3ed:a478:dbfa:c28f? ([2001:8b0:aba:5f3c:a3ed:a478:dbfa:c28f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f96d4656bsm22976265f8f.21.2026.07.26.05.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 05:21:45 -0700 (PDT)
Message-ID: <dd3a79ae52d3d42959ee98c1b6e1d3df4c0a2dee.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/1] data_smart: fix operations lost
 when an override name contains a variable
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: zizuzacker@gmail.com, bitbake-devel@lists.openembedded.org
Date: Sun, 26 Jul 2026 13:21:44 +0100
In-Reply-To: <20260725143002.23596-2-zizuzacker@gmail.com>
References: <20260725143002.23596-1-zizuzacker@gmail.com>
	 <20260725143002.23596-2-zizuzacker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jul 2026 12:21:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19861

On Sat, 2026-07-25 at 21:30 +0700, Zk47T via lists.openembedded.org wrote:
> An operation whose override name needs key expansion is silently dropped:
>=20
> =C2=A0=C2=A0=C2=A0 RDEPENDS:${PN}:append:pn-foo-${MACHINE} =3D " bar"
>=20
> renameVar() rebuilds the dependent override keys with a plain string
> replace, so renaming RDEPENDS:${PN} leaves the append attached to
> RDEPENDS:foo:append:pn-foo-${MACHINE}, which never matches an active
> override. expandKeys() cannot fix that up afterwards either, as it works
> from a list of keys collected before any renaming happened.
>=20
> Expand the derived name before renaming it. Only do so once newkey is
> itself expanded, otherwise expandKeys() has still to rename newkey and
> handles the dependent keys along with it.
>=20
> Add regression tests for both cases.
>=20
> Fixes [YOCTO #14867]
>=20
> Signed-off-by: Nguyen Minh Tien <zizuzacker@gmail.com>
> ---
> =C2=A0lib/bb/data_smart.py | 11 +++++++++--
> =C2=A0lib/bb/tests/data.py | 25 +++++++++++++++++++++++++
> =C2=A02 files changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index 9961269a3..5738aff95 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -697,8 +697,15 @@ class DataSmart(MutableMapping):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
found =3D True
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.overridedata[newkey] =3D []
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
for (v, o) in self.overridedata[key]:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.overridedata[newkey].append([v.replace(key, newkey)=
, o])
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.renameVar(v, v.replace(key, newkey))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 newv =3D v.replace(key, newkey)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # The derived name may still hold a variable reference w=
hich
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # expandKeys() will never revisit, so expand it here. On=
ly once
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # newkey is expanded though, otherwise expandKeys() has =
still to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # rename newkey and handles the dependent keys along wit=
h it.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if '${' in newv and '${' not in newkey:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 newv =3D self.expand(newv)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.overridedata[newkey].append([newv, o])
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 self.renameVar(v, newv)
> =C2=A0

Thanks for the patch and the test cases. I had a deeper look at this as
I was a bit puzzled how this would work without your patch:

XYZ =3D "yocto"
ABC =3D "123"
ABC:append:pn-linux-${XYZ} =3D " 456"
$ bitbake-getvar -r linux-yocto ABC
ABC=3D"123 456"

as if the code can handle that, it should be able to handle the other
case too. I think this is because expandKeys() calls renameVar and then
renameVar itself also calls renameVar() on the same element, which
breaks things. That means that if you do:

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 5fdcdb04a..e3af12a35 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -94,7 +94,7 @@ def expandKeys(alterdata, readdata =3D None):
             val =3D alterdata.getVar(key, False)
             if val is not None:
                 bb.warn("Variable key %s (%s) replaces original key %s (%s=
)." % (key, val, ekey, newval))
-        alterdata.renameVar(key, ekey)
+        alterdata.renameVar(key, ekey, recurse=3DFalse)
=20
 def inheritFromOS(d, savedenv, permitted):
     """Inherit variables from the initial environment."""
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 110dfa111..78ff9b961 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -661,7 +661,7 @@ class DataSmart(MutableMapping):
     def getVar(self, var, expand=3DTrue, noweakdefault=3DFalse, parsing=3D=
False):
         return self.getVarFlag(var, "_content", expand, noweakdefault, par=
sing)
=20
-    def renameVar(self, key, newkey, **loginfo):
+    def renameVar(self, key, newkey, recurse=3DTrue, **loginfo):
         """
         Rename the variable key to newkey
         """
@@ -693,7 +693,8 @@ class DataSmart(MutableMapping):
             self.overridedata[newkey] =3D []
             for (v, o) in self.overridedata[key]:
                 self.overridedata[newkey].append([v.replace(key, newkey), =
o])
-                self.renameVar(v, v.replace(key, newkey))
+                if recurse:
+                    self.renameVar(v, v.replace(key, newkey))
=20
         if ':' in newkey and val is None:
             self._setvar_update_overrides(newkey, **loginfo)



then I think that resolve the issue? It would also perhaps resolve an
issue where a variable with three different key expansions in it might
not work! I'm less sure that three different key variables would work
with plain renameVar, that may also need to set the "no recurse"
option, I'm not sure.

Could you see if this makes sense to you?

Cheers,

Richard





