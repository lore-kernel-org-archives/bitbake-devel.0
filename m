Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E607EA8132
	for <webhook@archiver.kernel.org>; Tue, 10 Feb 2026 15:36:25 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22472.1770737783940005470
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Feb 2026 07:36:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gOSS+IXL;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8845cb580bso701078966b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 07:36:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770737782; cv=none;
        d=google.com; s=arc-20240605;
        b=PV1ymzZhkXNhrtm6ULx0o0iNBpyR6E+RURjuuFIfIg1IRhumgSrRkxo+tNvI1XPqvm
         KKQMCSlvcryEItrtO0yTq4x1Lbd5rWcPVve7tUC1ojRiEZGwbOjMgKgltF17cOxDbxKz
         JNmaFddAX3XOCYHoUuV7mH2UdULKMdel/ZR3SUwgOpE01ICEilxZVhK6Vhn3tXzWRpjQ
         TQJFXgjY4yHjEeNs9GVzdZEpTGX0KIjrAZ27vCNvVAg4ln47XGo6TALDPfbcidg/roqU
         rRaruu2o+VTbHogADGzlj14Yn2nFsIxWLb14unSSTFwQIWzcY7RjGIXKabBe/Cq5LSkN
         94Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hBXLyGJZhnVj3nQbJGKnivLZ+T1KcvMNGPiy3O6mFEo=;
        fh=1KDj+K9OrANCknrwOqS3xRhHIOGqxQtlibDmBngdm44=;
        b=lDeXN9HQnBAFlfU3IGADgd0ggBLrOWYLytPnZ/7huxKXdGunI1mnMoNjwgayL03XSX
         MNA37H++IugX/+MWvaujV9NQ47XSIY1Q26jAQ3JeSfHJgpKYn0KD9LbkYWqrJNwVk3EJ
         0q7n6qyklQgMqw2ssR4cTgDQ4+BD8Ef4i1CUWfMrF3nw2ByIlAvB5QVXJn5+i+jVZxDZ
         crkHkV4jG6S6KD2LOvbP9VXguC0MhZePETUnNXOaExVATGnGx01dQ59ZFmU6LlSY4E6D
         oIyzKXSpMXtnkR6E5iO3lrpkpyjd6WyL1E0r4WYEQPX7CULlBETRLYEcQaLRZZpOtJiA
         xOyQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770737782; x=1771342582; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hBXLyGJZhnVj3nQbJGKnivLZ+T1KcvMNGPiy3O6mFEo=;
        b=gOSS+IXLHEZ8PBOql6ES3vgpAMy3hAjPWMH850D8aRnNfQWhT9H6B2b9WVfx0n8WXW
         b8OKuIqKWFcX7ZlCkCA72pLTBM9vcH+hWlqnwK0k7lIGLWW/hrUt6qkwZwj7iMpD8OF3
         YFFLZoga4ZpRfVqvmS6nkxYYA1S+EKSIPCdyaQH4BAqFrHQvAMeYr4NhV9DO+mVFN3qB
         wBvf5VMJEL7+sBWWyJ/huU3hA3a1UZXiQKcTQygO0pOTrUFgEO8b3iqD0aPsQ4ChZ7O7
         NJYaxA59hL4fvtqbK3yZjWYVUXzxrAOfWmAhz4KL6JY0THGPtjqKR9pvmSn8vJktwAOb
         R1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770737782; x=1771342582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBXLyGJZhnVj3nQbJGKnivLZ+T1KcvMNGPiy3O6mFEo=;
        b=bCoqetP2d/dk+wSc49dMhthTw6BQ1hTFi8JT/eHt9vam++Vn0dJ+Y9sDNH7w4AEBmC
         Sfd5yRF7sDUix0bLdzkOzWOVV1OYz/8GuhAjUqLw1f1IkE6jf/v7Gir2h6PGbAh535N2
         4FEyajpHqVTSlSwHChhddZpULp0ArJAtjsLdeUQScyisL0Q63AQuwMHMcD/4ojuNM6JB
         0F6Y7ozUnWkhFfGKkCBVFMuJwjajrBWkHzAW2wxC3Bbih0dHA4Jg/mQQxaCp+ZFhPQ2+
         u1kOmGPupULnQHfNdtpFWIjL9WIfabSByHSswCqELJQFYjgBE1dj17tuNmyHvT1uvWzw
         4lEQ==
