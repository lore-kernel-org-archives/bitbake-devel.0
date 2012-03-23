Received: from smtpfb1-g21.free.fr ([212.27.42.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <eric@eukrea.com>) id 1SAzlI-0003J3-2F
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 09:22:16 +0100
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id CFE7F77C543
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Mar 2012 09:13:20 +0100 (CET)
Received: from eb-e6520 (unknown [82.240.38.71])
	by smtp2-g21.free.fr (Postfix) with ESMTP id E7C5B4B0039
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Mar 2012 09:13:15 +0100 (CET)
Date: Fri, 23 Mar 2012 09:13:14 +0100
From: Eric =?ISO-8859-1?B?QuluYXJk?= <eric@eukrea.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20120323091314.5b5d00a0@eb-e6520>
In-Reply-To: <20120322122219.0df320be@eb-e6520>
References: <20120322122219.0df320be@eb-e6520>
Organization: =?ISO-8859-1?B?RXVrculh?= Electromatique
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Subject: Re: Hob : IndexError: list index out of range
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
X-List-Received-Date: Fri, 23 Mar 2012 08:22:16 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Le Thu, 22 Mar 2012 12:22:19 +0100,
Eric B=E9nard <eric@eukrea.com> a =E9crit :
> while testing HOB, once the image appears to finish to build, got this er=
ror :
>=20
> Traceback (most recent call last):
>   File "/home/ebenard/openembedded-core/bitbake/lib/bb/ui/crumbs/builder.=
py", line 431, in handler_command_succeeded_cb
>     self.switch_page(self.IMAGE_GENERATED)
>   File "/home/ebenard/openembedded-core/bitbake/lib/bb/ui/crumbs/builder.=
py", line 339, in switch_page
>     self.image_details_page.show_page(next_step)
>   File "/home/ebenard/openembedded-core/bitbake/lib/bb/ui/crumbs/imagedet=
ailspage.py", line 187, in show_page
>     image_size =3D self._size_to_string(os.stat(os.path.join(image_addr, =
image_names[0])).st_size)
> IndexError: list index out of range
>=20
is there anyone reproducing this or is this a local issue ?

Thanks
Eric


