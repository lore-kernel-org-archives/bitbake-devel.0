Received: from mx3.leapfrog.com ([63.114.26.253])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1SzEL3-0004DA-Rh
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 00:02:50 +0200
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx3.leapfrog.com (Postfix) with ESMTP
	id 605915FA5; Wed,  8 Aug 2012 14:18:33 -0700 (PDT)
Received: from NAEMCASHT01.na.leapfrog.com (10.16.4.161) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 8 Aug 2012 14:19:32 -0700
Received: from naemmail02.na.leapfrog.com ([fe80::ad94:5dcc:6325:ef50]) by
	NAEMCASHT01.na.leapfrog.com ([::1]) with mapi id 14.01.0355.002;
	Wed, 8 Aug 2012 14:19:32 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: 'McClintock Matthew-B29882' <B29882@freescale.com>
Thread-Topic: [bitbake-devel] Making a noexec task executable again
Thread-Index: Ac10/wK56xnEDy3/RluNmfNX4LwVBQA1vzYAAAq494A=
Date: Wed, 8 Aug 2012 21:19:32 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0FB5B1F690@NAEMMAIL02.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0FB5B1F2A8@NAEMMAIL02.na.leapfrog.com>
	<CAEsOVNc6KjAdgpgnUgJ_UiR=vD6kE2OYo1BX4JfKLGUStPhVRQ@mail.gmail.com>
In-Reply-To: <CAEsOVNc6KjAdgpgnUgJ_UiR=vD6kE2OYo1BX4JfKLGUStPhVRQ@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.2.5]
MIME-Version: 1.0
Cc: "'bitbake-devel@lists.openembedded.org'
	\(bitbake-devel@lists.openembedded.org\)"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Making a noexec task executable again
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
X-List-Received-Date: Wed, 08 Aug 2012 22:02:50 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>> I ran across an interesting challenge today. One of our old image recipe=
s is
>being ported into denzil and needs to fetch a file to do some whitelist
>processing. Unfortunately, in denzil, the image class has
>>
>> do_fetch[noexec] =3D "1"
>>
>> which stops the fetch task from running. How can I get it to run again? =
I tried
>>
>> do_fetch[noexec] =3D "0"
>>
>> and
>>
>> do_fetch[noexec] =3D ""
>>
>> to no avail.
>
>One option is to add a new task that calls base_do_fetch?
>
>-M

Good suggestion but it didn't seem to work. I added this to my image:
addtask fetch2
do_fetch2[dirs] =3D "${DL_DIR}"
python do_fetch2() {
	base_do_fetch()
}

And I get an error saying:
NameError: global name 'base_do_fetch' is not defined



