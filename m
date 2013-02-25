Received: from mail-ve0-f169.google.com ([209.85.128.169])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <schnitzeltony@googlemail.com>) id 1U9ufu-0002xV-Ca
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 10:49:09 +0100
Received: by mail-ve0-f169.google.com with SMTP id 15so1995358vea.14
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Feb 2013 01:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=googlemail.com; s=20120113;
	h=mime-version:x-received:in-reply-to:references:date:message-id
	:subject:from:to:cc:content-type:content-transfer-encoding;
	bh=citE/Dn23gt2GIgZULE2GFm2obyQm9MgjLUIzOtBrdI=;
	b=PA4mhGvj3Bey+4BamYbSC/R0UHg9iO+calM3EkAlkQXIRKlA0ZLVsYvJ1APtKkTyJh
	xm2gzAM4KtX8QWrFg/2QnzG85P87LeoYK8MI88jewjrwnLyYORTrqjF5hhwwbr96mCif
	Q6zQAw/gAzy0tEaOR97kIEJgfa+DZVTStgbtHpefHnD8Vf+OSGypNVrBwSW/x1JgEdeD
	4FRJ7DR1pakkCkrrcUEwLGzoICbAA56tAAH0VtIqg+R6uS/eDkypIYgsoA2rM0H7WyU1
	4gXmLBT6cIDZwCN7EsywkDAo8llEu2kZKkPw2z/pyg9ODr9uIuccl/9QRVxtsePrpdbb
	0o6A==
MIME-Version: 1.0
X-Received: by 10.220.219.73 with SMTP id ht9mr9404329vcb.47.1361784748546;
	Mon, 25 Feb 2013 01:32:28 -0800 (PST)
Received: by 10.52.185.168 with HTTP; Mon, 25 Feb 2013 01:32:28 -0800 (PST)
In-Reply-To: <CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
	<CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
	<CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
	<CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
Date: Mon, 25 Feb 2013 10:32:28 +0100
Message-ID: <CALbNGRSioFk7F3W9yp_VbHz6sXP-LjUtg0DqJorZmyHt_+J2sw@mail.gmail.com>
From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@googlemail.com>
To: "Flanagan, Elizabeth" <elizabeth.flanagan@intel.com>
Cc: meta-ti@yoctoproject.org, Chris Larson <clarson@kergoth.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: trouble during parsing
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
X-List-Received-Date: Mon, 25 Feb 2013 09:49:17 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2013 at 3:28 AM, Flanagan, Elizabeth
<elizabeth.flanagan@intel.com> wrote:
> On Sun, Feb 24, 2013 at 6:12 PM, Flanagan, Elizabeth
> <elizabeth.flanagan@intel.com> wrote:
>> On Wed, Feb 20, 2013 at 6:31 AM, Chris Larson <clarson@kergoth.com> wrot=
e:
>>>
>>> On Wed, Feb 20, 2013 at 5:54 AM, Andreas M=C3=BCller
>>> <schnitzeltony@googlemail.com> wrote:
>>>>
>>>> with current bitbake master I get
>>>>
>>>> ERROR: Command execution failed: Traceback (most recent call
>>>> last):#########################################################
>>>>                               | ETA:  00:00:17
>>>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/command.py", line
>>>> 92, in runAsyncCommand
>>>>     self.cooker.updateCache()
>>>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>>>> 1330, in updateCache
>>>>     if not self.parser.parse_next():
>>>>   File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
>>>> 1703, in parse_next
>>>>     self.virtuals +=3D len(result)
>>>> TypeError: object of type 'ExpansionError' has no len()
>>>
>>>
>>> Hmm, looks like it's returning the exceptions rather than raising them,=
 for