X-Gm-Message-State: AOJu0YwOgiWFJW1wibq/0mPWppbUKaLdUQWtGEsEjeZL3JBFQ2yEPK90
	kmNXuRUU+E2MTmbGpVif/28fEttiHqPFxCmeHf8xiA+nX647p2UjS8HTpZO0QNTM/7/eTOqwvwP
	mBaHZZZRt9zii0fJHFg+3enUtHICkUPg=
X-Gm-Gg: AZuq6aIvr1ixYZPtpZbmrKLWimQEElzPpkIGMclFC4MtM4abf1D08rtMtfVXuaBxTab
	WFsNn5qjuo+hWR6NArnbt30LR+rN7NeOyxLwNWPGz3bjKmVJdmcm45yowABTNerElNEdDpI6eZL
	ovXZrowmPBD7scLbNQi/ZivK4TdFGRe8QxYNBXXYf204h0RZvAtmYB1Kr7Pdd3Qur5hlGgyoIm7
	gOrxtBeQoHQ7QAwpNtPEiP9etmVuLx9XBmVHZwFKzQuM/dysRENvJH30fLcMxEB0wHFhHWWUuh2
	9GP/WeOk3w==
X-Received: by 2002:a17:907:9690:b0:b88:317a:3f40 with SMTP id
 a640c23a62f3a-b8edf3506b4mr838925366b.38.1770737781684; Tue, 10 Feb 2026
 07:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20260129120421.4413-1-alex.kanavin@gmail.com>
In-Reply-To: <20260129120421.4413-1-alex.kanavin@gmail.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Tue, 10 Feb 2026 15:36:09 +0000
X-Gm-Features: AZwV_QjVsR7MzVQH4YsnVgvfmXVHXnh7-nxMs10_Wv5_jQCHQh7EAdS6AYSfUUU
Message-ID: <CANPvuR=3_qR3ZFbq_JArT0OjZ67jEh65jPM=zmjx9rktayq6yQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v3 1/2] cooker: use BB_HASHSERVE_DB_DIR
 for hash server database location
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="00000000000077bd30064a7a04ce"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Feb 2026 15:36:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18999

--00000000000077bd30064a7a04ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alexander Kanavin via lists.openembedded.org <alex.kanavin=3D
gmail.com@lists.openembedded.org> escreveu (quinta, 29/01/2026 =C3=A0(s) 12=
:04):

