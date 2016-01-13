Return-Path: <armccurdy@gmail.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id F2F2960124
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jan 2016 23:59:56 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id l65so314286331wmf.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jan 2016 15:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=FMIlZabvhe1Xy/32qUI63x7+3MEYkTEf+v3JkcGVi6w=;
	b=RP9rx4yweIPFcEXiCaVTH5G1SDKdL0TwEhZcSw49+QgWoJ6TqNWhnY31U5nQhKa7//
	oNg86E1qef1BZ7RCwbG7Xh4PsA/S8U3zQDl9b1DKaeu7lNCyFq1exxrevlrpM1rGDxJ8
	cGUEzECK5UIK+S4HAixRhL97cwh+HUlq6RmOSEQfJ2PYv1xoE1iffQ5JXr2zUXWux9at
	shuSjClTbgKYUhWvIlAhZT6oBuPdVGCf5qFNBa8U8/taVl/8mrskRVOWRED2HJcPn01x
	ugAzmEMTfbtl7xu2czZMjrWezGmREg1Sw53JbfhmTqEGoFeSoczAL14dzsmkOv3503Xb
	BtTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=FMIlZabvhe1Xy/32qUI63x7+3MEYkTEf+v3JkcGVi6w=;
	b=j8/INAC2qIseImdvjKqxoWtJ0SLQNAFO3uYLDBmYjKfimqNK/aOvdS5CBTGLxv03xX
	/PzXNDG1aiuWJfRkvbX0uvx/euk/wK5mEtiFtpkTYKYQulTCryhKAAouLFXhUwskFbrm
	Qx/dy6gzqLbYmhJVVaVt34w/qS7f3MG3y5ElqHBsgOG3Kp1IvADO9ES/eif1Q2at5l/z
	YdY5pH8N+Uf3i6IOZy6uYu6KF4zHDPjTwu23fWFXNkwgVvM6Arbm4jHmLSEH82jHjypn
	RJdMzt3/O+4CvTu4kE0pgf2z2IcZtbHUfSQjjkgwP+3Vd78TRaZLKwxU0c3TbH0s9cgM
	03mA==
X-Gm-Message-State: ALoCoQnxmOC0e39g29eqKixME04AiimsJK/B29hNSkafciwYK0UIABrpd1UpRoZhd9mZK81iigh794gpHq147Z8Px8KMU4Ymng==
MIME-Version: 1.0
X-Received: by 10.28.178.206 with SMTP id b197mr1452755wmf.72.1452729597094;
	Wed, 13 Jan 2016 15:59:57 -0800 (PST)
Received: by 10.194.209.131 with HTTP; Wed, 13 Jan 2016 15:59:57 -0800 (PST)
In-Reply-To: <CAJ86T=XoCWwjRwMC7rhGHkpNnCdm=moWQe4+GiSUrZx182T_hg@mail.gmail.com>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
	<1452723582.28375.118.camel@linuxfoundation.org>
	<CAJ86T=XoCWwjRwMC7rhGHkpNnCdm=moWQe4+GiSUrZx182T_hg@mail.gmail.com>
Date: Wed, 13 Jan 2016 15:59:57 -0800
Message-ID: <CAJ86T=Vs4D=-kzOTfmBeYaX6rhmnNutDfaGiP_uJ+yzvkw5R4A@mail.gmail.com>
From: Andre McCurdy <armccurdy@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Wed, 13 Jan 2016 23:59:57 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Jan 13, 2016 at 3:20 PM, Andre McCurdy <armccurdy@gmail.com> wrote:
> On Wed, Jan 13, 2016 at 2:19 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>> On Wed, 2016-01-13 at 13:37 -0800, Andre McCurdy wrote:
>>> On Thu, Jan 7, 2016 at 5:18 AM, Richard Purdie
>>> <richard.purdie@linuxfoundation.org> wrote:
>>> > Some servers, e.g. bitbucket.org can't cope with ssh:// as part of
>>> > the git url syntax. git itself is happy enough with this but you
>>> > get server side errors when using it.
>>> >
>>> > This changes the git fetcher to use the more common ssh url format
>>> > which also means we need a : before the path.
>>>
>>> This seems to break SRC_URIs using ssh to access self hosted git
>>> servers setup following the process described here:
>>>
>>>   https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Ser
>>> ver
>>>
>>> An example of such a SRC_URI, which now fails to work:
>>>
>>>   SRC_URI = "git
>>> ://git@mylocalserver.com:/opt/git/myrepo.git;protocol=ssh"
>>
>> Does:
>>
>> SRC_URI = "git://git@mylocalserver.com/opt/git/myrepo.git;protocol=ssh"
>>
>> work though?
>
> Removing the ':' breaks things from the command line, but it does work
> OK in a SRC_URI (previously because of the ssh:// prefix and now
> because the fetcher is effectively adding the ':' back again).
>
> Updating my SRC_URIs looks like the best solution.
>
>> I'm not sure we ever suggested people should use ":/" in SRC_URI since
>> that isn't a url format the system was ever designed to cope with. It
>> might have happened to work but that is different...
>
> ":/" comes from the examples in the git-scm.com documentation:
>
>   https://git-scm.com/book/en/v2/Git-on-the-Server-Setting-Up-the-Server
>
> It would be nice if those examples (continued to) work in SRC_URIs and
> it's also nice if git URLs from SRC_URIs can be tested with git on the
> command line. Maybe those goals aren't worth the extra complexity
> though...

One final comment is that the original problem in #8864 seems to be
due to git's handling of URLs which contain both ssh:// and ':' (and
not an issue with BitBucket).

Setting GIT_SSH to a wrapper script which calls 'ssh -v' shows:

  $ git ls-remote ssh://git@bitbucket.org:armcc/openembedded-core.git
  ...
  debug1: Sending command: git-upload-pack '/openembedded-core.git'

ie the BitBucket username (armcc in this case) has already been
dropped before the git-upload-pack command is set to the server.

Trying to use the ssh:// prefix together with a URL containing a ':'
fails in exactly the same way with GitHub as well.

(Tested with git 1.9.1).


>> Cheers,
>>
>> Richard

