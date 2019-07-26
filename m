Return-Path: <ankur.tyagi85@gmail.com>
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
	[209.85.208.196])
	by mail.openembedded.org (Postfix) with ESMTP id D01FB7BD72
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Jul 2019 02:24:00 +0000 (UTC)
Received: by mail-lj1-f196.google.com with SMTP id h10so49933626ljg.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Jul 2019 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=cpefFg4L+D8gH+Ct7oDRtyXR1t6bKM1S2Mv1NrPkucI=;
	b=Ed4EyLkoOZAGPkuctWL/5JftTQLDsrnBMUEGdCyA1AW4IlZkk8eFZ5XsM6ROt0Uyim
	6KvB8iK1NqqvS2rzyDbUGHLE/KB0z0b/4/d5UIOQTSLTxl6Tj4JxO3i9KtrW1bUvtQw5
	rAu0b6mXQn7zFa/bJCIrZex4TLb0xZO0pS6cAKZsWOtaWB5ZjWPENAIH/Cpynz1f/uo4
	WvAFT4b+Gk6HKzEHc1NLhJTXCtJVooa4l2aFA99hBQTRGMiRRGoI265RJA2E6ZjIdLEF
	VM675VgygmG0K8ftyQqQNxpDEt2qHMAsvOEY1yJme6F+qNENR2zEXykmpji2e0Oe8SYj
	wqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=cpefFg4L+D8gH+Ct7oDRtyXR1t6bKM1S2Mv1NrPkucI=;
	b=strS8yIklLd68ZPCTR9XGGqsNO1eQgR+12M6o8vKdcdoQZ+99+z4mn+YlQocxsX4YA
	lonru5JqBqONV1pz+4KaXHW+Er0fHDFCNjATUpLb6nlWnrBhbuz02MffTLMCHOjR5M9K
	NJ6U8uVEXOqScVvWLzgXCGQu7ZiWzHAUrxqph6ngDAgSoayn+49iVU+Isyq5v4b+5x2J
	VA2IIxQzgh5VHqT0VHeQCwW6CRql9UVom1Uq8N4Q9ivKkzwz12MehEezlA4jtBTUxjb9
	muE0lXJDv4Ldd8HQgjUYHaasmjOduaCSmT0WlVZ00kiL8ElLYIcNbmdXddJtxPZhvYab
	6n0Q==
X-Gm-Message-State: APjAAAU1qI28pbgQ+HhZRvT0MmMNBA/kF/A2QAuSNMfMjyiNCk+nyWDU
	4amNF9pkh+6b0b5xURXsbOn4zU91lFFCPYXwBQg=
X-Google-Smtp-Source: APXvYqwu4DpCkrXjK017H2zU5SpLvLDU8ixAOeXLTo39oHrpYGO+fpgFPCsrbRfnDFN0HE2OZw9t1YJ1KY9ls+wRYDE=
X-Received: by 2002:a2e:a171:: with SMTP id u17mr2638517ljl.209.1564107841130; 
	Thu, 25 Jul 2019 19:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
	<CADySD0EkWkJ6mbg7jh3hRq3E7bjaqDFa=Aeax7OpertQ0XygSA@mail.gmail.com>
	<d69bc7b9-b946-582d-880c-ef41338affbe@windriver.com>
	<CADySD0HDCdVHnwzXN+POLEoQg73enGZ6XPht5HLZcySGj0XXww@mail.gmail.com>
	<CADySD0G-iSynqSRo9o-y_e0Hvz4L+GzvsBYm=9mHq25yAn0c6Q@mail.gmail.com>
	<9758178e3d22e58c18d4de719933d5957ea23ec2.camel@linuxfoundation.org>
In-Reply-To: <9758178e3d22e58c18d4de719933d5957ea23ec2.camel@linuxfoundation.org>
From: Ankur Tyagi <ankur.tyagi85@gmail.com>
Date: Thu, 25 Jul 2019 19:23:48 -0700
Message-ID: <CADySD0E7eWVYfEtMk-6+KMnb+WKAMyTEuHLotGQBf8sefFysgg@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel, 1.42, 1.40, v2] git.py: Handle space in git repo name for http/https protocol
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
X-List-Received-Date: Fri, 26 Jul 2019 02:24:01 -0000
Content-Type: text/plain; charset="UTF-8"

Hi,

Sorry for the late reply but I have figured out where %20 is being stripped out.

File lib/bb/fetch2/__init__.py, method decodeurl(url) is returning
path as urllib.parse.unquote(path) which strips out %20
So if I return path as it is, then %20 is preserved and works as expected.

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index f6b5529b..97fd59e1 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -389,7 +389,7 @@ def decodeurl(url):
                 s1, s2 = s.split('=')
                 p[s1] = s2

-    return type, host, urllib.parse.unquote(path), user, pswd, p
+    return type, host, path, user, pswd, p


Is above change acceptable?

Regards
Ankur

On Wed, Jul 10, 2019 at 4:33 AM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> On Wed, 2019-07-10 at 21:26 +1200, Ankur Tyagi wrote:
> > Hi,
> >
> > Is there something else that needs to be done in this patch? Or
> > perhaps there is a better to handle this?
> > I am willing to learn and try it out if original patch is not good.
>
> I think Mark is right, we need to figure out where the %20 characters
> are being stripped out and preserve them rather than injecting them
> back in again.
>
> The question is therefore where they're being stripped out in the code?
>
> Cheers,
>
> Richard
>

