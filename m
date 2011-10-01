Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <koen@dominion.thruhere.net>)
	id 1RA3nn-0005f9-Kd; Sat, 01 Oct 2011 19:56:43 +0200
Received: by gyg8 with SMTP id 8so2379381gyg.6
	for <multiple recipients>; Sat, 01 Oct 2011 10:51:13 -0700 (PDT)
Received: by 10.101.165.2 with SMTP id s2mr5146726ano.58.1317491472731;
	Sat, 01 Oct 2011 10:51:12 -0700 (PDT)
Received: from [10.1.10.78] (rrcs-97-79-162-178.sw.biz.rr.com. [97.79.162.178])
	by mx.google.com with ESMTPS id u4sm23426222ane.21.2011.10.01.10.51.11
	(version=TLSv1/SSLv3 cipher=OTHER);
	Sat, 01 Oct 2011 10:51:12 -0700 (PDT)
References: <4E85D3E0.7070807@intel.com> <4E863AE8.7020901@mlbassoc.com>
	<33AB447FBD802F4E932063B962385B3512DAF448FB@shsmsx501.ccr.corp.intel.com>
	<CAP9ODKpnvcCJWCYDMbyL5n_HDjxb+6cwy54BWTaXqM2eH5=G_w@mail.gmail.com>
In-Reply-To: <CAP9ODKpnvcCJWCYDMbyL5n_HDjxb+6cwy54BWTaXqM2eH5=G_w@mail.gmail.com>
Mime-Version: 1.0 (iPhone Mail 8L1)
Message-Id: <EE88C9B7-2646-4305-A8A8-4BD2BA031C27@dominion.thruhere.net>
X-Mailer: iPhone Mail (8L1)
From: Koen Kooi <koen@dominion.thruhere.net>
Date: Sat, 1 Oct 2011 12:51:06 -0500
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Cc: "Lock, Joshua" <joshua.lock@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Feedback on HOB (new image creator GUI)
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
X-List-Received-Date: Sat, 01 Oct 2011 17:56:43 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



Op 1 okt. 2011 om 12:46 heeft Otavio Salvador <otavio@ossystems.com.br> het v=
olgende geschreven:

> On Fri, Sep 30, 2011 at 21:23, Yu, Ke <ke.yu@intel.com> wrote:
> ...
>> So currently, if you name your own image with XXX-image, HOB should be ab=
le to automatically add it in the drop-down list.
>>=20
>> And yes, it is helpful to allow user adding item into base image list. it=
 can be done by adding one item in "Edit"->"Preference". I will add this req=
uirement to my plan. For base image filtering, I am not sure if it is necess=
ary, since base image list is not that long. How do you think?
> ...
>=20
> It would be nice to have a way to filter out images too. In case we're
> customizing oe-core to a customer we might want to reduce the options
> to avoid unsupported images to be built.

Like a whitelist regexp on hob.conf


>=20
> --=20
> Otavio Salvador                             O.S. Systems
> E-mail: otavio@ossystems.com.br  http://www.ossystems.com.br
> Mobile: +55 53 9981-7854              http://projetos.ossystems.com.br
>=20
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core


