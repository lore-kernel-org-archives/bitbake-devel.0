Return-Path: <nicolas.dechesne@linaro.org>
Received: from mail-oa0-f46.google.com (mail-oa0-f46.google.com
	[209.85.219.46])
	by mail.openembedded.org (Postfix) with ESMTP id A38CF6DF3F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Dec 2013 23:01:39 +0000 (UTC)
Received: by mail-oa0-f46.google.com with SMTP id o6so8040988oag.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Dec 2013 15:01:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type;
	bh=OHd/OtWoBNz6AV9SkSPKYqoaUJ2JT/vAwYq3B4zVGbw=;
	b=TiTS2+gnwsAXQbwigUgkRx2n2pAyju83cQK2okvs/ZulwXLLzjHHZaPnuwMPR6j3iF
	KHbSrlPYxcnir8ysvEn+HN1szU43VuE0r1bXHPTw81wsbmXyk1111eKw77K9zDQ46+Bv
	cPYFU3nYaTsfxJx0NbBtBM05SCTL6qRAOIN1hYD5J7RwxW0daVcOJ6QLfW3hW3FvhF9T
	vsOxHdVc8Ul0zVad8l60m0PM7sudLQK6NiFJe/vdOHWp/1/FBqfAi7oJKA+225cYMjXT
	mRlvlc4z00R3fhyXhhCsIOgOq5Y54fj3mhhaio8uNXyu8vpcaKXYKVEX6z1ViSIBZCr5
	TPlQ==
X-Gm-Message-State: ALoCoQkIXzfp1CX8fWxO93kO5Kvk9IRJiEnD5A14BkGAJOEoiZsz8tj1badcrcuocC4dj0t4a4Db
X-Received: by 10.60.63.141 with SMTP id g13mr3169595oes.60.1386802898699;
	Wed, 11 Dec 2013 15:01:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.76.122.81 with HTTP; Wed, 11 Dec 2013 15:01:18 -0800 (PST)
In-Reply-To: <20131211225150.GB3717@jama>
References: <20131211225150.GB3717@jama>
From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Thu, 12 Dec 2013 00:01:18 +0100
Message-ID: <CAP71WjxSLcVBrYkc1WssOuYKuEamOcAhKshVNggsBBCRR_JsXQ@mail.gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] git fetcher sanity check for matching branch and SRCREV
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
X-List-Received-Date: Wed, 11 Dec 2013 23:01:39 -0000
Content-Type: multipart/alternative; boundary=001a11c1db34269a7904ed4a36d8

--001a11c1db34269a7904ed4a36d8
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Dec 11, 2013 at 11:51 PM, Martin Jansa <martin.jansa@gmail.com>wrote:

> Unfortunately we cannot "disable" this check by explicitly setting empty
> branch or setting tag=1.0.12
>
> I can ask yajl owner to push that one missing patch to 1.x branch, but
> there were no changes in last 11 months so I don't know how responsive
> he will be and there could be similar case in different recipes where
> the upstream could be completely gone.
>
> As side note, should bitbake do the same check when tag=foo is
> specified?
>

well, my 2 cents.. I think that keeping tags without a branch is a 'valid'
feature in git, whether we like it or not, and we won't be able to make
sure no upstream do that... so we probably need to support use of a tag in
SRC_URI as well, not just branches.

cheers

nicolas

--001a11c1db34269a7904ed4a36d8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Dec 11, 2013 at 11:51 PM, Martin Jansa <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:martin.jansa@gmail.com" target=3D"_blank">martin.jansa@gmail.co=
m</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":2xk" style=3D"overflow:hidden">U=
nfortunately we cannot &quot;disable&quot; this check by explicitly setting=
 empty<br>


branch or setting tag=3D1.0.12<br>
<br>
I can ask yajl owner to push that one missing patch to 1.x branch, but<br>
there were no changes in last 11 months so I don&#39;t know how responsive<=
br>
he will be and there could be similar case in different recipes where<br>
the upstream could be completely gone.<br>
<br>
As side note, should bitbake do the same check when tag=3Dfoo is<br>
specified?<br></div></blockquote></div><br>well, my 2 cents.. I think that =
keeping tags without a branch is a &#39;valid&#39; feature in git, whether =
we like it or not, and we won&#39;t be able to make sure no upstream do tha=
t... so we probably need to support use of a tag in SRC_URI as well, not ju=
st branches.</div>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">cheers</div=
><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">nicolas</d=
iv><div class=3D"gmail_extra"><br></div></div>

--001a11c1db34269a7904ed4a36d8--
