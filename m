Return-Path: <ross.burton@intel.com>
Received: from mail-qk0-f182.google.com (mail-qk0-f182.google.com
	[209.85.220.182])
	by mail.openembedded.org (Postfix) with ESMTP id 8C3F56AD0D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Jun 2015 09:51:42 +0000 (UTC)
Received: by qkx62 with SMTP id 62so20888877qkx.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Jun 2015 02:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=0fOZAcU+wnPQsZt+CKzdTu8iQ0e6zcdr9JIGBTuaidI=;
	b=eAYMjMQeGuFw/+wofogD1gsJSyPjQ+gyypDJ8UegzEiW+EWeOCpQS94irLz065kYvS
	fTdLkGKPYx3kPFmeUQUr/U5puG8dtW5MpI4Q0YJE6O6dAd3125qA8/V5zgAYvCG6l2Io
	pLFoRy++JVK2QBlZJJb4NPoeMdEbVHKTdlS8HU/NTzMxaS5KmJgCGqpUAcfGeQDKGN+6
	B8Q07zmVtRXiVqaz7g7OiPEKNn8mSqgyGUWM1hmWoaDhC8utwkBn1GR/YhJLO7U487oR
	H2bPDVSy0paNX9yOZ9G2aaItoMNQKDJISEsMB9F3XqlMThY3LFiS+OKHkJdPsSS2rGco
	tgAw==
X-Gm-Message-State: ALoCoQlkLLPA28zihjcX0t8kUK5Yx+w11zJQdXMkE1ucv7IPpOVUDS2XMcDZLV3maXvfAxoCdDOU
X-Received: by 10.55.18.155 with SMTP id 27mr69339663qks.36.1433411504303;
	Thu, 04 Jun 2015 02:51:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.231 with HTTP; Thu, 4 Jun 2015 02:51:23 -0700 (PDT)
In-Reply-To: <B8A83673-75A0-4880-97BE-1712A4093058@gmail.com>
References: <CADL-HDjK_5Z8Ndj8sAK8tt11+xuPQig11fNkQaDCb__19aRo6A@mail.gmail.com>
	<CAJTo0LZjuTKFwuy1HGm4VeP0gfLHjufRqPd3gXEY3Yoeg4mZ8A@mail.gmail.com>
	<CADL-HDjApC0qsSDJpZPVDEU21nR+z7fxLg8s+818pfQHY6pgGA@mail.gmail.com>
	<CAJTo0LZZGOkLUUgJduR75GE+nvZNEX8ogYmBUvuvezWGjVZyrg@mail.gmail.com>
	<CADL-HDjq9+Q7+FDHvsCsK_u2K1ygmn_410jF0aF9kAaDg3hf4A@mail.gmail.com>
	<CAJTo0LYHok7aqeq5VG-bBq6L=tge_k40i2urOPp9=KWvLf894w@mail.gmail.com>
	<CADL-HDiPMeR7zdiW99j10TEAhjzUzaqzQkMLnvOWiqdSfPRMHA@mail.gmail.com>
	<CAJTo0LYwFRrNT9xnjd43c4+_dMTJvMhAsbJTOdW4e6YXKJP3yg@mail.gmail.com>
	<B8A83673-75A0-4880-97BE-1712A4093058@gmail.com>
From: "Burton, Ross" <ross.burton@intel.com>
Date: Thu, 4 Jun 2015 10:51:23 +0100
Message-ID: <CAJTo0LbTnQQmj-KsmncAsnE-kcuZxKTH-mwHMC_=HwPCV6JCgQ@mail.gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: Library not getting installed to intended path
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
X-List-Received-Date: Thu, 04 Jun 2015 09:51:43 -0000
Content-Type: multipart/alternative; boundary=001a1147379688056b0517ae1fc7

--001a1147379688056b0517ae1fc7
Content-Type: text/plain; charset=UTF-8

On 4 June 2015 at 07:25, Khem Raj <raj.khem@gmail.com> wrote:

> you will then hit the .so not being symlink QA errors


dev-so is "symlink .so isn't in a -dev package", there's isn't a check for
".so isn't a symlink" as that would trigger for every plugin.

Ross

--001a1147379688056b0517ae1fc7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On 4 June 2015 at 07:25, Khem Raj <span dir=3D"ltr">&lt;<a href=3D"mailto:r=
aj.khem@gmail.com" target=3D"_blank">raj.khem@gmail.com</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">you will then hit the .so not being sy=
mlink QA errors</blockquote></div><br>dev-so is &quot;symlink .so isn&#39;t=
 in a -dev package&quot;, there&#39;s isn&#39;t a check for &quot;.so isn&#=
39;t a symlink&quot; as that would trigger for every plugin.</div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Ross</div></div>

--001a1147379688056b0517ae1fc7--
