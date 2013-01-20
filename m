Received: from mail-bk0-f50.google.com ([209.85.214.50])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <yanglei.fage@gmail.com>)
	id 1TwoK2-00075F-BS; Sun, 20 Jan 2013 07:24:07 +0100
Received: by mail-bk0-f50.google.com with SMTP id jf3so2555664bkc.9
	for <multiple recipients>; Sat, 19 Jan 2013 22:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type;
	bh=L0AnjcsPQ6/221ilklED3b8P2x+eg6eJxZ0iC+BdBkY=;
	b=fZc5MHjGrFYz4xmkDYGIRWXs/vRz4ld6/lE3Nq128ND95dCmR6Qtz9FunyM4B/SRhf
	+ydKFb2ohm347Fo9S/oaD9K2g1/9h+qdRjaykUqfjWucsuAsIuXlfGEoMje/Ik3TRGhk
	7ga42gf8lSahQsg2+H2ADkyf3FH/vYkTmbmjx9bJYzXPWKv+fjhpUxlGEPNNgCyXNFmE
	7dxAODnhFIseWmK3d74mkVNYIkGZDS9FWL4yq1GOUwmzj8Z+6awaLyiWA5Mbs+E71wJv
	F6TyQ9FmNc7+oyPyrqjIj5xNM17+8ZC0+/UHSplK6GOTf0QPUZl4bRmmws67oSU/3YrZ
	y1eg==
MIME-Version: 1.0
X-Received: by 10.204.156.139 with SMTP id x11mr3617200bkw.128.1358662115418; 
	Sat, 19 Jan 2013 22:08:35 -0800 (PST)
Received: by 10.204.11.86 with HTTP; Sat, 19 Jan 2013 22:08:35 -0800 (PST)
In-Reply-To: <CABcZANkpo5qMnPkL903SQjfkPhwUF-7rK+i5LaqxTFUdqE3H2Q@mail.gmail.com>
References: <CAHsH0E96h=aT6t-u-ACY7MGFHJv4_TTqSMfCmMpSKiq3NBjciw@mail.gmail.com>
	<CABcZANkpo5qMnPkL903SQjfkPhwUF-7rK+i5LaqxTFUdqE3H2Q@mail.gmail.com>
Date: Sun, 20 Jan 2013 14:08:35 +0800
Message-ID: <CAHsH0E_9kaYC0_9rv+zHR8FwxXyU=7vTj2eL85_jJ=uRtb0aSw@mail.gmail.com>
From: lei yang <yanglei.fage@gmail.com>
To: Chris Larson <clarson@kergoth.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: git address in SRC_URI, doesn't works for me
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 20 Jan 2013 06:24:08 -0000
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Jan 20, 2013 at 10:15 AM, Chris Larson <clarson@kergoth.com> wrote:
>
> On Sat, Jan 19, 2013 at 2:13 AM, lei yang <yanglei.fage@gmail.com> wrote:
>>
>> SRC_URI = "git://git.opensvc.com/multipath-tools/.git;protocol=http"
>> it doe noting,and trying to find COPING,but it doesn't clone it
>
>
> This is the correct syntax. The URL scheme (git://) determines what bitbake
> fetcher, and therefore what tool, is used to fetch. If you use http://,
> it'll try to download it with wget, not git.
> -


Correct, now it works for me, what protocol determines, , I thought
SRC_URS="address;protocol=*"
The address should be a real address, now I know it's not , a strange usage

Thanks

Lei


> Christopher Larson


