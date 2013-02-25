Received: from mail-we0-f169.google.com ([74.125.82.169])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <javier@dowhile0.org>) id 1U9utb-0003ev-TM
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 11:02:57 +0100
Received: by mail-we0-f169.google.com with SMTP id t11so2326755wey.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Feb 2013 01:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-received:x-originating-ip:in-reply-to:references
	:date:message-id:subject:from:to:cc:content-type
	:content-transfer-encoding:x-gm-message-state;
	bh=F8E+j3PPb6wsyK77OZZpGcgBiIiURjNazFNYs9HxG68=;
	b=oZwXjjqLE9F1ok9yxB5rHSB+WJ24emGRronUZ23jHAt+EleaBj/UHQJ4wA0ehbeSUr
	srvTfSHFW+HXsBaiHD8hDzEtUYStA9UACKI6QfQz/7j3GcmalnO9+im7JQNcaDgx8+fl
	HymjC7zpDgLYHdFcSYqE9xxLRnjXP6bBWCHKk5L4iHI0Fep8Uv7roaZfj92aWvnX7V4i
	Hn+hIS6QVrybVV24XPocA3cgcCIK9sakwdkaxAgcUjRRIrrByeHYMhuJlc22FpPVIJpf
	31CEebCzFbx1mAcLKkd/Vl0+HlM5WralEJFCC93D85qz95eEZq/rNplN+Ts4Yn/oVz0H
	mTjQ==
MIME-Version: 1.0
X-Received: by 10.194.119.200 with SMTP id kw8mr17467314wjb.31.1361785598349; 
	Mon, 25 Feb 2013 01:46:38 -0800 (PST)
Received: by 10.180.124.106 with HTTP; Mon, 25 Feb 2013 01:46:38 -0800 (PST)
X-Originating-IP: [188.77.214.59]
In-Reply-To: <CALbNGRSioFk7F3W9yp_VbHz6sXP-LjUtg0DqJorZmyHt_+J2sw@mail.gmail.com>
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
	<CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
	<CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
	<CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
	<CALbNGRSioFk7F3W9yp_VbHz6sXP-LjUtg0DqJorZmyHt_+J2sw@mail.gmail.com>
