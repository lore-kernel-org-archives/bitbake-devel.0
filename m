Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13744.1794492004725927726
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Nov 2026 06:00:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cHCKZ+Lh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.218.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4322d310e7so659951266b.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 06:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794492003; x=1795096803; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1tqPDrIu96vvwgU6bm20GGrXzzbyJtkF2Qe5GiV6D4=;
        b=cHCKZ+LhX9izUWKIDGKFDYmcBaKG6sHG7mQV27w/Ko9V1PkYh8zd20Xf085dHQSf9T
         GQ8e7eKNnxIX86J1FGNXg1mjZr6eeu2lCZ86VtnSPFp+r8QpNrkG4pmb/A+iOtu/6uPV
         rkKA1AogYMXc1scMOFMYEXO1w7Dgw39lB+zG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492003; x=1795096803;
        h=mime-version:user-agent:content-type:references:in-reply-to:date:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G1tqPDrIu96vvwgU6bm20GGrXzzbyJtkF2Qe5GiV6D4=;
        b=FYnG0Pg0I+yV/r/2WkPzVVdW4YCfWkkY+yiIOBhDQfzSk9lWd+qtJ/QGXcSZgQsJwM
         nvYjzpaYRBtm5kZsozbF+UQaSDKJArAZVNNV6+xJd41CpaibyAELfRCaDxMSg2BBjLC9
         4Zup4P+76paHRVRaKkKM1SVBwl9AjKuwWOjDxlBXJARJVH9C9yDglwJFM+8T8rtj/Wn+
         4XzrElMxg0naJ7F8Vay/aJ+NxJV1Sf0m8TXp+ZVipNWjGP+cwTBu3bCFetEE1sTe01d7
         m66uM8nmUka7LtFYwv3rjcglp2xuGxxAnhtbs47WENtID2252ry/o7+QDr1gjt8k0kUo
         NcRA==
X-Forwarded-Encrypted: i=1; AL+hErEwu66yEbgKLnH8NMyEOITe8Y/UZ7ONlyadwSIBHdIm0P/Jg73xfb7Cm9qnXg35xtsOgHUpDDPyEcc0PQN6@lists.openembedded.org
X-Gm-Message-State: APuU4Z/q1e1stw6wxPuM3IX6kwBNMVUT6KrXz4s1RtjZMnw9eBeVvM+i
	EnzfzF1L/HY4TmrYI9AIMidu+FqujlQEaomSj38j47pBlAMvwx+zQBGsm6p5y1UmMXY=
X-Gm-Gg: AYBFou25VXRHUFkrXU3oVFDA6G0dXL4mRZeVhSa1S7Gs6ey+PPnDMU5Pe6sdrqAwyZQ
	RiNsnIaVpoJSa95ILLffeS5A2R8QIhicEFMepym/cC4kHgE2atInnnCNHECmCGOm0cw4vQFXKTb
	DIIR4d+nunLajkwMLlPNjL32hQZgr9rSh2+qS7/braj/JfYZWCFu2v2H/L9vK6foO1KHRknay5E
	tlXqR1aItm9SJJft3Mp/wCNsgbubXIKZBBIp/TLyWgXgeYdnt0+lFLoH1WW2zgbnJqIC+RT2ce5
	ED6RruBxPlWEw4zNAB/uv/Zet41ORigOXkhkbrwcNXxxxvZiS6cMj0vdfViQqwiHL4ZZQ4TrU8A
	pRaR0cyxdyf3GNKNe0I8bBDWzhu8yoca8mO8ydUyAdRXja/WClb0rNOFXDRX741ssJasDg2lj7Q
	gpxcnTN1CqQrV/cejcXnsZcf3+CLRJmv06wwIyRkvNRBzX73FZzILTdO7Uwz9pJCpcBFl3JWZCI
	ULIF1HScinN4CvqBAHhfLu9lcxVIvkXHNo7ZFNRIxa4d4GN1ou4adesX/T3gwxYomqM4Kg8hs29
	0+km3G9VFO8AhC8b7lfS5/uklZmXX5nsEq6W8O5fMxuIGUvLRrUSm6ty5NfWdwwf722C1fLbtKY
	Uyars9ntkTsPKKhpAVA==
