Return-Path: <raj.khem@gmail.com>
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
	[209.85.210.180])
	by mail.openembedded.org (Postfix) with ESMTP id DF6277ED48
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  3 Aug 2019 23:45:47 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id q10so37779407pff.9
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 03 Aug 2019 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:from:organization:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=J383rnUhZijeNOML/O5XVI5vxXvg/ksOieqeZWl3Skc=;
	b=XgQBR3KoIZngKDXYd/3yylumV9BtXM/j3emRxkCXI/Z6ZZLCwyQtystjySTL9rYtj3
	md+DjzQuj0ABLd1gewv3qPCoMJ0OxmoaW/0LAPdX2z9gJse+SWmFOQ8+guktyWFt4ItU
	JtKnLHTEYmV+EupkpnSmWdQ9OWWgW2wW/J7A6K7ITj+6sbvROLZkENUybySKAQNbL9VV
	PPnJWyemAccfiFRecaeLRHwjrXadIi4gRZTvTIp8qu9Tm9Of//l3fIXI3os/QrGo2yjq
	6/LG0P36/6WtxIJT7bsRaIDGSdzrdPfsnnScuPDYiSMqapol1NvF8oCa1n+4dlAu42Uj
	PeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:organization
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=J383rnUhZijeNOML/O5XVI5vxXvg/ksOieqeZWl3Skc=;
	b=lT6+wDsDHLLhJANJ7bJqqxYnKzTk+ddJTrpdAg0/u0YlE825BrwbQdzYdY0icEqhyb
	tp0j59Kpa2qnWoD83zhKIGoun58i6wlt7UIgSrjed16iUD4p329+jtwTWRBPuHDg7DC+
	d53UHZxBqeFoLA4N4SfBD3B845pMs4qy5Fj8Q6CQ89JEiw1kLBChE4/QVQKfZ/BU0OPm
	31KpXIhEMU9McGhnTwWfXOpsdNaqbzB9he8RTLVH3gZhRJD7RsL9GpOizG01vyRGTWhz
	TF+LpV3MuczTzP558iVWwI/ugz8NyU+h20StDbOHTiU8Yk4zH7sAGE2D3opvmPPZAwxl
	g5Ew==
X-Gm-Message-State: APjAAAXPIjkn6yjPxHsfmO2gDMNOJGmfhyysK332eox+qS8lV5/1j7uh
	/30ueTPuXX/9xIDxx1xn0Etz1DLP0vk=
X-Google-Smtp-Source: APXvYqypNszfWVUQhqYOdL895CYQXze8CQoSszzx7VCqENYddzefSXbeZ7NxD9RY9P1QlHpGPGJVMg==
X-Received: by 2002:a65:6406:: with SMTP id a6mr92464121pgv.393.1564875948182; 
	Sat, 03 Aug 2019 16:45:48 -0700 (PDT)
Received: from ?IPv6:2601:646:8500:6bc6:2188:fac4:3bf8:a4b8?
	([2601:646:8500:6bc6:2188:fac4:3bf8:a4b8])
	by smtp.gmail.com with ESMTPSA id
	i126sm93123517pfb.32.2019.08.03.16.45.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 03 Aug 2019 16:45:47 -0700 (PDT)
To: Ankur Tyagi <ankur.tyagi85@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
References: <20190704044603.9943-1-ankur.tyagi85@gmail.com>
	<c7df70a3-d581-5e21-842b-0e941ec80a05@windriver.com>
	<CADySD0EkWkJ6mbg7jh3hRq3E7bjaqDFa=Aeax7OpertQ0XygSA@mail.gmail.com>
	<d69bc7b9-b946-582d-880c-ef41338affbe@windriver.com>
	<CADySD0HDCdVHnwzXN+POLEoQg73enGZ6XPht5HLZcySGj0XXww@mail.gmail.com>
	<CADySD0G-iSynqSRo9o-y_e0Hvz4L+GzvsBYm=9mHq25yAn0c6Q@mail.gmail.com>
	<9758178e3d22e58c18d4de719933d5957ea23ec2.camel@linuxfoundation.org>
	<CADySD0E7eWVYfEtMk-6+KMnb+WKAMyTEuHLotGQBf8sefFysgg@mail.gmail.com>
	<CADySD0HXOc7RWpVs+nhD3810D3mQc62KiKdsZo0Q5FnEar27GQ@mail.gmail.com>
	<CADySD0EhCzQFTXb40wknh=Fr6VSBVocppVOe_ssuxS5U0vL3vQ@mail.gmail.com>
	<CADySD0F_aEnNsQwjbgfdwet1x-NXNFMQZSYq=UNO+OuoFNLBeQ@mail.gmail.com>
