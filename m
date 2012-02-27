Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S1zpZ-0008OS-2k
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 13:37:29 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 27 Feb 2012 04:29:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="112215812"
Received: from pgsmsx509.gar.corp.intel.com ([172.30.13.17])
	by orsmga001.jf.intel.com with ESMTP; 27 Feb 2012 04:28:00 -0800
Received: from pgsmsx152.gar.corp.intel.com (172.30.236.43) by
	PGSMSX509.gar.corp.intel.com (172.30.13.17) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 27 Feb 2012 20:26:44 +0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
	PGSMSX152.gar.corp.intel.com (172.30.236.43) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Mon, 27 Feb 2012 20:26:43 +0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.142]) by
	SHSMSX102.ccr.corp.intel.com ([169.254.2.36]) with mapi id
	14.01.0355.002; Mon, 27 Feb 2012 20:26:42 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/1][PULL] Hob2: A new implementation
	for Human Oriented Builder
Thread-Index: AQHM8p4lrmMhS/II2EaA8vPo+BOSlJZQp/Vg
Date: Mon, 27 Feb 2012 12:26:41 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23ACFDFE@SHSMSX101.ccr.corp.intel.com>
References: <cover.1330004101.git.dongxiao.xu@intel.com>
	<4F46F915.5010705@linux.intel.com>
In-Reply-To: <4F46F915.5010705@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 0/1][PULL] Hob2: A new implementation for Human Oriented Builder
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
X-List-Received-Date: Mon, 27 Feb 2012 12:37:29 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-02-24:

>=20
>=20
> On 23/02/12 05:48, Dongxiao Xu wrote:
>> Hi Richard,
>>=20
>> This pull request is a new implementation for Human Oriented Builder,
> please help to review and pull.
>=20
> Please, let's not call it the Human Oriented Builder. It was always just
> Hob, not HOB - are we changing that now?
>=20
>> Changes from previous pull requests:
>>   - Re-implemented a lot of code according to Belen's new GUI design.
>=20
> This is really hard to review as a several thousand line patch... It's
> difficult to know where what seems like an odd decision in the code was
> made for a sane reason without any git history or code comments to
> follow the logic of the development.
>=20
> The fact that the patch was rejected by the mailing list is a good
> indication that we need to separate into smaller logical commits.
>=20
> I could review coding style, but that is probably pretty useless at this
> point and so  offer somewhat superficial comments below regarding UI
> implementation with Gtk+.
Sorry for that, it convinces me that a design document is useful.
The problem is because the UI was changed a lot in a short time, even thoug=
h we compared with our previous version in Jan.
So, next time we will pay more attention to submit incremental patches.


>=20
> First things first, I can't run the BitBake in the submitted branch:
>=20
> joshual@shamshir:~/Projects/Yocto/poky/build [master *]
> $ ../bitbake/bin/bitbake -u hob
>=20
> Traceback (most recent call last):
>    File "../bitbake/bin/bitbake", line 258, in <module>
>      ret =3D main() File "../bitbake/bin/bitbake", line 178, in main
>      ui_main =3D get_ui(configuration) File "../bitbake/bin/bitbake", lin=
e
>      68, in get_ui module =3D __import__("bb.ui", fromlist =3D [interface=
])
>      File "../bitbake/lib/bb/ui/hob.py", line 33, in <module> from
>      bb.ui.crumbs.hoblistmodel import RecipeListModel,
> PackageListModel
>=20
> I found and ran a recent poky-contrib branch for Hob, though I've no
> idea if it reflects what's in this patch, just so that I had something
> to look at and offer feedback on.
>=20
> The Build environment tab of the settings dialogue doesn't fit in the
> allocated space - I had to resize the dialogue to see Save and Cancel
> buttons. This is also true of the Others tab though less so.
> These buttons don't follow the GNOME HIG in several ways, perhaps this
> is intentional?

We didn't notice the code didn't follow the GNOME HIG, and thank you for yo=
ur patches to fix it.

>=20
> It's also worth noting that the visual style 'leaks' in the Settings
> dialogue and I see standard Gtk light-bulb info icons rather than the
> steely i displayed on the main page.
In the settings dialog, we didn't make any specific icon for tool tip.
On Ubuntu, it is a "i". On Fedora 16, it becomes a light-bulb. I am thinkin=
g how to make it?

>=20
> The 'Package list may be incomplete' dialogue is a very nice piece of
> functionality but interface-wise I'd expect to see the buttons labelled
> along the lines of 'Get full list' 'View existing'.
Will consider to make them.

>=20
> It seems like the Stop Build tracking isn't consistently reset between
> builds so when I was playing around started & stopped a build then
> played some more and started another build and tried to stop it I only
> had the option to Force Stop or Cancel...
OK.

>=20
> Taking a look at the code the first thing I notice is multiples of 5 for
> spacing, why is that? I thought we'd agreed with Belen that we'd follow
> the GNOME HIG for consistent visuals amongst Gtk+ apps?
OK

> Further, there are still hard-coded colour values. Are these issues on
> the "to fix later" list?
Do you mean the green progress bar and others? For the progress bar, Jessic=
a has a comment that she doesn't want see orange bar which is the default o=
n Ubuntu but want to see a green one which is consistent with the running c=
olor in the build details.
For some buttons like "Just bake", we try to make it look the same as Belen=
's video.
Are you suggesting to set them default?

If not the above, the hard-coded color values should be fixed, we hope to i=
nclude all color values in hobcolor.py


>=20
> I'm not suggesting these hold up merging - just asking the question. I
> can play HIG zealot and write a patch once this is merged? I think it's
> important we present a professional GUI which matches the visuals of the
> host OS.
>=20
> The buttons that act like tabs for changing between notebook pages (i.e.
> on the 'Package Selection' view) took me a long time to figure out as
> they look like they are depressed (mid-click) buttons for the inactive
> tabs and ready to click buttons for the active tabs - confusing visual.
I have the patches to fix it, and am cleaning them up for submission.

>=20
> There's at least one instance of commented out code (a signal handler
> connection in builder.py) - we can probably drop those, right?
Do you mean to drop the handler instance in builder.py?
If so, how could the builder call the handler's functions?

>=20
> Setting the size and position of windows on each launch (as in
> builder.py) is generally considered to be hostile to users - it should
> be sufficient to start with a sane default size and then as the UI
> allows the user to resize it we should remember the size for the next
> launch.
OK. But sometimes we should consider the screen dimension. For instance the=
 builder, the main window, I bet on a smaller screen (say, 800X600) the vis=
ual components will look ugly. How can I address the problem? For the posit=
ion of the window, I agree.


>=20
> This UI has come on leaps and bounds and I look forward to seeing this
> foundation polished over the coming weeks. Maybe I can even submit some
> changes myself.
If you can help on some, that would be great. Thank you, Josh.

>=20
> Hopefully this splash of feedback gives you something to work with...
>=20
> Cheers,
> Joshua




