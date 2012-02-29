Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2Z6x-00050f-D4
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 03:17:47 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 28 Feb 2012 18:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="112871740"
Received: from pgsmsx509.gar.corp.intel.com ([172.30.13.17])
	by orsmga001.jf.intel.com with ESMTP; 28 Feb 2012 18:05:47 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX509.gar.corp.intel.com (172.30.13.17) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 29 Feb 2012 10:04:54 +0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.142]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Wed, 29 Feb 2012 10:04:52 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Joshua Lock <josh@linux.intel.com>
Thread-Topic: [bitbake-devel] [PATCH 0/1][PULL] Hob2: A new implementation
	for Human Oriented Builder
Thread-Index: AQHM9aW4loqlh5XeRU6xGA6MAaFRHJZTIB9g
Date: Wed, 29 Feb 2012 02:04:51 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AD27D6@SHSMSX101.ccr.corp.intel.com>
References: <cover.1330004101.git.dongxiao.xu@intel.com>
	<4F46F915.5010705@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23ACFDFE@SHSMSX101.ccr.corp.intel.com>
	<4F4C0E99.3000706@linux.intel.com>
In-Reply-To: <4F4C0E99.3000706@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Wed, 29 Feb 2012 02:17:47 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Joshua Lock wrote on=A02012-02-28:

>=20
>=20
>>> It's also worth noting that the visual style 'leaks' in the Settings
>>> dialogue and I see standard Gtk light-bulb info icons rather than the
>>> steely i displayed on the main page.
>> In the settings dialog, we didn't make any specific icon for tool tip.
>> On Ubuntu, it is a "i". On Fedora 16, it becomes a light-bulb. I am thin=
king
> how to make it?
>=20
> That's because Ubuntu and Fedora use different stock themes. I think it
> makes sense to use the i graphic from the visual design wherever you're
> currently using gtk.STOCK_INFO.
OK, will have a try.

>=20
>>> Further, there are still hard-coded colour values. Are these issues on
>>> the "to fix later" list?
>> Do you mean the green progress bar and others? For the progress bar,
> Jessica has a comment that she doesn't want see orange bar which is the
> default on Ubuntu but want to see a green one which is consistent with th=
e
> running color in the build details.
>> For some buttons like "Just bake", we try to make it look the same as
>> Belen's video. Are you suggesting to set them default?
>=20
> I am, but I guess the design team needs to have the final say here. I
> think Belen agreed with me in principle that we should use the colours
> from the users theme to start and iterate from there. On my Fedora
> machine green progress bars and orange buttons look rather out of place
> in a software ecosystem which has a fairly consistent look and feel
> between applications. However I care less about the colours than I do
> about the button order, per my submitted patches.
I also agree to use the default colors set by the OS.

>>> There's at least one instance of commented out code (a signal handler
>>> connection in builder.py) - we can probably drop those, right?
>> Do you mean to drop the handler instance in builder.py?
>> If so, how could the builder call the handler's functions?
>=20
> There's a commented out line which would connect to a signal handler
> where it not commented out at line 201 of builder.py:
> http://git.yoctoproject.org/cgit/cgit.cgi/poky/tree/bitbake/lib/bb/ui/cru
> mbs/b uilder.py#n201
>=20
> We can probably delete that, right?
My fault, my fault, when did it come there;-)

>>> Setting the size and position of windows on each launch (as in
>>> builder.py) is generally considered to be hostile to users - it should
>>> be sufficient to start with a sane default size and then as the UI
>>> allows the user to resize it we should remember the size for the next
>>> launch.
>> OK. But sometimes we should consider the screen dimension. For instance
> the builder, the main window, I bet on a smaller screen (say, 800X600) th=
e
> visual components will look ugly. How can I address the problem? For the
> position of the window, I agree.
>=20
> I don't think that telling people their resolution is too low is
> especially helpful here. They can probably see that the GUI doesn't fit.
>=20
> I don't know anyone that runs their system with a lower than supported
> resolution, so telling them about something they can't fix doesn't help
> them. It just adds insult to injury, so to speak.

Understand.

--
Shane


