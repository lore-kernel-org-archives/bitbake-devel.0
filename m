Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jon.szymaniak@gmail.com>) id 1Tjarg-0001px-6f
	for bitbake-devel@lists.openembedded.org;
	Fri, 14 Dec 2012 20:24:08 +0100
Received: by mail-ie0-f175.google.com with SMTP id qd14so6281561ieb.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Dec 2012 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=4rkknXj4SKpssREGq3wKQz6W+g1a8R+v3IruJRYVr3E=;
	b=TTF2UZwH2K/7dAGloPDFcn9rjGKOLBaB99GLdGy2dKOB7Uk2+HZZU7xokelc7BSEL5
	0obrvj3/JQvXKTmfegF/wWkQgTcoeewwpUGD3Y98Uu92lfg4e/+3jouRBrwRfinbPBz9
	5weBDlJJtMAQ2CXgB4/u5D2Uqk7TkJ49RU9kvvHgbuaQNMeJ5eML0lfaNpZjbDNHhRD0
	fFgg/SAlWZ6vbVadHFIh2fa8RBAY517f+X1DKjk0ltzjHqLRMu1ybHk4vM90Z3jKxTfb
	+VFLskrex7QOOD7h5lYnJQGYVMoIAyTpKuX6u1TA/pwhrRApCDuA6ZecgLJqW/dCrUu3
	+jTQ==
Received: by 10.50.151.211 with SMTP id us19mr807877igb.13.1355512171037; Fri,
	14 Dec 2012 11:09:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.167.165 with HTTP; Fri, 14 Dec 2012 11:09:09 -0800 (PST)
In-Reply-To: <CANge7vVQnTVasye41HJiB9JOMno4fTX5mn=p499y7kus5O4NQw@mail.gmail.com>
References: <CANge7vVgnJTskixvCtbWThgq8uqrS9fag8DcHL7HLb732ckDNg@mail.gmail.com>
	<1355507217.32519.33.camel@ted>
	<CANge7vVQnTVasye41HJiB9JOMno4fTX5mn=p499y7kus5O4NQw@mail.gmail.com>
From: Jon Szymaniak <jon.szymaniak@gmail.com>
Date: Fri, 14 Dec 2012 14:09:09 -0500
Message-ID: <CANge7vURMxSYh=-O0ZHUWqopVjCkUwFMxhC8-bqHTy6J8mF2Mw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Fri, 14 Dec 2012 19:24:08 -0000
Content-Type: text/plain; charset=ISO-8859-1

>> tl;dr: Doesn't the "update" in lines 142-147 of hg.py cause issues when
>> SRCREV is a tag?
>>
>>
>> Hi all,
>>
>> I didn't have any luck with this post on the Yocto mailing list. Since it seems
>> more like a bitbake issue (I'm very hesitant to cry "bug" at this point),
>> I hope I'm in the right place.
>>
>> I've been running into "Fetcher failures" for my recipes using
>> mercurial recently, which report that I'm asking for an unknown revision,
>> despite it being valid. A trimmed log is at the end of this post.
>>
>> After looking at hg.py, it seems the issue is that the
>> 'hg update -r MY_TAG' that follows the 'hg clone -r MY_TAG ...' is doomed to
>> fail because that tag isn't visible until the next rev, where the action of
>> tagging it is committed.
>>
>> For example, if I clone v1.1.0, I won't see that tag because the tag is added
>> to .hgtags in commit 41:58b..
>>
>>       tip                             41:58b8f368be68
>>       v1.1.0                        40:a925b596c163
>>       v1.0.4                        39:6bf84da2571e
>>
>> Therefore once I've cloned with "-r v1.1.0", I can't do an update
>> specifying tag v1.1.0.
>>
>> Does this sound right, or am I way off here?
>>
>> I'm not sure if using a tag rather than the revision number is unorthodox or
>> abnormal for bb's, so below's my use case, for a my-app_0.1.2.bb
>>
>> require my-app.inc
>> PR = "${INC_PR}.0"
>> SRCREV = "v${PV}"
>>
>> Therefore to bring in a new version, I can simply copy this file to a
>> my-app_1.1.0.bb, and adjust PR back to 0 if needed.
>>
>> We have a policy not to move version tags, so tag-->revision should be 1:1. Is
>> what I'm seeing a non-issue simply because one shouldn't use tags in SRCREV?
>>
>
> FWIW, the hg fetcher is a little unloved. We don't have many developers
> who use it or are familiar with how hg works. If there are some ways we
> can fix things I'd be interested in patches.
>
> I'm afraid I haven't had a chance to look at the details of the above
> yet though.
>
> Cheers,
>
> Richard
>

Hi Richard,

Thanks for pinging back on this. (Sorry I just double-sent this to
you. Forgot to include the list! :P)

I think a fairly simple solution might be to just clone the entire
repo by not adding "-r REV" to options[] for an 'hg clone' invocation.
The 'hg update' that follows on lines 142-147 should set the repo to
the desired revision.

I suppose an argument against this solution may be that this is
overkill since we only need revision <tag> + 1; the fetch could
potentially take longer and result in greater disk space usage, but I
feel like this is a reasonable tradeoff. Then again, I'm not sure if
folks are using the hg fetcher to clone huge repos...

Thoughts? Just wanted to bounce this idea around, as I certainly don't
consider myself an hg expert and am still getting up to speed on OE,
Yocto, & bitbake. If this sounds reasonable, I'll give it a shot and
post a little patch.

- Jon


