Return-Path: <masahiroy@kernel.org>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
	[210.131.2.81])
	by mail.openembedded.org (Postfix) with ESMTP id C4BA97FA3F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Dec 2019 07:33:50 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
	[209.85.222.53]) (authenticated)
	by conssluserg-02.nifty.com with ESMTP id xBP7Xhis029785
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Dec 2019 16:33:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com xBP7Xhis029785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
	s=dec2015msa; t=1577259224;
	bh=ZMoPwqg4Yt0WyMSu6eWNIQOQgHA+/EctWr7iWCFm1jo=;
	h=From:Date:Subject:To:From;
	b=nNXJmh+VCSjyGfpxzn43OYMH/TFQeDZX2kIXmZCAPGdn6s0un6me5EBqJI49vtCRO
	aUdo4FYi60RGmglq8FQ3ycR92ZnpD+wUNr6hMzOw2guQTfndOXJb8eSaoXgNyxlzIh
	8YBB2bG4nJQZ68t4n5xTbbkdt86sYRX7grNU/kpRZbjxohlQ3xVkKh8RLuXwzT7UfA
	yf24Ks/znMI2mg/+Snf7mcPbzZxQZLzZJqfyHI494F9hs9RAgqNI7xwfS7Dxf4XHuX
	exo8BBfvlrTRNd/3r2EbYyj8Ow5tlUa90PKDstMSiPYxvomkDotKEEGD/At0Ti8D37
	gzD8v1622djwA==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id h32so864095uah.4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2019 23:33:43 -0800 (PST)
X-Gm-Message-State: APjAAAXtqMzZ6RzpS2rJsfaiSYqcvqg3s93D90yr14FZK2h7uZWAQ9/7
	4xvYFlPRrhDJauPI98QBA0RftFBiI5/eVcvzXZk=
X-Google-Smtp-Source: APXvYqyXQaglWCO3ZzQQSKArU4dJL1oKw+1Jjgu8ilL3AKIEybaSrjJvnLXzmtqdzZCeuIG5kAk5ZMuSuHENOSILhyY=
X-Received: by 2002:ab0:14ea:: with SMTP id f39mr13307117uae.40.1577259222825; 
	Tue, 24 Dec 2019 23:33:42 -0800 (PST)
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 25 Dec 2019 16:33:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+4TEnV+hW9ZQpn5dK+brp9o6UfD3OLk++eHn4T_ezxQ@mail.gmail.com>
Message-ID: <CAK7LNAQ+4TEnV+hW9ZQpn5dK+brp9o6UfD3OLk++eHn4T_ezxQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: DEPENDS vs RDEPENDS from bitbake PoV
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
X-List-Received-Date: Wed, 25 Dec 2019 07:33:51 -0000
Content-Type: text/plain; charset="UTF-8"

Hi,

I think "the difference between DEPENDS and RDEPENDS"
is FAQ, but there is still something unclear to me.

I read the bitbake manual,
asked Google about this question,
and found lots of Q&A there, but
I could not find any answer that satisfied me.

Of course, I am not looking for the boilerplate answer
like "DEPENDS is build-time dependency,
whereas RDEPENDS is run-time dependency."


To clarify my question,
I'd like to know how DEPENDS and RDEPENDS
behave differently in the following sample code
if there is any difference.


Sample code
-----------

[base.bbclass]
addtask build
do_build[nostamp] = "1"


[bar.bb]
PN = 'bar'
python do_build() {
    import time
    bb.plain("bar.do_build START")
    time.sleep(5)
    bb.plain("bar.do_build END")
}


[foo.bb]
PN = 'foo'
python do_build() {
    bb.plain("foo.do_build");
}
DEPENDS = "bar"
do_build[deptask] = "do_build"



Result
------

Running "bitbake foo" displays
the following in the terminal.

bar.do_build START
bar.do_build END
foo.do_build


So, foo.do_build starts after bar.do_build has completed.

If I replace the last twos lines in foo.bb:

DEPENDS = "bar"
do_build[deptask] = "do_build"

... with:

RDEPENDS = "bar"
do_build[rdeptask] = "do_build"

the result is the same.
foo.do_build still starts after bar.do_build has completed.


So, DEPENDS and RDEPENDS are fundamentally the same
from the bitbake point of view.
Is my understanding correct?


I know there is slight difference between them.
For the RDEPENDS variant, the form RDEPENDS_<pkg> is also supported.
(<pkg> is the element in ${PACKAGES}, or ${PN} if ${PACKAGES} is empty).

Other than that, the functionality looks the same between
DEPENDS and RDEPENDS.



-- 
Best Regards
Masahiro Yamada