Date: Mon, 25 Feb 2013 10:46:38 +0100
Message-ID: <CABxcv=kdCzvj=Z4GDtYC4P-az9LnT5VhrspRrZq8p568uPo9QA@mail.gmail.com>
From: Javier Martinez Canillas <javier@dowhile0.org>
To: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
X-Gm-Message-State: ALoCoQmF+cGOrnQp+QzShhCHmbcacmuSmJwBQJRyC87iY9DXv18qspxHJHv7VNsmNQWroGIn6pzt
X-Mailman-Approved-At: Tue, 26 Feb 2013 16:47:06 +0100
Cc: meta-ti@yoctoproject.org, Chris Larson <clarson@kergoth.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [meta-ti] trouble during parsing
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
X-List-Received-Date: Mon, 25 Feb 2013 10:03:13 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2013 at 10:32 AM, Andreas M=C3=BCller
<schnitzeltony@googlemail.com> wrote:
> On Mon, Feb 25, 2013 at 3:28 AM, Flanagan, Elizabeth
> <elizabeth.flanagan@intel.com> wrote:
>> On Sun, Feb 24, 2013 at 6:12 PM, Flanagan, Elizabeth
>> <elizabeth.flanagan@intel.com> wrote:
>>> On Wed, Feb 20, 2013 at 6:31 AM, Chris Larson <clarson@kergoth.com> wro=
te:
>>>>
>>>> On Wed, Feb 20, 2013 at 5:54 AM, Andreas M=C3=BCller
>>>> <schnitzeltony@googlemail.com> wrote:
>>>>>
>>>>> with current bitbake master I get
>>>>>
>>>>> ERROR: Command execution failed: Traceback (most recent call
>>>>> last):#########################################################
>>>>>                               | ETA:  00:00:17
>>>>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/command.py", lin=
e
>>>>> 92, in runAsyncCommand
>>>>>     self.cooker.updateCache()
>>>>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>>>>> 1330, in updateCache
>>>>>     if not self.parser.parse_next():
>>>>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>>>>> 1703, in parse_next
>>>>>     self.virtuals +=3D len(result)
>>>>> TypeError: object of type 'ExpansionError' has no len()
>>>>
>>>>
>>>> Hmm, looks like it's returning the exceptions rather than raising them=
, for
>>>> some reason, but that doesn't make much sense =E2=80=94 the pool code =
always raises
>>>> any exceptions from its imap iterator's next() method.
>>>> --
>>>> Christopher Larson
>>>>
>>>
>>> I'm hitting this as well with
>>> poky:dde7a481354d5b0539762109bdfaaba6f85f879b, meta-ti and pandaboard
>>> as my machine.
>>>
>>
>> Ach, should have updated my email. Seems reverting
>> 0a99563a4ea270594fd9a61da46f9387fb79dc66 cleared up the issue.
>>
>> -b
>>
> I have two machines (Fedora 14  / Fedora 15)  both reverted
> 0a99563a4ea270594fd9a61da46f9387fb79dc66 and both worked fine during
> weekend.
>
> Just a guess: Last week when arago git was down I saw errors during
> parsing for a recipe I never used. This was with a revision of bitbake
> a bit earlier than HEAD - that caused me to update. After sending a
> message to meta-ti I could work during weekend. Now it seems arago is
> down again:
>
> $ git clone git://arago-project.org/git/projects/u-boot-keystone.git
> Cloning into u-boot-keystone...
> fatal: read error: Connection reset by peer
>
> and bitbake -DD gives
>
> DEBUG: Fetcher accessed the network with the command git ls-remote
> git://arago-project.org/git/projects/u-boot-keystone.git
> DEV.MCSDK-03.00.00.07
> DEBUG: Running export SSH_AUTH_SOCK=3D"/tmp/keyring-Pob6mG/ssh"; export
> PATH=3D"/home/andreas/data/oe-core/sources/openembedded-core/scripts:/hom=
e/andreas/tmp/oe-core-eglibc/sysroots/x86_64-linux/usr/bin/armv7a-vfp-neon-=
angstrom-linux-gnueabi:/home/andreas/tmp/oe-core-eglibc/sysroots/overo/usr/=
bin/crossscripts:/home/andreas/tmp/oe-core-eglibc/sysroots/x86_64-linux/usr=
/sbin:/home/andreas/tmp/oe-core-eglibc/sysroots/x86_64-linux/usr/bin:/home/=
andreas/tmp/oe-core-eglibc/sysroots/x86_64-linux/sbin:/home/andreas/tmp/oe-=
core-eglibc/sysroots/x86_64-linux//bin:/home/andreas/oe-core/sources/bitbak=
e/bin:/home/andreas/data/OpenEmbedded/bitbake/bin:/usr/lib64/ccache:/usr/lo=
cal/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:./:/home/andreas/bin:=
/sbin:/usr/sbin";
> export HOME=3D"/home/andreas"; git ls-remote
> git://arago-project.org/git/projects/u-boot-keystone.git
> DEV.MCSDK-03.00.00.07
> DEBUG: while parsing sstate_installpkg, in call of bb.build.exec_func,
> argument 'preinst' is not a string literal
> DEBUG: while parsing sstate_install, in call of bb.build.exec_func,
> argument 'postinst' is not a string literal
>
> ...
>
> DEBUG: while parsing sstate_installpkg, in call of bb.build.exec_func,
> argument 'preinst' is not a string literal
> DEBUG: while parsing sstate_install, in call of bb.build.exec_func,
> argument 'postinst' is not a string literal
> DEBUG: while parsing do_clean, in call of bb.build.exec_func, argument
> 'f' is not a string literal
> DEBUG: while parsing sstate_installpkg, in call of bb.build.exec_func,
> argument 'preinst' is not a string literal
> ERROR: Command execution failed: Traceback (most recent call last):
>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/command.py", line
> 92, in runAsyncCommand
>     self.cooker.updateCache()
>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
> 1329, in updateCache
>     if not self.parser.parse_next():
>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
> 1702, in parse_next
>     self.virtuals +=3D len(result)
> TypeError: object of type 'ExpansionError' has no len()
>
>
> In the recipe u-boot_2013.01.bb I find SRCREV =3D "DEV.MCSDK-03.00.00.07"
>
> which is not a commit ID and causes a git ls-remote during parse
>
> Is it possible that this error occurs when a git SRC_URI server closes
> connection unexpected?
>
> Andreas

Hi Andreas,

I have the same issue and your guess is correct. The problem is that
Arago servers are down so "git ls-remote" is failing and this makes
the BitBake task to fail as well.

Now about the why is been used tag names instead of just commits IDs
so a "git ls-remote" call is needed, this is because some git trees in
arago are been rebased overwriting the commit IDs.

You may take a look to Robert P. J. Day email "[meta-ti] objections to
replacing git SRCREV tag names with actual	hash IDs?" [1] to get a
better understanding of this.

Best regards,
javier

[1]: http://www.mail-archive.com/meta-ti@yoctoproject.org/msg01304.html


