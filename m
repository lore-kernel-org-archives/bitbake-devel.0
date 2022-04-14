Return-Path: <marius.kriegerowski@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08305C63704
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:57 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web10.10658.1649936605935367399
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 04:43:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Xc4Chie5;
 spf=pass (domain: gmail.com, ip: 209.85.208.50,
 mailfrom: marius.kriegerowski@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id v4so5984419edl.7
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fvi24Ika/E4d7QDMRcS24sKyv60jeNtPj0YqWrAImi4=;
        b=Xc4Chie5rfFeoSEX6lsnSjppInDwO4cO0sjvgG+sPRL/6eE7kXRuYtZQ6I2xDKenkt
         lG0iw5FuZTQSwX3Xh/NVFrdXWKuTMyaaHaKntq9FbhrcKZEeiMbP7G+8F53ImY4Gmowf
         AsZHWZ3wBje7KwfDY89oAP6bHUkfYx+LGk8Ry6R4H4NZ/ilbnknR53jex7Uehw+fyD7s
         oXst77RnlsFCJhZeHsAb2dThMZdadq3dRy9wsVydVf4JmWYcE+nF0bi/9/6c2BUjMrn8
         c497qxFwMxxfAFVipRcsSoNjxn4CtzWRNsjbz1bv9zaq1+QmRd3Nr8U2uQgj+Ygx98W5
         7X/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fvi24Ika/E4d7QDMRcS24sKyv60jeNtPj0YqWrAImi4=;
        b=ooeW9hZSmGueJ9QSWDtnUXI+8OSLJBHnEwix4d/dUxTI8xhFaj5RDa0yioplpCwo0F
         vQnKLt1XUj5LhHjJHNWSHnOamkHl2nCuDQ3q5uXdY4S0Vcem/s8c5x8s3gyQdxgNdnoa
         TrS2yJw3uhv+UG+Ae5/0eSJRecWmi6YdBg9xFfcCs5n3RylyoEuYytKy7pSERccStwqv
         JP9jzhqRwxKhLLaZaKJZgs4Hd6R4ba13PyF4yd382w75EPwrv5BM4p5ktiimCOeQEvSN
         2BLH04E/MO6yj+zYXm/VLdAAkC87iGtO8QO2++xmAx6HeJQZxv1NvAx3rERMfUMTQ15U
         DYuA==
X-Gm-Message-State: AOAM530b0AzwAZT56E46p3r+18ycbWsjTQi2Vb1KGK+JlePMV0DEBrhY
	Prcc5tR5zxNPMXHfPobM57Xnhb8djAo=
X-Google-Smtp-Source: 
 ABdhPJyGLDykSA2+Vc2C+VxER3d+jIy1YKBMQ/9ifC2YNc+60I5C/GdIAcLmaUY4Tj3zlVVC3Rjj5Q==
X-Received: by 2002:a50:fe81:0:b0:419:16a5:d265 with SMTP id
 d1-20020a50fe81000000b0041916a5d265mr2520516edt.4.1649936604441;
        Thu, 14 Apr 2022 04:43:24 -0700 (PDT)
Received: from smtpclient.apple
 (dslb-178-003-195-224.178.003.pools.vodafone-ip.de. [178.3.195.224])
        by smtp.gmail.com with ESMTPSA id
 10-20020a170906310a00b006e834953b55sm535995ejx.27.2022.04.14.04.43.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2022 04:43:23 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [bitbake-devel] [PATCH] scriptutils: fix style to be more PEP8
 compliant
From: Marius Kriegerowski <marius.kriegerowski@gmail.com>
In-Reply-To: <YlfllwA72TEcOCPX@mail.local>
Date: Thu, 14 Apr 2022 13:43:22 +0200
Cc: bitbake-devel@lists.openembedded.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <49046AA1-E85B-4373-9208-0016EC418B5F@gmail.com>
References: <20220413141922.41322-1-marius.kriegerowski@gmail.com>
 <YlfllwA72TEcOCPX@mail.local>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 16:03:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13618

Hi,
Thanks for the reply. I rebased on master and just resent the patch. I =
think this procedure created a new email thread and didn=E2=80=99t =
attach to this one.
Not sure if this is the way it=E2=80=99s supposed to be.
Sorry for the inconvenience
Best

Marius

=20

> On 14. Apr 2022, at 11:12, Alexandre Belloni =
<alexandre.belloni@bootlin.com> wrote:
>=20
> Hello,
>=20
> This doesn't apply on master, can you rebase?
>=20
> Thanks!
>=20
> On 13/04/2022 16:19:22+0200, Marius Kriegerowski wrote:
>> Signed-off-by: Marius Kriegerowski <marius.kriegerowski@gmail.com>
>> ---
>> scripts/lib/scriptutils.py | 23 +++++++++++++++--------
>> 1 file changed, 15 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/scripts/lib/scriptutils.py b/scripts/lib/scriptutils.py
>> index adf81476f0..b265b5c838 100644
>> --- a/scripts/lib/scriptutils.py
>> +++ b/scripts/lib/scriptutils.py
>> @@ -5,7 +5,6 @@
>> # SPDX-License-Identifier: GPL-2.0-only
>> #
>>=20
>> -import argparse
>> import glob
>> import logging
>> import os
>> @@ -21,11 +20,12 @@ import importlib
>> import importlib.machinery
>> import importlib.util
>>=20
>> +
>> class KeepAliveStreamHandler(logging.StreamHandler):
>>     def __init__(self, keepalive=3DTrue, **kwargs):
>>         super().__init__(**kwargs)
>>         if keepalive is True:
>> -            keepalive =3D 5000 # default timeout
>> +            keepalive =3D 5000  # default timeout
>>         self._timeout =3D threading.Condition()
>>         self._stop =3D False
>>=20
>> @@ -36,9 +36,9 @@ class =
KeepAliveStreamHandler(logging.StreamHandler):
>>                 with self._timeout:
>>                     if not self._timeout.wait(keepalive):
>>                         self.emit(logging.LogRecord("keepalive", =
logging.INFO,
>> -                            None, None, "Keepalive message", None, =
None))
>> +                                                    None, None, =
"Keepalive message", None, None))
>>=20
>> -        self._thread =3D threading.Thread(target =3D thread, daemon =
=3D True)
>> +        self._thread =3D threading.Thread(target=3Dthread, =
daemon=3DTrue)
>>         self._thread.start()
>>=20
>>     def close(self):
>> @@ -56,6 +56,7 @@ class =
KeepAliveStreamHandler(logging.StreamHandler):
>>         with self._timeout:
>>             self._timeout.notify()
>>=20
>> +
>> def logger_create(name, stream=3DNone, keepalive=3DNone):
>>     logger =3D logging.getLogger(name)
>>     if keepalive is not None:
>> @@ -67,21 +68,21 @@ def logger_create(name, stream=3DNone, =
keepalive=3DNone):
>>     logger.setLevel(logging.INFO)
>>     return logger
>>=20
>> +
>> def logger_setup_color(logger, color=3D'auto'):
>>     from bb.msg import BBLogFormatter
>>=20
>>     for handler in logger.handlers:
>>         if (isinstance(handler, logging.StreamHandler) and
>> -            isinstance(handler.formatter, BBLogFormatter)):
>> +                isinstance(handler.formatter, BBLogFormatter)):
>>             if color =3D=3D 'always' or (color =3D=3D 'auto' and =
handler.stream.isatty()):
>>                 handler.formatter.enable_color()
>>=20
>>=20
>> def load_plugins(logger, plugins, pluginpath):
>> -
>>     def load_plugin(name):
>>         logger.debug('Loading plugin %s' % name)
>> -        spec =3D importlib.machinery.PathFinder.find_spec(name, =
path=3D[pluginpath] )
>> +        spec =3D importlib.machinery.PathFinder.find_spec(name, =
path=3D[pluginpath])
>>         if spec:
>>             mod =3D importlib.util.module_from_spec(spec)
>>             spec.loader.exec_module(mod)
>> @@ -112,6 +113,7 @@ def git_convert_standalone_clone(repodir):
>>             bb.process.run('git repack -a', cwd=3Drepodir)
>>             os.remove(alternatesfile)
>>=20
>> +
>> def _get_temp_recipe_dir(d):
>>     # This is a little bit hacky but we need to find a place where we =
can put
>>     # the recipe so that bitbake can find it. We're going to delete =
it at the
>> @@ -128,12 +130,15 @@ def _get_temp_recipe_dir(d):
>>                     break
>>     return fetchrecipedir
>>=20
>> +
>> class FetchUrlFailure(Exception):
>>     def __init__(self, url):
>>         self.url =3D url
>> +
>>     def __str__(self):
>>         return "Failed to fetch URL %s" % self.url
>>=20
>> +
>> def fetch_url(tinfoil, srcuri, srcrev, destdir, logger, =
preserve_tmp=3DFalse, mirrors=3DFalse):
>>     """
>>     Fetch the specified URL using normal do_fetch and do_unpack =
tasks, i.e.
>> @@ -254,12 +259,13 @@ def run_editor(fn, logger=3DNone):
>>=20
>>     editor =3D os.getenv('VISUAL', os.getenv('EDITOR', 'vi'))
>>     try:
>> -        #print(shlex.split(editor) + files)
>> +        # print(shlex.split(editor) + files)
>>         return subprocess.check_call(shlex.split(editor) + files)
>>     except subprocess.CalledProcessError as exc:
>>         logger.error("Execution of '%s' failed: %s" % (editor, exc))
>>         return 1
>>=20
>> +
>> def is_src_url(param):
>>     """
>>     Check if a parameter is a URL and return True if so
>> @@ -273,6 +279,7 @@ def is_src_url(param):
>>         return True
>>     return False
>>=20
>> +
>> def filter_src_subdirs(pth):
>>     """
>>     Filter out subdirectories of initial unpacked source trees that =
we do not care about.
>> --=20
>> 2.32.0 (Apple Git-132)
>>=20
>=20
>>=20
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#13613): =
https://lists.openembedded.org/g/bitbake-devel/message/13613
>> Mute This Topic: https://lists.openembedded.org/mt/90441542/3617179
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub =
[alexandre.belloni@bootlin.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>=20
>=20
>=20
> --=20
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