> From: Alexander Kanavin <alex@linutronix.de>
>
> If unset, the existing behavior is preseved.
>
> The use case is sharing the database in bitbake-setup's driven builds
> without having to set up/start/stop a common single server shared
> between them (this is added to bitbake-setup in the next commit).
>
> Also create the specified directory if it doesn't yet exist.
>
> Add a check that the directory is not on a NFS path, and error out then,
> guiding the user to set up a standalone hash equivalency server.
>
> Note: the check runs 'stat' executable with a format string parameter,
> ensuring it prints only the filesystem type and nothing else.
> Python's standard library does not have a statfs() wrapper,
> and using ctypes to call into it would've required delicate,
> crash-prone data type definitions, full of magic numbers.
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  .../bitbake-user-manual-ref-variables.rst     | 23 +++++++++++++++++++
>  lib/bb/cooker.py                              | 11 ++++++++-
>  lib/bb/utils.py                               |  8 +++++++
>  3 files changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t
> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index af911f306..4b3b10d46 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -475,6 +475,29 @@ overview of their function and contents.
>        equivalences that correspond to Share State caches that are
>        only available on specific clients.
>
> +   :term:`BB_HASHSERVE_DB_DIR`
> +      When :term:`BB_HASHSERVE` is set to ``auto``, bitbake will use
> +      a private location inside a particular build directory for the
> sqlite
> +      database file that holds hash equivalency data.
> +
> +      This variable allows using a different path, which can be shared
> +      between multiple build directories and bitbake instances
> +      that operate on them. This enables using a common ``${SSTATE_DIR}`=
`
> +      together with common hash equivalency data for local builds,
> without having to
> +      separately manage a hash equivalency server.
> +
> +      .. note::
> +
> +         This variable cannot be set to a NFS mount and bitbake will
> error out then.
> +         The reason is that NFS implementations can have file locking
> issues, which
> +         can cause data loss and corruption when there are multiple
> writers operating
> +         on a file at the same time as explained in
> https://sqlite.org/faq.html#q5
> +
> +         If you'd like to share hash equivalency data between multiple
> computers, you
> +         need to set up a hash equivalency server separately and point
> :term:`BB_HASHSERVE`
> +         to it. See
> https://docs.yoctoproject.org/dev-manual/hashequivserver.html for
> +         additional information.
> +
>     :term:`BB_HASHSERVE_UPSTREAM`
>        Specifies an upstream Hash Equivalence server.
>
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index fa7747d64..4b6ba3196 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -328,7 +328,16 @@ class BBCooker:
>          if self.data.getVar("BB_HASHSERVE") =3D=3D "auto":
>              # Create a new hash server bound to a unix domain socket
>              if not self.hashserv:
> -                dbfile =3D (self.data.getVar("PERSISTENT_DIR") or
> self.data.getVar("CACHE")) + "/hashserv.db"
> +                bb_hashserve_db_dir =3D
> self.data.getVar("BB_HASHSERVE_DB_DIR")
> +                if bb_hashserve_db_dir and
> utils.is_path_on_nfs(bb_hashserve_db_dir):
>

There is little issue on this, we should check if the bb_hashserve_db_dir
exists on the file system first before checking the is_path_on_nfs.
Because is the user provide a path that does not exist and will be created
bellow in os.makedirs it fails with:

stat: cannot read file system information for '/path/to/my/hashserve': No
such file or directory

Jose

+                    bb.fatal("""Hash equivalency database location (set
> via BB_HASHSERVE_DB_DIR to {})
> +cannot be on a NFS mount due to potential NFS locking issues between
> sqlite clients, per https://sqlite.org/faq.html#q5
> +
> +If you need to share the database between several computers, set up a
> permanently running hash equivalency server
> +according to
> https://docs.yoctoproject.org/dev-manual/hashequivserver.html
> """.format(bb_hashserve_db_dir))
> +                dbdir =3D bb_hashserve_db_dir or
> self.data.getVar("PERSISTENT_DIR") or self.data.getVar("CACHE")
> +                os.makedirs(dbdir, exist_ok=3DTrue)
> +                dbfile =3D dbdir + "/hashserv.db"
>                  upstream =3D self.data.getVar("BB_HASHSERVE_UPSTREAM") o=
r
> None
>                  if upstream:
>                      try:
> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
> index 366836bfc..974611bc7 100644
> --- a/lib/bb/utils.py
> +++ b/lib/bb/utils.py
> @@ -2264,3 +2264,11 @@ def lock_timeout_nocheck(lock):
>          if l:
>              lock.release()
>          sigmask(signal.SIG_SETMASK, s)
> +
> +def is_path_on_nfs(path):
> +    """
> +    Returns True if ``path`` argument is on a NFS mount.
> +    """
> +    import bb.process
> +    fstype =3D bb.process.run("stat -f -c %T {}".format(path))[0].strip(=
)
> +    return fstype =3D=3D "nfs"
> --
> 2.47.3
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18933):
> https://lists.openembedded.org/g/bitbake-devel/message/18933
> Mute This Topic: https://lists.openembedded.org/mt/117524701/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--00000000000077bd30064a7a04ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Alexander Kanav=
in via <a href=3D"http://lists.openembedded.org">lists.openembedded.org</a>=
 &lt;alex.kanavin=3D<a href=3D"mailto:gmail.com@lists.openembedded.org">gma=
