Received: from mx4.leapfrog.com ([63.114.26.254])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dlazzari@leapfrog.com>) id 1RLlVd-0005gs-Oz
	for bitbake-devel@lists.openembedded.org;
	Thu, 03 Nov 2011 01:50:22 +0100
Received: from mx4.leapfrog.com (localhost [127.0.0.1])
	by localhost.leapfrog.com (Postfix) with ESMTP
	id 089DC5EBE; Wed,  2 Nov 2011 17:44:13 -0700 (PDT)
Received: from NAEXCHHT01.na.leapfrog.com (unknown [10.15.6.13])
	by mx4.leapfrog.com (Postfix) with ESMTP
	id E07505E76; Wed,  2 Nov 2011 17:44:12 -0700 (PDT)
Received: from NAEMCASHT02.na.leapfrog.com (10.12.2.36) by
	NAEXCHHT01.na.leapfrog.com (10.15.6.13) with Microsoft SMTP Server
	(TLS) id 8.2.254.0; Wed, 2 Nov 2011 17:44:12 -0700
Received: from NAEMMAIL01.na.leapfrog.com ([fe80::252e:28a6:3d8f:6991]) by
	NAEMCASHT02.na.leapfrog.com ([::1]) with mapi id 14.01.0289.001;
	Wed, 2 Nov 2011 17:44:12 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: 'Denys Dmytriyenko' <denis@denix.org>
Thread-Topic: [bitbake-devel] Bug with task variable overrides
Thread-Index: AcyZsmHqLpr8sWkpQiSOzVscf5bqyQASCDAAAA6adgA=
Date: Thu, 3 Nov 2011 00:44:12 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0F042413E6@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F042412CE@NAEMMAIL01.na.leapfrog.com>
	<20111103003050.GZ15391@denix.org>
In-Reply-To: <20111103003050.GZ15391@denix.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.100.2.5]
MIME-Version: 1.0
Cc: "'bitbake-devel@lists.openembedded.org'"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Bug with task variable overrides
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
X-List-Received-Date: Thu, 03 Nov 2011 00:50:22 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From: Denys Dmytriyenko [mailto:denis@denix.org]
>Sent: Wednesday, November 02, 2011 5:31 PM
>To: Daniel Lazzari

>On Wed, Nov 02, 2011 at 10:54:31PM +0000, Daniel Lazzari wrote:
>> I recently tried to use per task overrides for several variables and
>ran
>> into a bug. If the task name has an underscore in it, the overrides
>won't
>> work properly. Here's a quick test case I did using Angstrom oe-core:
>>
>> MYVAR =3D "apples"
>> MYVAR_task-my_task =3D "oranges"
>>
>> LICENSE =3D ""
>>
>> do_my_task() {
>>                 echo ${MYVAR}
>> }
>>
>> addtask my_task before do_fetch
>>
>> After running the task, the log for the task shows "apples" when it
>should
>> show "oranges". My work around so far is not to use underscores in my
>task
>> name, but that makes the task name look pretty unreadable. I tried to
>see if
>> I could figure out a quick fix but the data_smart stuff looks pretty
>> complicated and I don't have a lot of time to spend on this. If
>there's a
>> place where you want me to file a proper bug report, just let me know.
>
>Daniel,
>
>As far as I know, it's a known limitation and was there for many years.
>It's
>not straightforward to parse override names with underscores, as you can
>combine multiple overrides, plus there are additional keywords like
>append and
>prepend, that are used the same way. E.g.
>MYVAR_append_distro_arch_soc_mach_pn.
>It's recommended to use dashes instead of underscores for variable
>values,
>such as DISTRO=3D"angstrom-2010.x", MACHINE=3D"am37x-evm", PN=3D"linux-lib=
c-
>headers"
>etc., so they are safe to use as overrides. Not with task/function
>names,
>though.
>
>--
>Denys

That makes sense. Thanks for the explanation. Is this limitation in the bit=
bake manual? I don't remember seeing it there (though I probably don't have=
 the latest one) and I think it would save others a lot of time trying to t=
rack something like this down.


