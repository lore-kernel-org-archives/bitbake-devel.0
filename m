Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>)
	id 1QQ3dy-0006KE-H3; Fri, 27 May 2011 22:28:27 +0200
Received: by wye20 with SMTP id 20so1729654wye.6
	for <multiple recipients>; Fri, 27 May 2011 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:content-transfer-encoding;
	bh=+z0845K8rC95PpG3WxuSINxMljDRwC1G1Nai19djZqM=;
	b=oj3lzmXzpz2VVPG7oi/MfxYVYKw6Dkpf+tG6DYH4O68FJtNoeCqN2He/sJGkoTr4x1
	bzCHsfaOrVN6TcidWCBdNyNxxZBhcj6ZKQKjrbBgdVq4mhH6D82dqYmtsBylS5/oKCH2
	ABzAGKqAo0X6qwv5BwSNLdxHeIXxJ4VDQ9T7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	b=Z0I87CYObxiuu6S49rvI+hjTzYuV+4fO85WDGkC5kMMNVQs2WCalwVs0GFnwKcpghW
	VP3pWAC4FlWiZj+e3U6rYiIfpK3TI52sLupObCV7mn+MS80X0qsOu3a+sGnYdyDlnWP8
	6olcMK5sboDVBbUipNSRB5e1jsi0K9c2fjpis=
Received: by 10.216.55.193 with SMTP id k43mr2424294wec.51.1306527918082; Fri,
	27 May 2011 13:25:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.60.145 with HTTP; Fri, 27 May 2011 13:24:48 -0700 (PDT)
In-Reply-To: <1306526949.1747.8.camel@vorpal>
References: <cover.1306477652.git.lianhao.lu@intel.com>
	<1306515635.27470.284.camel@rex>
	<7DC6724C-BF20-4EA1-A87D-32FBEEECDA3B@dominion.thruhere.net>
	<1306526949.1747.8.camel@vorpal>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 27 May 2011 13:24:48 -0700
Message-ID: <BANLkTinBdsRo3KBTzHg=P_5oe9m_ZJ1baA@mail.gmail.com>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] [PATCH 00/11] Add PR service and integrate PKGV/PKGR from OE
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
X-List-Received-Date: Fri, 27 May 2011 20:28:27 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, May 27, 2011 at 1:09 PM, Joshua Lock <josh@linux.intel.com> wrote:
> On Fri, 2011-05-27 at 20:48 +0200, Koen Kooi wrote:
>> Op 27 mei 2011, om 19:00 heeft Richard Purdie het volgende geschreven:
>>
>> > Hi Lianhao,
>> >
>> > On Fri, 2011-05-27 at 14:31 +0800, Lianhao Lu wrote:
>> >> =C2=A0git://git.pokylinux.org/poky-contrib llu/PR-service
>> >> =C2=A0http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=3Dllu/PR-=
service
>> >>
>> >> Lianhao Lu (11):
>> >> =C2=A0Added the PR service.
>> >> =C2=A0conf/bitbake.conf: Added variables for PR service.
>> >> =C2=A0meta-yocto/local.conf.sample: Added PRSERV_HOST and PRSERV_PORT=
.
>> >> =C2=A0classes/package(prserv).bbclass: Get PRAUTO and use PKGV/PKGR.
>> >> =C2=A0classes/package_xxx.class: Use PKGE/PKGV/PKGR.
>> >> =C2=A0udev: use EXTENDPKGV instead of EXTENDPV.
>> >> =C2=A0xcb: use EXTENDPKGV instead of EXTENDPV.
>> >> =C2=A0xorg-proto: use EXTENDPKGV instead of EXTENDPV.
>> >> =C2=A0xorg-util/util-macros: use EXTENDPKGV instead of EXTENDPV.
>> >> =C2=A0linux-libc-headers: use EXTENDPKGV instead of EXTENDPV.
>> >> =C2=A0conf/bitbake.conf: Removed EXTENDPV and EXTENDPEVER.
>> >
>> > I merged this but I did make some tweaks to both the patch series and
>> > one of the patches. The changes I made were:
>> >
>> > a) Squash the EXTENDPV and EXTENDPEVER changes into the base patch
>> > making all the associated changes in one go.
>> >
>> > b) Not include the DISTRO_PR variable for now
>> >
>> > c) Not change the default signature handler to basichash.
>> >
>> > For c), I'd suggest a follow up patch changing the default in poky.con=
f
>> > in meta-yocto and we'll test this there. This should wait until the
>> > PACKAGE_ARCH =3D "all" sstate issues we've been seeing are addressed
>> > though.
>>
>> On Fedora 14 I get this when trying to rebuild console-image:
>>
>> ERROR: (file: 'package_get_auto_pr', lineno: 4, function: package_get_au=
to_pr)
>> ERROR: Function 'package_get_auto_pr' failed
>> ERROR: Logfile of failure stored in: /home/koen/angstrom-core/build/tmp-=
angstrom_2010_x-eglibc/work/armv7a-angstrom-linux-gnueabi/dbus-1.4.1-r5/tem=
p/log.do_package.24742
>> Log data follows:
>> | ERROR: Error executing a python function in /home/koen/angstrom-core/s=
ources/openembedded-core/meta/recipes-core/dbus/dbus_1.4.1.bb:
>> | ImportError: No module named xmlrpc
>> |
>> | ERROR: The stack trace of python calls that resulted in this exception=
/failure was:
>> | ERROR: =C2=A0 File "package_get_auto_pr", line 11, in <module>
>> | ERROR:
>> | ERROR: =C2=A0 File "package_get_auto_pr", line 4, in package_get_auto_=
pr
>> | ERROR:
>> | ERROR: =C2=A0 File "prserv.bbclass", line 8, in prserv_get_pr_auto
>> | ERROR:
>> | ERROR: =C2=A0 File "prserv.bbclass", line 2, in prserv_make_conn
>> | ERROR:
>> | ERROR: =C2=A0 File "/home/koen/angstrom-core/sources/bitbake/lib/prser=
v/serv.py", line 6, in <module>
>> | ERROR: =C2=A0 =C2=A0 import bb.server.xmlrpc
>
> Upstream BitBake still has the xmlrpc server removed. The version in
> Poky's BitBake is functional (I use it daily).
>

