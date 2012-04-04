Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SFTnb-0004K1-0h
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 19:15:11 +0200
Received: by qcso7 with SMTP id o7so298065qcs.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Apr 2012 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=RQc1Z4co6+/shgGUuwmex45oAPo0UDHCmkPkx/T9OII=;
	b=N28HVTjN7nfmliF19wMUt4X72WIKoJ0TwBg0wyaiUCmHUG9YijTHD1ZDefFA3d5DhP
	e6J4bX+NeGCoyN4OgaHhWPOqanxpI4j9Ixvpb5A7CzATE8oyW90juCFEm+ngjU6bhtsx
	l7ZDbUlthbcNh4HY4ahaPu0imtl1JXzDOeTtJocS3D6KXT/bs1ugHuJlySKE0L3NoCZ1
	gBn1kVBHvuVwNIF76eleG1CY63hRD2phlAeNEA4esL9yLuyl1iCsCZ1+I65xyV3K2RuQ
	gcZx1aVcfgIOhTLe7ooC2ZssplKCtukxbeOYyONUfwlgNK2HBbByIb1l3mhqhsZUrFAR
	Zm9g==
Received: by 10.224.180.1 with SMTP id bs1mr23866864qab.2.1333559159983; Wed,
	04 Apr 2012 10:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.79.79 with HTTP; Wed, 4 Apr 2012 10:05:39 -0700 (PDT)
In-Reply-To: <CAEsOVNf_1-a62a8ZY=9WsVXg+YPSGZ8Afv7QiJKQq7Ayik9qBw@mail.gmail.com>
References: <1333495429-17048-1-git-send-email-kergoth@gmail.com>
	<CAEsOVNf_1-a62a8ZY=9WsVXg+YPSGZ8Afv7QiJKQq7Ayik9qBw@mail.gmail.com>
From: Chris Larson <kergoth@gmail.com>
Date: Wed, 4 Apr 2012 10:05:39 -0700
Message-ID: <CABcZANkkaR3aTPq9eUjA4rQZ8GBgjQNCs6BPWTfJ5cUxhj9OnQ@mail.gmail.com>
To: Matthew McClintock <msm-fsl@mcclintock.net>
Cc: Christopher Larson <chris_larson@mentor.com>,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] Remove whitelisted vars from non-task deps
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
X-List-Received-Date: Wed, 04 Apr 2012 17:15:11 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Apr 4, 2012 at 10:02 AM, Matthew McClintock
<msm-fsl@mcclintock.net> wrote:
> On Tue, Apr 3, 2012 at 4:23 PM, Christopher Larson <kergoth@gmail.com> wrote:
>> From: Christopher Larson <chris_larson@mentor.com>
>>
>> Though the value of variables in the BB_BASEHASH_WHITELIST is kept out of the
>> checksums, dependency on them is not, at least for variables and non-task
>> functions. In the code, the whitelist is removed from the overall task dep
>> list, but not the individual variable deps. The result of this is that
>> functions like sysroot_stage_all and oe_runmake end up with whitelisted
>> variables like TERM listed in their dependencies, which means that doing
>> a 'unset TERM' before building will result in all checksums for tasks that
>> depend on those changing, and shared state reuse not behaving correctly.
>>
>> This is only really a potential issue for variables from the environment, as
>> it's the existance/removal of the variable that's an issue, not its value, and
>> the other whitelisted variables are set in our metadata. This which means in
>> practical terms the only cases where this is likely to be an issue are in
>> environments where one of the following are unset: TERM, LOGNAME, HOME, USER,
>> PWD, SHELL. This may seem like an unlikely circumstance, but is in fact a real
>> issue for those of us using autobuilders. Jenkins does not set TERM when
>> executing shell, which means shared state archives produced by your jenkins
>> server would not be fully reused by an actual user.
>>
>> Fixed by removing the whitelisted elements from the individual variable deps,
>> not just the accumulated result.
>
> Which recipes/packages were you seeing this on? I've noticed the TERM
> issue on several packages but not on all of them.

One I know of off the top of my head was avahi. The sstate archives
for it which came out of jenkins were not being used. As one example,
the populate-sysroot archive wasn't being used due to the TERM
dependency being added/removed to/from the dependency list for
sysroot_stage_*.
-- 
Christopher Larson


