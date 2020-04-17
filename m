Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
 by mx.groups.io with SMTP id smtpd.web11.1862.1587149687271775058
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Apr 2020 11:54:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=igIx4bww;
 spf=pass (domain: gmail.com, ip: 209.85.222.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ua1-f47.google.com with SMTP id a10so1030023uad.7
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Apr 2020 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8MjApn1bBSAnJlwpAZ1dKGp+YoctqF0uiALt8KbJMk=;
        b=igIx4bww6E7BU+PzGpLc1FiDn8PmCTd7yYcwN8+YnltrE0F1B5iEykYWr10ET+W1Xr
         OBzRwP8WL6JtI65AoYqk6oVvsd2wGCn3KD0zWKUzjbuYCOJEKQqx/vUJD7qyjMUA1o1I
         k6COUc+IaqlMLlUMnkuvHAyQGeQ5g1ugdw4fKt7ord+s2O6CoOytucsezY5X00klKPbS
         AXqJvmVIOCiLc8Dpmnc81y6TaZ1NG0trdku6I8/7u07l3oQNqXz+LAVbyp5TBXlW6Dsl
         wTaRQFsOuVRZvs/tSv29/FA6V+28DElAZgY7GkQrnffr7M7cBBDWwe7h+xYkZcyl6KXx
         7r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8MjApn1bBSAnJlwpAZ1dKGp+YoctqF0uiALt8KbJMk=;
        b=FaJ3iM34NoKdhXufrDEBa5Em+Hg4ZepyzusQUjgcGTcVY8mK+68hlvYWQ8UcPyMN2j
         ZjhcOfEapYnjKHsS288wO/DQB5Cxnz2yAKy7/TStKH9e7/0EsstnoA/1nQO2KQ4lDym+
         AoPjNqoFm0TdP4KYTiQvYI7YG6vmv1uHIyRKyUGKmSKNNUc+2VxTRKocddz1t69CKroJ
         UQ/Q6e+/ETS2O8xEzUiudN19oUuT+/k2E6j3kVKIM+mN9yyA/bjhnm0m2tS9iYj8lHCk
         ApW5ufpExp6fBw+UHLWWUl4VDf2pKHeIiNTZtEc92ZSb9FHe3kYAhT3k9aVUtOM3E7kD
         6uYQ==
X-Gm-Message-State: AGi0PuZEDDXkKchb44Zf3rDkQfdbXBEhHRQzoFuFO5pB2zzkoBDVcvOI
	MVCPCierlaXSpnh6es4FBY7Ih0SwEXg5GvV17dM=
X-Google-Smtp-Source: APiQypKPVEQ4TuWW1m11JbEjZ/oxeyIQabhj8QDOytCLUphkGYtYIFxCl+0lbKKQTlxztObHK80Rb/GCR8zXlTC10H8=
X-Received: by 2002:a9f:31c5:: with SMTP id w5mr204419uad.89.1587149686438;
 Fri, 17 Apr 2020 11:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <Gw3N.1587149101751917659.pi0R@lists.openembedded.org> <CANNYZj_NSKqs6E6sR1yMgFBohCg1W-Wdbh20rcJHEsQuJrt8ig@mail.gmail.com>
In-Reply-To: <CANNYZj_NSKqs6E6sR1yMgFBohCg1W-Wdbh20rcJHEsQuJrt8ig@mail.gmail.com>
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
Date: Fri, 17 Apr 2020 20:54:33 +0200
Message-ID: <CANNYZj8fXnTRGk9fT3K8tGOPwxLO6iWJ+ZD2QtWpVPqcAYeNKg@mail.gmail.com>
Subject: Re: [bitbake-devel] Significance of "SRCREV_FORMAT" variable for multiple sources fetch
To: abhishek.shah@broadcom.com
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000004400e005a38115fc"

--0000000000004400e005a38115fc
Content-Type: text/plain; charset="UTF-8"

I'd also suggest that you fix the source to create a relative symlink
rather than absolute one.

Alex

On Fri, 17 Apr 2020 at 20:53, Alexander Kanavin <alex.kanavin@gmail.com>
wrote:

> Which Yocto version are you on? Zeus and later is probably ok, earlier
> versions is not, as do_fetch task hash in the older versions does not
> include all the SRCREV variations, only the combined SRCPV. So if you
> change one of the SRCREV, it will erroneously not rebuild.
>
> Alex
>
> On Fri, 17 Apr 2020 at 20:45, Abhishek Shah via lists.openembedded.org
> <abhishek.shah=broadcom.com@lists.openembedded.org> wrote:
>
>> Hi,
>>
>> We have a recipe, which has multiple SRC_URI. For each SRC_URI, we have
>> specified SRCREV using SRCREV_name.
>>
>> I am facing issue when trying to add one more SRC_URI:
>>
>> While adding new source, I am updating SRCREV_FORMAT variable.
>> This causea lengthening of PATH where all the fetched source are
>> downloaded.
>> For example, if earlier location was
>>
>> tmp/yocto_build/poky/build/tmp/work/aarch64-poky-linux/xxx/gitAUTOINC+a20a30cd86_dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/
>> new location would be elongated something like:
>>
>> tmp/yocto_build/poky/build/tmp/work/aarch64-poky-linux/xxx/gitAUTOINC+a20a30cd86_
>> bfa48a337e_dbbf7c9b30_f3635d87f4_90d93a11ba_ae871b61ae_5ba575618e-r0/git/
>>
>> One of the source is using a Python script, which is using absolute PATH
>> to create a symlink.
>> Because of elongated PATH, I get below error:
>> os.symlink(directory, symlink)
>> OSError: [Errno 36] File name too long
>>
>> If I don't update SRCREV_FORMAT variable even after adding new source, I
>> do not see above issue.
>>
>> So, the question is, is that okay if we do not update SRCREV_FORMAT  when
>> adding new SRC_URI in the bitbake recipe? 
>>
>

--0000000000004400e005a38115fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;d also suggest that you fix the source to creat=
e a relative symlink rather than absolute one.</div><div><br></div><div>Ale=
x<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Fri, 17 Apr 2020 at 20:53, Alexander Kanavin &lt;<a href=3D"m=
ailto:alex.kanavin@gmail.com">alex.kanavin@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>W=
hich Yocto version are you on? Zeus and later is probably ok, earlier versi=
ons is not, as do_fetch task hash in the older versions does not include al=
l the SRCREV variations, only the combined SRCPV. So if you change one of t=
he SRCREV, it will erroneously not rebuild.<br></div><div><br></div><div>Al=
ex<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Fri, 17 Apr 2020 at 20:45, Abhishek Shah via <a href=3D"http=
://lists.openembedded.org" target=3D"_blank">lists.openembedded.org</a> &lt=
;abhishek.shah=3D<a href=3D"mailto:broadcom.com@lists.openembedded.org" tar=
get=3D"_blank">broadcom.com@lists.openembedded.org</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br><br>We have a reci=
pe, which has multiple SRC_URI. For each SRC_URI, we have specified=C2=A0SR=
CREV using SRCREV_name.<br><br>I am facing issue when trying to add one mor=
e SRC_URI:<br><br>While adding new source, I am updating=C2=A0SRCREV_FORMAT=
 variable.<br>This causea lengthening of PATH where all the fetched source =
are downloaded.<br>For example, if earlier location was<br><span style=3D"c=
olor:rgb(0,0,0);font-family:&quot;Courier New&quot;,Courier,monospace;font-=
size:11.2px;white-space:pre-wrap">tmp/yocto_build/poky/build/tmp/work/aarch=
64-poky-linux/xxx/gitAUTOINC+a20a30cd86_dbbf7c9b30_f3635d87f4_90d93a11ba_ae=
871b61ae_5ba575618e-r0/git/</span><br>new location would be elongated somet=
hing like:<br><span style=3D"color:rgb(0,0,0);font-family:&quot;Courier New=
&quot;,Courier,monospace;font-size:11.2px;white-space:pre-wrap">tmp/yocto_b=
uild/poky/build/tmp/work/aarch64-poky-linux/xxx/gitAUTOINC+a20a30cd86_</spa=
n><span style=3D"color:rgb(0,0,0);font-family:&quot;Courier New&quot;,Couri=
er,monospace;font-size:11.2px;white-space:pre-wrap">bfa48a337e_</span><span=
 style=3D"color:rgb(0,0,0);font-family:&quot;Courier New&quot;,Courier,mono=
space;font-size:11.2px;white-space:pre-wrap">dbbf7c9b30_f3635d87f4_90d93a11=
ba_ae871b61ae_5ba575618e-r0/git/<br></span><br>One of the source is using a=
 Python script, which is using absolute PATH to create a symlink.<br>Becaus=
e of elongated PATH, I get below error:<br><span style=3D"color:rgb(0,0,0);=
font-family:&quot;Courier New&quot;,Courier,monospace;font-size:11.2px;whit=
e-space:pre-wrap">os.symlink(directory, symlink)</span><br style=3D"color:r=
gb(0,0,0);font-family:&quot;Courier New&quot;,Courier,monospace;font-size:1=
1.2px;white-space:pre-wrap"><span style=3D"color:rgb(0,0,0);font-family:&qu=
ot;Courier New&quot;,Courier,monospace;font-size:11.2px;white-space:pre-wra=
p">OSError: [Errno 36] File name too long<br><br></span>If I don&#39;t upda=
te SRCREV_FORMAT=C2=A0variable even after adding new source, I do not see a=
bove issue.<br><br>So, the question is, is that okay if we do not update SR=
CREV_FORMAT=C2=A0 when adding new SRC_URI in the bitbake recipe?
<br>
</blockquote></div>
</blockquote></div>

--0000000000004400e005a38115fc--
