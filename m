Return-Path: <charlie.johnston@loftorbital.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D639AC3DA4A
	for <webhook@archiver.kernel.org>; Thu, 22 Aug 2024 18:30:40 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
 by mx.groups.io with SMTP id smtpd.web11.20409.1724351437296074537
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Aug 2024 11:30:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@loftorbital.com header.s=google header.b=dgJADn7G;
 spf=pass (domain: loftorbital.com, ip: 209.85.128.170, mailfrom: charlie.johnston@loftorbital.com)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6b44dd520ceso11893567b3.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Aug 2024 11:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loftorbital.com; s=google; t=1724351436; x=1724956236; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVvA1Fu9iM088FgB3idbJ38q0IGZ4QUTqQFNY33rdQY=;
        b=dgJADn7GVpOuK0njvjWrrdX6Kum8p3FKTes3ky7aNu0nn4qKaQljrhnFNl7oZFrD+N
         eJ1h1p7IMYpqn4R6CffkG8qFqsIVlQRgLDQ9sVlA1dKUI9Xaxy3acJ7ub16fdwtsEtvl
         /5RzPRLKC9yVzh80d6VuLOjcjRtu+mLzybQbVUsKx6O9JXHxOPT0WgbmrcTtwwPhiy1Q
         tzO2xQAgz1zyc4VdpHu79tORyvfLQCTttd2YZ4cTmHejhDwusdnP7nBJ/iwlkCWv4A+l
         iMFMfptFsyjRdjyt/RXpuyR9xpMkFcoKnj1X3PGfCigOc42PpIhL2hz/BuEuKYNMrD7V
         wdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351436; x=1724956236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVvA1Fu9iM088FgB3idbJ38q0IGZ4QUTqQFNY33rdQY=;
        b=i/XH7Xl0QCYxbEl8LFspq8I4S8QnniLFrOI3y+ECKOwX+p9Chzg3uuolFhWe61tjey
         AfhrfVCVAMFTzMToiJ3/XFfzaephd8iPTIXwOm3gclp60OJRd0eI+yTtM/kJJT30Iftg
         Kxse0WvNlZCWESqDazZRBIAAbzbT7JQrZR0r+LXyW3IagQq3dUZNNUkkDBSE56TAaprh
         JTjoaNb4KKrUPW7tRFH4KLs1+hU9ZgtsY72WqKTZBCFld9RG+MgZCBNDPwBuX8EsdZMc
         yxHWdKiHd7XLTJmCMRF6F3GXsnlL6Y8LlDTVz6HqXM/BGTmBa+xpVDZ3Z54ByfUkbuH5
         7mdw==
X-Gm-Message-State: AOJu0Yx9Q/hqPYEk61g1bDFyOdClO4R3lzbWFOnnPFeJpDcTLKBw+qvx
	EJhxgzUI9Zve3ks5Jxsrl7x/AoOVPXcqA65vqad3ZUE1wjLdSqv9LosyVXyEFqHvr37Hl8sj+Wo
	HWWOS0zLfPpFB9vVyG4ee9+O+WjqbLpusGhCuvOV9EHEFYdw8VsM=
X-Google-Smtp-Source: AGHT+IEaJtOPeWwKMNyAd7hcRm16dipogrUe+GO08a0K0kYRjNpgS3kltDrUbTnto4RgY1l3GF+dhn99i/FE2D1Vqzk=
X-Received: by 2002:a05:690c:4148:b0:6b2:7bd8:d7b8 with SMTP id
 00721157ae682-6c0ff236a10mr53698467b3.39.1724351436344; Thu, 22 Aug 2024
 11:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHUKmYaTcWnhQVcbD6GAnz5ymwUv3GwjfVx6d4kOyDCzrpCCQA@mail.gmail.com>
 <28323.1724262081445932896@lists.openembedded.org> <17EE06B6AD411EA3.9439@lists.openembedded.org>
 <CAHUKmYb+YSCixLXioM95SObLtVwsmAFFbOCuTKgpHkHS=hLNnA@mail.gmail.com>
