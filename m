Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com [74.125.82.50])
	by mail.openembedded.org (Postfix) with ESMTP id 474696AC37
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 19:07:34 +0000 (UTC)
Received: by wmec201 with SMTP id c201so38178853wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Dec 2015 11:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=lZ9AjLfz8Me7GGJ2h0bzw3udMX1PJkVTII0vKpIsDVI=;
	b=p1KTih32e1rHD9h4s3hZAI6EfMvPHjYmg4rAY1hpZC6eJiK6iuFnn0MTGvkGIsMf1N
	IU0b7BoYknudCEqAQW5bmBLTruf+nN2GIfda0htsl9Spr5iFG5o1yezWM76d4q3acPS/
	/LLov7aMWY/i1hg7ZlMxav9Qkfmk0mT5auFJASlOLwDAWLOhx18+0TThCRCobQs907Ie
	zhCMMxUsvAcAigH3NvUbyCqHnNzrQb58msbV9c1pXr6ks51dsX3J3LQNfQjYb2JvB5gT
	nsmlmFjlCFT/+CiVBjAViRxNdH/jqblgR54e/hmtZJY22EXENaDtGS6cMj4da2UMtieJ
	5rCg==
MIME-Version: 1.0
X-Received: by 10.28.86.196 with SMTP id k187mr729532wmb.61.1449774455225;
	Thu, 10 Dec 2015 11:07:35 -0800 (PST)
Received: by 10.194.117.68 with HTTP; Thu, 10 Dec 2015 11:07:35 -0800 (PST)
In-Reply-To: <20151210091651.GE2246@jama>
References: <CAJ86T=U_qRVDbJZbCOT5XCwRP=Scs0g1+EYeg+HhjLZ-J7zwhw@mail.gmail.com>
	<CAP71WjwVKYvTqChH++LygHnRkshDWbTUpnRpuptcoRxBpFw9HQ@mail.gmail.com>
	<20151210091651.GE2246@jama>
Date: Thu, 10 Dec 2015 11:07:35 -0800
Message-ID: <CAJ86T=UnA7zeFPh9gfRPGe68HjZuKh=oxttCFSdYgUJT+U3Fpw@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: PREFERRED_VERSION with % wildcard picking unexpected version
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
X-List-Received-Date: Thu, 10 Dec 2015 19:07:44 -0000
Content-Type: text/plain; charset=UTF-8

Hi Nicolas,

On Thu, Dec 10, 2015 at 1:16 AM, Martin Jansa <martin.jansa@gmail.com> wrote:
> On Thu, Dec 10, 2015 at 12:27:36AM +0100, Nicolas Dechesne wrote:
>> On Tue, Dec 1, 2015 at 6:13 AM, Andre McCurdy <armccurdy@gmail.com> wrote:
>> > I have two recipes within a single layer:
>> >
>> >   stblinux_3.14-1.7.bb
>> >   stblinux_3.14-1.8.bb
>> >
>> > If PREFERRED_VERSION_stblinux is set to "3.14%", then I would expect
>> > the version 3.14-1.8 recipe to be selected, however 3.14-1.7 gets
>> > selected instead.
>> >
>> > Reversing the order of files stored in pkg_pn[pn] seems to help. Is it
>> > a reasonable solution?
>>
>> I have a somewhat similar issue..
>>
>> in oe-core we have GCCVERSION set to 5.%, if I add meta-linaro layer
>> which has gcc_5.1.bb (while OE has gcc_5.2.bb), I am seeing this:
>>
>> $ bitbake -e gcc | grep ^PV
>> PV="5.1.0"
>>
>> While I would expect 5.2.0 to be picked up.
>>
>> This patch does not fix this issue, btw.
>>
>> If I remove gcc_5.1.bb from my layers, then I can see:
>>
>> $ bitbake -e gcc | grep ^PV
>> PV="5.2.0"

I think we've been seeing related but not identical issues.

Behaviour of PREFERRED_VERSION with a wildcard seems to be to take the
first possible match when testing the preferred version against a list
of available versions which are sorted first by layer priority (which
explains the behaviour you saw) and second by lexical order (ie
3.14-1.7 comes before 3.14-1.8, which explains the behaviour I have
seen).

My patch effectively reversed the order of the lexical sort, so only
affects the case where the wildcard pattern matches multiple versions
within the same layer priority - so it would not change the behaviour
you saw.

> PREFERRED_VERSION was always meant to identify only 1 provider, the wildcard
> is used only to say that you cannot specify the exact value - e.g. for
> floating versions from SCM.
>
> So if you have a layer with another recipe with version matching "5.%"
> you're supposed to set PREFERRED_VERSION to more specific version.
>
> See longer explanation in:
> http://comments.gmane.org/gmane.comp.sysutils.bitbake.devel/1038

Thanks for digging out the history. I've sent a patch to the oe-core
list to try to document that the wildcard should be avoided in cases
where it might match more than one available version.

> --
> Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