il.com@lists.openembedded.org</a>&gt; escreveu (quinta, 29/01/2026 =C3=A0(s=
) 12:04):<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: =
Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" target=3D"_blan=
k">alex@linutronix.de</a>&gt;<br>
<br>
If unset, the existing behavior is preseved.<br>
<br>
The use case is sharing the database in bitbake-setup&#39;s driven builds<b=
r>
without having to set up/start/stop a common single server shared<br>
between them (this is added to bitbake-setup in the next commit).<br>
<br>
Also create the specified directory if it doesn&#39;t yet exist.<br>
<br>
Add a check that the directory is not on a NFS path, and error out then,<br=
>
guiding the user to set up a standalone hash equivalency server.<br>
<br>
Note: the check runs &#39;stat&#39; executable with a format string paramet=
er,<br>
ensuring it prints only the filesystem type and nothing else.<br>
Python&#39;s standard library does not have a statfs() wrapper,<br>
and using ctypes to call into it would&#39;ve required delicate,<br>
crash-prone data type definitions, full of magic numbers.<br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" =
target=3D"_blank">alex@linutronix.de</a>&gt;<br>
---<br>
=C2=A0.../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0| 23 +++=
++++++++++++++++<br>
=C2=A0lib/bb/cooker.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11 ++++++++-<br>
=C2=A0lib/bb/utils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++++=
+<br>
=C2=A03 files changed, 41 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
index af911f306..4b3b10d46 100644<br>
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
@@ -475,6 +475,29 @@ overview of their function and contents.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0equivalences that correspond to Share State cach=
es that are<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0only available on specific clients.<br>
<br>
+=C2=A0 =C2=A0:term:`BB_HASHSERVE_DB_DIR`<br>
+=C2=A0 =C2=A0 =C2=A0 When :term:`BB_HASHSERVE` is set to ``auto``, bitbake=
 will use<br>
+=C2=A0 =C2=A0 =C2=A0 a private location inside a particular build director=
y for the sqlite<br>
+=C2=A0 =C2=A0 =C2=A0 database file that holds hash equivalency data.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 This variable allows using a different path, which ca=
n be shared<br>
+=C2=A0 =C2=A0 =C2=A0 between multiple build directories and bitbake instan=
ces<br>
+=C2=A0 =C2=A0 =C2=A0 that operate on them. This enables using a common ``$=
{SSTATE_DIR}``<br>
+=C2=A0 =C2=A0 =C2=A0 together with common hash equivalency data for local =
builds, without having to<br>
+=C2=A0 =C2=A0 =C2=A0 separately manage a hash equivalency server.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 .. note::<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This variable cannot be set to a NFS mou=
nt and bitbake will error out then.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The reason is that NFS implementations c=
an have file locking issues, which<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0can cause data loss and corruption when =
there are multiple writers operating<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0on a file at the same time as explained =
in <a href=3D"https://sqlite.org/faq.html#q5" rel=3D"noreferrer" target=3D"=
_blank">https://sqlite.org/faq.html#q5</a><br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you&#39;d like to share hash equivale=
ncy data between multiple computers, you<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0need to set up a hash equivalency server=
 separately and point :term:`BB_HASHSERVE`<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to it. See <a href=3D"https://docs.yocto=