In-Reply-To: <CAHUKmYb+YSCixLXioM95SObLtVwsmAFFbOCuTKgpHkHS=hLNnA@mail.gmail.com>
From: Charlie Johnston <charlie.johnston@loftorbital.com>
Date: Thu, 22 Aug 2024 12:30:24 -0600
Message-ID: <CAPSg+6w9BuL8Mbjnot=BcrfzzKHr_AGw=ezJJUCTHXp+njffoQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2: Ensure GCP fetcher checks if file
 exists before download.
To: Etienne Cordonnier <ecordonnier@snap.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Aug 2024 18:30:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16517

Yes, you understood correctly. Here's a small snippet from my local change:
         # Path sometimes has leading slash, so strip it
         path =3D ud.path.lstrip("/")
         blob =3D self.gcp_client.bucket(ud.host).blob(path)
+        if blob.exists() =3D=3D False:
+            raise FetchError(f"The GCP API reported that
gs://{ud.host}{ud.path} does not exist")
         blob.download_to_filename(ud.localpath)

I have the same use case as you (sstate cache and mirrors), plus a few
public keys stored in gcp for recipes to install internal public keys
on our lab devices. I think your patch is better, and it definitely
was more performant after trying it locally.

Thanks for catching this!
Charlie

On Thu, Aug 22, 2024 at 5:30=E2=80=AFAM Etienne Cordonnier <ecordonnier@sna=
p.com> wrote:
>
> "Is that approach acceptable, or is it better to bundle it into the downl=
oad_to_filename logic as you describe?"
>
> -> If I understand correctly you added a call to exists() inside the func=
tion download(), before doing the call to download_to_filename()? The advan=
tage of catching the exception thrown by download_to_filename instead of ad=
ding an additional call to exists() is that it does one network transaction=
 instead of two in the case where the file really exists. I think the perfo=
rmance is important there, because there are potentially thousands of calls=
 being done when using it as a fetch pre-mirror or sstate-cache mirror. May=
be we need to catch more exceptions than only the "NotFound" one however.
>
> =C3=89tienne
>
>
> On Thu, Aug 22, 2024 at 12:38=E2=80=AFPM Etienne Cordonnier via lists.ope=
nembedded.org <ecordonnier=3Dsnap.com@lists.openembedded.org> wrote:
>>
>> Hi Charlie,
>> I tested this patch locally, but I'm using google cloud only as state-ca=
che mirror, and I tested that it works when I try to call download() on a f=
ile which doesn't exist in the google cloud bucket. Does it work for your u=
se-case?
>>
>> =C3=89tienne
>>
>> From 2d10a74b01e4b6d9a7b7f94e62784e345ec85f0a Mon Sep 17 00:00:00 2001
>> From: Etienne Cordonnier <ecordonnier@snap.com>
>> Date: Wed, 21 Aug 2024 13:34:34 +0200
>> Subject: [PATCH] gcp.py: remove slow calls to gsutil stat
>>
>> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
>> ---
>>  bitbake/lib/bb/fetch2/gcp.py | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/gcp.py b/bitbake/lib/bb/fetch2/gcp.py
>> index eb3e0c6a6bb..9ac2f752f6b 100644
>> --- a/bitbake/lib/bb/fetch2/gcp.py
>> +++ b/bitbake/lib/bb/fetch2/gcp.py
>> @@ -19,11 +19,11 @@ Additionally, gsutil must also be installed.
>>
>>  import os
>>  import bb
>> +from google.api_core.exceptions import NotFound
>>  import urllib.parse, urllib.error
>>  from bb.fetch2 import FetchMethod
>>  from bb.fetch2 import FetchError
>>  from bb.fetch2 import logger
>> -from bb.fetch2 import runfetchcmd
>>
>>  class GCP(FetchMethod):
>>      """
>> @@ -48,7 +48,6 @@ class GCP(FetchMethod):
>>              ud.basename =3D os.path.basename(ud.path)
>>
>>          ud.localfile =3D d.expand(urllib.parse.unquote(ud.basename))
>> -        ud.basecmd =3D "gsutil stat"
>>
>>      def get_gcp_client(self):
>>          from google.cloud import storage
>> @@ -63,13 +62,15 @@ class GCP(FetchMethod):
>>          if self.gcp_client is None:
>>              self.get_gcp_client()
>>
>> -        bb.fetch2.check_network_access(d, ud.basecmd, f"gs://{ud.host}{=
ud.path}")
>> -        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"),=
 d)
>> +        bb.fetch2.check_network_access(d, "blob.download_to_filename", =
f"gs://{ud.host}{ud.path}")
>>
>>          # Path sometimes has leading slash, so strip it
>>          path =3D ud.path.lstrip("/")
>>          blob =3D self.gcp_client.bucket(ud.host).blob(path)
>> -        blob.download_to_filename(ud.localpath)
>> +        try:
>> +            blob.download_to_filename(ud.localpath)
>> +        except NotFound:
>> +            raise FetchError("The GCP API threw a NotFound exception")
>>
>>          # Additional sanity checks copied from the wget class (although=
 there
>>          # are no known issues which mean these are required, treat the =
GCP API
>> @@ -91,8 +92,7 @@ class GCP(FetchMethod):
>>          if self.gcp_client is None:
>>              self.get_gcp_client()
>>
>> -        bb.fetch2.check_network_access(d, ud.basecmd, f"gs://{ud.host}{=
ud.path}")
>> -        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"),=
 d)
>> +        bb.fetch2.check_network_access(d, "gcp_client.bucket(ud.host).b=
lob(path).exists()", f"gs://{ud.host}{ud.path}")
>>
>>          # Path sometimes has leading slash, so strip it
>>          path =3D ud.path.lstrip("/")
>> --
>> 2.43.0
>>
>>
>> On Wed, Aug 21, 2024 at 7:41=E2=80=AFPM Charlie Johnston via lists.opene=
mbedded.org <charlie.johnston=3Dloftorbital.com@lists.openembedded.org> wro=
te:
>>>
>>> Hello,
>>>
>>> I actually ran into the slowness of gsutil stat recently and have been =
testing a patch locally that does something similar to what you describe. T=
he difference is that I modified it to drop the runfetchcomd and raise a Fe=
tchError if self.gcp_client.bucket(ud.host).blob(path).exists()  is false.
>>> Is that approach acceptable, or is it better to bundle it into the down=
load_to_filename logic as you describe?
>>>
>>> Regards,
>>> Charlie
>>>
>>>
>>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#16515): https://urldefense.proofpoint.com/v2/url?u=
=3Dhttps-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_16515&d=3DDwI=
FaQ&c=3DncDTmphkJTvjIDPh0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj=
9TsRih1DULJTKUkSGa66m67E&m=3DhqGfVHbClPTscdMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp=
2ypdUAKDjAqWArfIIg&s=3DkCznyCMpR5CzmDe3KeIwDR5JM24ELmq8QZguI06JUuk&e=3D
>> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__=
lists.openembedded.org_mt_102834834_7048771&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh=
0hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E=
&m=3DhqGfVHbClPTscdMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&s=3Dt=
fd7JFbaM14OIscUydQKKmlSYkXlw08lV8SfY0gN-_s&e=3D
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__list=
s.openembedded.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3DncDTmphkJTvjIDPh0=
hpF_4vCHvabgGkICC2epckfdiw&r=3DAhkbNonVuMIGRfPx_Qj9TsRih1DULJTKUkSGa66m67E&=
m=3DhqGfVHbClPTscdMaVha_b7aC2hJiz3JOLacaaSf0Ybjrzp2ypdUAKDjAqWArfIIg&s=3Dc9=
W4p9VYP2ytBvDF3f0gpr_0bPqKxzKbTjzalHAwGyQ&e=3D  [ecordonnier@snap.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>

