Received: from mail-ie0-f170.google.com ([209.85.223.170])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jon.szymaniak@gmail.com>) id 1TmTEf-0006eN-GP
	for bitbake-devel@lists.openembedded.org;
	Sat, 22 Dec 2012 18:51:47 +0100
Received: by mail-ie0-f170.google.com with SMTP id k10so7839606iea.29
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Dec 2012 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type; bh=Jcy40bPAmImfi+91ahdFFSjOYRxY2FcQJfpDrtXiqAg=;
	b=JZLa+RmELq0YEA6hQ5a7bIMTrEbr+AjbAVJ3AYemM/cErwoD8Y/U9cJegKCHbHvibO
	56Ww/QRdM53A4XljkDGClaH7WTr/tNjdWkUa6Ra/YD0LFyKunJuCefgKJiYcg8Qvh+mP
	43L3kIcXADwoOmcMzjflzmZTWu1MX3RQjNXyGCiC/DOnCZL6nVMxlmTrjBCJtkQdz+kW
	XCeZgAuh5uy5gg8m0jotByQyfjGF13v0FLr2qSoKWdySK/v1LVTgMrzgC5JsXPXbH9n+
	vWbeppYjNIlR3HzMRtck/E30F6Zku9FyiqVNPyUEvXDGxywI66dlJ/BUjy3p9i/vOWVk
	1xuw==
Received: by 10.50.202.73 with SMTP id kg9mr16760405igc.51.1356197817520; Sat,
	22 Dec 2012 09:36:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.136.229 with HTTP; Sat, 22 Dec 2012 09:36:37 -0800 (PST)
In-Reply-To: <CABcZANmUyaCd0kx0FSq5Ye=OXKiKdziGfAyiy3dH9BxrJtEh6g@mail.gmail.com>
References: <CANge7vVgnJTskixvCtbWThgq8uqrS9fag8DcHL7HLb732ckDNg@mail.gmail.com>
	<1355507217.32519.33.camel@ted>
	<CANge7vVQnTVasye41HJiB9JOMno4fTX5mn=p499y7kus5O4NQw@mail.gmail.com>
	<CANge7vURMxSYh=-O0ZHUWqopVjCkUwFMxhC8-bqHTy6J8mF2Mw@mail.gmail.com>
	<CABcZANmUyaCd0kx0FSq5Ye=OXKiKdziGfAyiy3dH9BxrJtEh6g@mail.gmail.com>
From: Jon Szymaniak <jon.szymaniak@gmail.com>
Date: Sat, 22 Dec 2012 12:36:37 -0500
Message-ID: <CANge7vVSFKAxDYyXh40bFP-uEpu+Otwbhdx69QrX0YgTaGhNjg@mail.gmail.com>
To: Chris Larson <clarson@kergoth.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: hg fetcher failures for SRCREV set to a tag
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
X-List-Received-Date: Sat, 22 Dec 2012 17:51:48 -0000
Content-Type: text/plain; charset=ISO-8859-1

>> Hi Richard,
>>
>> Thanks for pinging back on this. (Sorry I just double-sent this to
>> you. Forgot to include the list! :P)
>>
>> I think a fairly simple solution might be to just clone the entire
>> repo by not adding "-r REV" to options[] for an 'hg clone' invocation.
>> The 'hg update' that follows on lines 142-147 should set the repo to
>> the desired revision.
>
>
> This does sound like the best bet, to me.
> --
> Christopher Larson

Hi all,

Just wanted to touch base on this issue. I didn't hear anything back
on the little patch I posted...not sure if that's a silent rejection,
if I didn't include the right info in the subject line, or if folks
haven't had a chance to test it. If there's something I screwed up,
please do let me know for future reference. :)

http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-December/003962.html


Thanks,
Jon


