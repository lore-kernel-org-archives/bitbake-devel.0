Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <schnitzeltony@googlemail.com>) id 1Td9mo-0002lE-H0
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Nov 2012 02:16:35 +0100
Received: by mail-ie0-f175.google.com with SMTP id qd14so11461835ieb.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Nov 2012 17:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=sUtuYOupUUEBwZUnsWEgLruJQLX7TUz0cV1nHimbHqY=;
	b=TxvdG7gdD12u63rVL9LsOtcZrFpsd2Q8c9qA31zvuMrKxTqN9lxah5pklp4g5npvtM
	abYlMln7M+Y92xMYPenUl1w8LDwWHuKmXEJdVAjMIcOCtNR1wLs6JuH9nbsWYo1g+u+0
	2NwNNsN7UiKrQRI4sYrvKrR6JnolRY2B9COaVlDJ/qrLiS4xZ69FVFhsYmRDCRrk7NcX
	RBxasJXW6M4YEwRfZa5oUd0mVNd0bNVd6I75Wa9/Aq/v9q0jEzK8mVeHuAl+9UwuRcm0
	2E/c860+DeDqh2Iutz6pCjTvbr02iuIESy0rvYOjUoua9Ichqyd5ZWWcfUMfMNvaxaEL
	HYVw==
MIME-Version: 1.0
Received: by 10.50.104.232 with SMTP id gh8mr16821745igb.45.1353978137706;
	Mon, 26 Nov 2012 17:02:17 -0800 (PST)
Received: by 10.64.20.113 with HTTP; Mon, 26 Nov 2012 17:02:17 -0800 (PST)
In-Reply-To: <1353964883.21863.66.camel@ted>
References: <ly624ss705.fsf@ensc-virt.intern.sigma-chemnitz.de>
	<1353964883.21863.66.camel@ted>
Date: Tue, 27 Nov 2012 02:02:17 +0100
Message-ID: <CALbNGRS9yaa3PUQPpNqTMV8B9_H=twqtHoBdULr4EtKhLArAng@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
	bitbake-devel@lists.openembedded.org
Subject: Re: Broken SRC_URI handling
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
X-List-Received-Date: Tue, 27 Nov 2012 01:16:36 -0000
Content-Type: text/plain; charset=UTF-8

On Mon, Nov 26, 2012 at 10:21 PM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Mon, 2012-11-26 at 16:45 +0100, Enrico Scholz wrote:
>> Hi,
>>
>> commit 07b5f84133ac79aac4e939ea5f24390ad7f940a5 introduced a regression
>> with
>>
>> | +            if not newpath or not os.path.exists(newpath) and path.find("*") != -1:
>>
>>
>> When an SRC_URI element is not found, some directory in the search path
>> is copied insted.
>>
>> There should be probably added some parentheses in the expression above.
>> At the moment, the 'A or B and C' above is interpreted as 'A or (B and
>> C)' due to operator precedences.
>
> I just pushed a fix for this before I read this email! We reached the
> same conclusion so it should be fixed in master now :)
>
> Cheers,
>
> Richard
>
Not sure if it is related but since last update I get

WARNING: Failed to fetch URL file://systemctl, attempting MIRRORS if available
ERROR: Fetcher failure: Unable to find file file://systemctl anywhere.
The paths that were searched were:
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/task-fetch
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/linux
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/x86-64
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/build-linux
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/pn-systemd-systemctl-native
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/overo
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/omap3
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/armv7a
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/armv7a-vfp-neon
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/angstrom
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/class-native
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/forcevariable
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-1.0/
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/task-fetch
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/linux
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/x86-64
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/build-linux
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/pn-systemd-systemctl-native
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/overo
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/omap3
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/armv7a
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/armv7a-vfp-neon
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/angstrom
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/class-native
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/forcevariable
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/task-fetch
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/linux
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/x86-64
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/build-linux
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/pn-systemd-systemctl-native
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/overo
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/omap3
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/armv7a
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/armv7a-vfp-neon
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/angstrom
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/class-native
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/forcevariable
    /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/files/
    /home/Superandy/data/Downloads/packets/dl
ERROR: Function failed: Fetcher failure for URL: 'file://systemctl'.
Unable to fetch URL from any source.
ERROR: Logfile of failure stored in:
/home/Superandy/tmp/oe-core-eglibc/work/x86_64-linux/systemd-systemctl-native/1.0-r6/temp/log.do_fetch.13053
ERROR: Task 4 (/home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-native.bb,
do_fetch) failed with exit code '1'
NOTE: Tasks Summary: Attempted 8 tasks of which 7 didn't need to be
rerun and 1 failed.
No currently running tasks (8 of 19)

Summary: 1 task failed:
  /home/Superandy/data/oe-core/sources/meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-native.bb,
do_fetch

The file is in

.../meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl-native

but I see something like

.../meta-openembedded/meta-systemd/recipes-core/systemd/systemd-systemctl/pn-systemd-systemctl-native

Thoughts?

Andreas