I use bb master and oe-core

> Attached are two patches against BitBake master to add back the xmlrpc
> server (copied from Poky's tree) and fix the uievent.
>
>> | ERROR:
>> | ERROR: The code that was being executed was:
>> | ERROR: =C2=A0 =C2=A0 =C2=A00007: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return
>> | ERROR: =C2=A0 =C2=A0 =C2=A00008: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 d.setVar('PRAUTO',str(auto_pr))
>> | ERROR: =C2=A0 =C2=A0 =C2=A00009:
>> | ERROR: =C2=A0 =C2=A0 =C2=A00010:
>> | ERROR: =C2=A0*** 0011:package_get_auto_pr(d)
>> | ERROR: =C2=A0 =C2=A0 =C2=A00012:
>> | ERROR: (file: 'package_get_auto_pr', lineno: 11, function: <module>)
>> | ERROR: =C2=A0 =C2=A0 =C2=A00001:
>> | ERROR: =C2=A0 =C2=A0 =C2=A00002:def package_get_auto_pr(d):
>> | ERROR: =C2=A0 =C2=A0 =C2=A00003: =C2=A0 =C2=A0 if d.getVar('USE_PR_SER=
V', True):
>> | ERROR: =C2=A0*** 0004: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auto_=
pr=3Dprserv_get_pr_auto(d)
>> | ERROR: =C2=A0 =C2=A0 =C2=A00005: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if auto_pr is None:
>> | ERROR: =C2=A0 =C2=A0 =C2=A00006: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.fatal("Can NOT get auto PR revision f=
rom remote PR service")
>> | ERROR: =C2=A0 =C2=A0 =C2=A00007: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return
>> | ERROR: =C2=A0 =C2=A0 =C2=A00008: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 d.setVar('PRAUTO',str(auto_pr))
>> | ERROR: (file: 'package_get_auto_pr', lineno: 4, function: package_get_=
auto_pr)
>> | ERROR: Function 'package_get_auto_pr' failed
>>
>> It doesn't seem to trigger on my debian box, though
>
> Are you using Poky on the Debian box?

ubuntu 64bit oe-core no poky

>
> Cheers,
> Joshua
> --
> Joshua Lock
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Yocto Project Build Monkey
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Intel Open Source Technology Centre
>
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core
>
>