X-Received: by 2002:a17:907:a08a:b0:c34:c5e8:1dc5 with SMTP id a640c23a62f3a-c5066af32ecmr477267666b.20.1794492002655;
        Thu, 12 Nov 2026 06:00:02 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:1562:9f61:e354:1b51? ([2001:8b0:aba:5f3c:1562:9f61:e354:1b51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a6197b7sm353460666b.52.2026.11.12.06.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:00:01 -0800 (PST)
Message-ID: <87e95f4cadb6b4f0c5748124c013e0bbb83879e8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: preserve embedded do_
 in task names
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: david.koch@wenuam.fr, bitbake-devel@lists.openembedded.org
Date: Thu, 12 Nov 2026 14:00:00 +0000
In-Reply-To: <db07641b-d67e-4f87-a0cb-a704950d7c7a@wenuam.fr>
References: <a905add9-4600-4de3-8a3a-02ba3995234d@wenuam.fr>
	 <db07641b-d67e-4f87-a0cb-a704950d7c7a@wenuam.fr>
Content-Type: multipart/alternative; boundary="=-pLRDpKUMIClhL9rZMWq1"
User-Agent: Evolution 3.56.2-10build1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 12 Nov 2026 14:00:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20423

--=-pLRDpKUMIClhL9rZMWq1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the report/patch! You're right this is a potential issue we
should fix.

On Thu, 2026-11-12 at 14:26 +0100, WM - David KOCH via bitbake-devel
wrote:
> =20
> =20
> Signed-off-by: WM - David KOCH <david.koch@wenuam.fr>
> ---
>  bin/bitbake-worker | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 61484a5c2..0be6f6eba 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -266,7 +266,7 @@ def fork_off_task(cfg, data, databuilder, workerdata,=
 extraconfigdata, runtask):
>                  the_data =3D databuilder.mcdata[mc]
>                  the_data.setVar("BB_WORKERCONTEXT", "1")
>                  the_data.setVar("BB_TASKDEPDATA", taskdepdata)
> -                the_data.setVar('BB_CURRENTTASK', taskname.replace("do_"=
, ""))
> +                the_data.setVar('BB_CURRENTTASK', taskname[3:])
>                  if cfg.limited_deps:
>                      the_data.setVar("BB_LIMITEDDEPS", "1")
>                  the_data.setVar("BUILDNAME", workerdata["buildname"])
> @@ -285,7 +285,7 @@ def fork_off_task(cfg, data, databuilder, workerdata,=
 extraconfigdata, runtask):
>                  the_data.setVar('BB_UNIHASH', unihash)
>                  bb.parse.siggen.setup_datacache_from_datastore(fn, the_d=
ata)
> =20
> -                bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN=
"), taskname.replace("do_", "")))
> +                bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN=
"), taskname[3:]))
> =20
>                  if not bb.utils.to_boolean(the_data.getVarFlag(taskname,=
 'network')):
>                      if bb.utils.is_local_uid(uid):
> -

I think this is nearly right but it is possible the taskname might not
start with "do_". I'd therefore suggest using:

taskname.removeprefix('do_')

instead.

Thanks,

Richard



--=-pLRDpKUMIClhL9rZMWq1
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head>

   =20
  <style>pre,code,address {
  margin: 0px;
}
h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}
ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}
blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}
</style></head>
  <body><div>Thanks for the report/patch! You're right this is a potential =
issue we should fix.</div><div><br></div><div>On Thu, 2026-11-12 at 14:26 +=
0100, WM - David KOCH via bitbake-devel wrote:</div><blockquote type=3D"cit=
e" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left:1=
ex"><div> </div><div class=3D"moz-forward-container"> <p style=3D"line-heig=
ht: 116%; margin-bottom: 0.28cm">Signed-off-by: WM - David KOCH <a class=3D=
"moz-txt-link-rfc2396E" href=3D"mailto:david.koch@wenuam.fr" moz-do-not-sen=
d=3D"true">&lt;david.koch@wenuam.fr&gt;</a></p><pre wrap=3D"" class=3D"moz-=
quote-pre">---
 bin/bitbake-worker | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 61484a5c2..0be6f6eba 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -266,7 +266,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, e=
xtraconfigdata, runtask):
                 the_data =3D databuilder.mcdata[mc]
                 the_data.setVar("BB_WORKERCONTEXT", "1")
                 the_data.setVar("BB_TASKDEPDATA", taskdepdata)
-                the_data.setVar('BB_CURRENTTASK', taskname.replace("do_", =
""))
+                the_data.setVar('BB_CURRENTTASK', taskname[3:])
                 if cfg.limited_deps:
                     the_data.setVar("BB_LIMITEDDEPS", "1")
                 the_data.setVar("BUILDNAME", workerdata["buildname<a class=
=3D"moz-txt-link-rfc2396E" href=3D"mailto:])@@-285,7+285,7@@deffork_off_tas=
k(cfg,data,databuilder,workerdata,extraconfigdata,runtask):the_data.setVar(=
'BB_UNIHASH',unihash)bb.parse.siggen.setup_datacache_from_datastore(fn,the_=
data)-bb.utils.set_process_name(" moz-do-not-send=3D"true">"])
@@ -285,7 +285,7 @@ def fork_off_task(cfg, data, databuilder, workerdata, e=
xtraconfigdata, runtask):
                 the_data.setVar('BB_UNIHASH', unihash)
                 bb.parse.siggen.setup_datacache_from_datastore(fn, the_dat=
a)
=20
-                bb.utils.set_process_name("</a>%s:%s" % (the_data.getVar("=
PN"), taskname.replace("do_", "")))
+                bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN")=
, taskname[3:]))
=20
                 if not bb.utils.to_boolean(the_data.getVarFlag(taskname, '=
network')):
                     if bb.utils.is_local_uid(uid):
<div class=3D"moz-txt-sig">-</div></pre></div></blockquote><div><br></div><=
div>I think this is nearly right but it is possible the taskname might not =
start with "do_". I'd therefore suggest using:</div><div><br></div><div><di=
v><span class=3D"sig-prename descclassname"><span class=3D"pre">taskname.</=
span></span><span class=3D"sig-name descname"><span class=3D"pre">removepre=
fix</span></span><span class=3D"sig-paren">('do_')</span></div></div><div><=
br></div><div>instead.</div><div><br></div><div>Thanks,</div><div><br></div=
><div>Richard</div><div><br></div><div><br></div><div><br></div><div><span>=
</span></div></body></html>

--=-pLRDpKUMIClhL9rZMWq1--