>>> some reason, but that doesn't make much sense =E2=80=94 the pool code a=
lways raises
>>> any exceptions from its imap iterator's next() method.
>>> --
>>> Christopher Larson
>>>
>>
>> I'm hitting this as well with
>> poky:dde7a481354d5b0539762109bdfaaba6f85f879b, meta-ti and pandaboard
>> as my machine.
>>
>
> Ach, should have updated my email. Seems reverting
> 0a99563a4ea270594fd9a61da46f9387fb79dc66 cleared up the issue.
>
> -b
>
I have two machines (Fedora 14  / Fedora 15)  both reverted
0a99563a4ea270594fd9a61da46f9387fb79dc66 and both worked fine during
weekend.

Just a guess: Last week when arago git was down I saw errors during
parsing for a recipe I never used. This was with a revision of bitbake
a bit earlier than HEAD - that caused me to update. After sending a
message to meta-ti I could work during weekend. Now it seems arago is
down again:

$ git clone git://arago-project.org/git/projects/u-boot-keystone.git
Cloning into u-boot-keystone...
fatal: read error: Connection reset by peer

and bitbake -DD gives

DEBUG: Fetcher accessed the network with the command git ls-remote
git://arago-project.org/git/projects/u-boot-keystone.git
DEV.MCSDK-03.00.00.07
DEBUG: Running export SSH_AUTH_SOCK=3D"/tmp/keyring-Pob6mG/ssh"; export
PATH=3D"/home/andreas/data/oe-core/sources/openembedded-core/scripts:/home/=
andreas/tmp/oe-core-eglibc/sysroots/x86_64-linux/usr/bin/armv7a-vfp-neon-an=
gstrom-linux-gnueabi:/home/andreas/tmp/oe-core-eglibc/sysroots/overo/usr/bi=
n/crossscripts:/home/andreas/tmp/oe-core-eglibc/sysroots/x86_64-linux/usr/s=
bin:/home/andreas/tmp/oe-core-eglibc/sysroots/x86_64-linux/usr/bin:/home/an=
dreas/tmp/oe-core-eglibc/sysroots/x86_64-linux/sbin:/home/andreas/tmp/oe-co=
re-eglibc/sysroots/x86_64-linux//bin:/home/andreas/oe-core/sources/bitbake/=
bin:/home/andreas/data/OpenEmbedded/bitbake/bin:/usr/lib64/ccache:/usr/loca=
l/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:./:/home/andreas/bin:/s=
bin:/usr/sbin";
export HOME=3D"/home/andreas"; git ls-remote
git://arago-project.org/git/projects/u-boot-keystone.git
DEV.MCSDK-03.00.00.07
DEBUG: while parsing sstate_installpkg, in call of bb.build.exec_func,
argument 'preinst' is not a string literal
DEBUG: while parsing sstate_install, in call of bb.build.exec_func,
argument 'postinst' is not a string literal

...

DEBUG: while parsing sstate_installpkg, in call of bb.build.exec_func,
argument 'preinst' is not a string literal
DEBUG: while parsing sstate_install, in call of bb.build.exec_func,
argument 'postinst' is not a string literal
DEBUG: while parsing do_clean, in call of bb.build.exec_func, argument
'f' is not a string literal
DEBUG: while parsing sstate_installpkg, in call of bb.build.exec_func,
argument 'preinst' is not a string literal
ERROR: Command execution failed: Traceback (most recent call last):
  File "/home/andreas/oe-core/sources/bitbake/lib/bb/command.py", line
92, in runAsyncCommand
    self.cooker.updateCache()
  File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
1329, in updateCache
    if not self.parser.parse_next():
  File "/home/andreas/oe-core/sources/bitbake/lib/bb/cooker.py", line
1702, in parse_next
    self.virtuals +=3D len(result)
TypeError: object of type 'ExpansionError' has no len()


In the recipe u-boot_2013.01.bb I find SRCREV =3D "DEV.MCSDK-03.00.00.07"

which is not a commit ID and causes a git ls-remote during parse

Is it possible that this error occurs when a git SRC_URI server closes
connection unexpected?

Andreas