project.org/dev-manual/hashequivserver.html" rel=3D"noreferrer" target=3D"_=
blank">https://docs.yoctoproject.org/dev-manual/hashequivserver.html</a> fo=
r<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0additional information.<br>
+<br>
=C2=A0 =C2=A0 :term:`BB_HASHSERVE_UPSTREAM`<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Specifies an upstream Hash Equivalence server.<b=
r>
<br>
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py<br>
index fa7747d64..4b6ba3196 100644<br>
--- a/lib/bb/cooker.py<br>
+++ b/lib/bb/cooker.py<br>
@@ -328,7 +328,16 @@ class BBCooker:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.data.getVar(&quot;BB_HASHSERVE&qu=
ot;) =3D=3D &quot;auto&quot;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Create a new hash server =
bound to a unix domain socket<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.hashserv:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbfile =3D (self.d=
ata.getVar(&quot;PERSISTENT_DIR&quot;) or self.data.getVar(&quot;CACHE&quot=
;)) + &quot;/hashserv.db&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb_hashserve_db_di=
r =3D self.data.getVar(&quot;BB_HASHSERVE_DB_DIR&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if bb_hashserve_db=
_dir and utils.is_path_on_nfs(bb_hashserve_db_dir):<br></blockquote><div><b=
r></div><div>There is little=C2=A0issue on this, we should check if the bb_=
hashserve_db_dir exists on the file system first before checking the is_pat=
h_on_nfs.</div><div>Because is the user provide a path=C2=A0that does not e=
xist and will be created bellow in os.makedirs it fails with:</div><div><br=
></div><div>stat: cannot read file system information for &#39;/path/to/my/=
hashserve&#39;: No such file or directory<br></div><div><br></div><div>Jose=
=C2=A0</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.f=
atal(&quot;&quot;&quot;Hash equivalency database location (set via BB_HASHS=
ERVE_DB_DIR to {})<br>
+cannot be on a NFS mount due to potential NFS locking issues between sqlit=
e clients, per <a href=3D"https://sqlite.org/faq.html#q5" rel=3D"noreferrer=
" target=3D"_blank">https://sqlite.org/faq.html#q5</a><br>
+<br>
+If you need to share the database between several computers, set up a perm=
anently running hash equivalency server<br>
+according to <a href=3D"https://docs.yoctoproject.org/dev-manual/hashequiv=
server.html" rel=3D"noreferrer" target=3D"_blank">https://docs.yoctoproject=
.org/dev-manual/hashequivserver.html</a>&quot;&quot;&quot;.format(bb_hashse=
rve_db_dir))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbdir =3D bb_hashs=
erve_db_dir or self.data.getVar(&quot;PERSISTENT_DIR&quot;) or self.data.ge=
tVar(&quot;CACHE&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.makedirs(dbdir,=
 exist_ok=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbfile =3D dbdir +=
 &quot;/hashserv.db&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0upstream =3D =
self.data.getVar(&quot;BB_HASHSERVE_UPSTREAM&quot;) or None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if upstream:<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0try:<br>
diff --git a/lib/bb/utils.py b/lib/bb/utils.py<br>
index 366836bfc..974611bc7 100644<br>
--- a/lib/bb/utils.py<br>
+++ b/lib/bb/utils.py<br>
@@ -2264,3 +2264,11 @@ def lock_timeout_nocheck(lock):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if l:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lock.release()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sigmask(signal.SIG_SETMASK, s)<br>
+<br>
+def is_path_on_nfs(path):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 Returns True if ``path`` argument is on a NFS mount.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 import bb.process<br>
+=C2=A0 =C2=A0 fstype =3D bb.process.run(&quot;stat -f -c %T {}&quot;.forma=
t(path))[0].strip()<br>
+=C2=A0 =C2=A0 return fstype =3D=3D &quot;nfs&quot;<br>
-- <br>
2.47.3<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#18933): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/18933" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/18933</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/117524701/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/117524701/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></=
div></div></div>

--00000000000077bd30064a7a04ce--