From: Khem Raj <raj.khem@gmail.com>
Organization: HIMVIS LLC
Message-ID: <d7ddc728-1175-937b-b5ef-eeaab717a8ad@gmail.com>
Date: Sat, 3 Aug 2019 16:45:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CADySD0F_aEnNsQwjbgfdwet1x-NXNFMQZSYq=UNO+OuoFNLBeQ@mail.gmail.com>
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
X-List-Received-Date: Sat, 03 Aug 2019 23:45:48 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 8/3/19 2:34 PM, Ankur Tyagi wrote:
> Hi Richard,
> 
> Any input on how it should be handled? I have identified the area like 
> you asked and some ways to fix it as well
> 
> Thanks
> Ankur
> 
> On Sun, 28 Jul 2019, 9:15 p.m. Ankur Tyagi, <ankur.tyagi85@gmail.com 
> <mailto:ankur.tyagi85@gmail.com>> wrote:
> 
>     How about something like this:
> 
>     diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>     index f6b5529b..fa1f9e27 100644
>     --- a/lib/bb/fetch2/__init__.py
>     +++ b/lib/bb/fetch2/__init__.py
>     @@ -380,6 +380,9 @@ def decodeurl(url):
>               user = ''
>               pswd = ''
> 
>     +    if type not in ['git']:
>     +        path = urllib.parse.unquote(path)
>     +
>           p = collections.OrderedDict()
>           if parm:
>               for s in parm.split(';'):
>     @@ -389,7 +392,7 @@ def decodeurl(url):
>                       s1, s2 = s.split('=')
>                       p[s1] = s2
> 
>     -    return type, host, urllib.parse.unquote(path), user, pswd, p
>     +    return type, host, path, user, pswd, p

It would be good to add some self test for this case as well and patch 
needs to be formatted as per 
https://www.openembedded.org/wiki/Commit_Patch_Message_Guidelines

> 
>       def encodeurl(decoded):
>           """Encodes a URL from tokens (scheme, network location, path,
> 
>     regards
>     Ankur
> 
>     On Fri, Jul 26, 2019 at 3:13 PM Ankur Tyagi <ankur.tyagi85@gmail.com
>     <mailto:ankur.tyagi85@gmail.com>> wrote:
>      >
>      > Hi,
>      >
>      > Previous idea is stupid, please discard that.
>      > Just checked quote/unquote were added as part of commit
>      > b1dbc24ebcc4e5100c32568c2c41fd982fb4bcce
>      >
>      > So explaining the situation again --> when fecthing from repo url
>      > https://tfs.local/repos/foo%bar
>      >
>      > During FetchData initialization, decodeurl(d.expand(url)) returns
>     path
>      > with %20 stripped
>      >
>      > [log][__init__][decodeurl] Path returned /repos/foo bar
>      >
>      > And when git method urldata_init() is called, it sets gitsrcname with
>      > space instead of %20
>      >
>      > [log][git][urldata_init] gitsrcname is tfs.local.repos.foo bar
>      >
>      > And when git method _get_repo_url is called, it always returns Path
>      > with space instead of %20
>      >
>      > [log][git][_get_repo_url] Path returned /repos/foo bar
>      >
>      > So I am bit confused now on how to handle it properly as unquote is
>      > removing %20 and it cannot be added back in later stage.
>      >
>      > Regards
>      > Ankur
>      >
>      >
>      > On Thu, Jul 25, 2019 at 7:23 PM Ankur Tyagi
>     <ankur.tyagi85@gmail.com <mailto:ankur.tyagi85@gmail.com>> wrote:
>      > >
>      > > Hi,
>      > >
>      > > Sorry for the late reply but I have figured out where %20 is
>     being stripped out.
>      > >
>      > > File lib/bb/fetch2/__init__.py, method decodeurl(url) is returning
>      > > path as urllib.parse.unquote(path) which strips out %20
>      > > So if I return path as it is, then %20 is preserved and works
>     as expected.
>      > >
>      > > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>      > > index f6b5529b..97fd59e1 100644
>      > > --- a/lib/bb/fetch2/__init__.py
>      > > +++ b/lib/bb/fetch2/__init__.py
>      > > @@ -389,7 +389,7 @@ def decodeurl(url):
>      > >                  s1, s2 = s.split('=')
>      > >                  p[s1] = s2
>      > >
>      > > -    return type, host, urllib.parse.unquote(path), user, pswd, p
>      > > +    return type, host, path, user, pswd, p
>      > >
>      > >
>      > > Is above change acceptable?
>      > >
>      > > Regards
>      > > Ankur
>      > >
>      > > On Wed, Jul 10, 2019 at 4:33 AM Richard Purdie
>      > > <richard.purdie@linuxfoundation.org
>     <mailto:richard.purdie@linuxfoundation.org>> wrote:
>      > > >
>      > > > On Wed, 2019-07-10 at 21:26 +1200, Ankur Tyagi wrote:
>      > > > > Hi,
>      > > > >
>      > > > > Is there something else that needs to be done in this patch? Or
>      > > > > perhaps there is a better to handle this?
>      > > > > I am willing to learn and try it out if original patch is
>     not good.
>      > > >
>      > > > I think Mark is right, we need to figure out where the %20
>     characters
>      > > > are being stripped out and preserve them rather than
>     injecting them
>      > > > back in again.
>      > > >
>      > > > The question is therefore where they're being stripped out in
>     the code?
>      > > >
>      > > > Cheers,
>      > > >
>      > > > Richard
>      > > >
> 
> 


