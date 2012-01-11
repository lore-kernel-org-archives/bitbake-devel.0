Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1RkwsD-0006C9-O4
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 13:01:46 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 11 Jan 2012 03:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="96961470"
Received: from pgsmsx602.gar.corp.intel.com ([10.221.43.81])
	by orsmga002.jf.intel.com with ESMTP; 11 Jan 2012 03:53:09 -0800
Received: from pgsmsx101.gar.corp.intel.com (10.221.44.78) by
	pgsmsx602.gar.corp.intel.com (10.221.43.81) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 11 Jan 2012 19:53:01 +0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Wed, 11 Jan 2012 19:53:00 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.88]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.60]) with mapi id
	14.01.0355.002; Wed, 11 Jan 2012 19:53:00 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Xu, Dongxiao"
	<dongxiao.xu@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 7/8] command.py: add new command to get
	the CPU info
Thread-Index: AQHM0FT4BwoymbIowkKelKnxUv4P4ZYHC5gg
Date: Wed, 11 Jan 2012 11:52:59 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC0FCAA7DE@SHSMSX102.ccr.corp.intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
	<d628d53679aa12f5803d0bbf30aa21ed3bc4779d.1326249301.git.dongxiao.xu@intel.com>
	<1326281642.23315.21.camel@ted>
In-Reply-To: <1326281642.23315.21.camel@ted>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 7/8] command.py: add new command to get the CPU info
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
X-List-Received-Date: Wed, 11 Jan 2012 12:01:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Richard Purdie wrote on=A02012-01-11:

> On Wed, 2012-01-11 at 11:03 +0800, Dongxiao Xu wrote:
>> Add new API in command.py to get the CPU core and threads information
>> in order to set the appropriate BB_NUMBER_THREADS and PARALLEL_MAKE
>> variables.
>>=20
>> Signed-off-by: Shane Wang <shane.wang@intel.com>
>> ---
>>  bitbake/lib/bb/helper.py |   39
>>  +++++++++++++++++++++++++++++++++++++++ lib/bb/command.py        | =20
>>  12 ++++++++++++ 2 files changed, 51 insertions(+), 0 deletions(-)
>>  create mode 100644 bitbake/lib/bb/helper.py
>> diff --git a/bitbake/lib/bb/helper.py b/bitbake/lib/bb/helper.py new
>> file mode 100644 index 0000000..291158b --- /dev/null +++
>> b/bitbake/lib/bb/helper.py @@ -0,0 +1,39 @@ +# +# Helper for BitBake
>> Graphical GTK User Interface +# +# Copyright (C) 2011        Intel
>> Corporation +# +# Authored by Shane Wang <shane.wang@intel.com> +# +#
>> This program is free software; you can redistribute it and/or modify +#
>> it under the terms of the GNU General Public License version 2 as +#
>> published by the Free Software Foundation. +# +# This program is
>> distributed in the hope that it will be useful, +# but WITHOUT ANY
>> WARRANTY; without even the implied warranty of +# MERCHANTABILITY or
>> FITNESS FOR A PARTICULAR PURPOSE.  See the +# GNU General Public
>> License for more details. +# +# You should have received a copy of the
>> GNU General Public License along +# with this program; if not, write to
>> the Free Software Foundation, Inc., +# 51 Franklin Street, Fifth Floor,
>> Boston, MA 02110-1301 USA. + +import os + +class CpuInfo(object): + + =20
>>  coefficient =3D 4
>=20
> This is setting off alarm bells...
>=20
>> +    @classmethod
>> +    def getNumOfCpus(cls):
>> +        pfile =3D os.popen('cat /proc/cpuinfo | grep cpu\ cores')
>> +        num =3D len(pfile.readlines())
>> +        return num
>=20
> You can get this number with something like:
>=20
> import multiprocessing
> multiprocessing.cpu_count()
Good to see this works, will change that.

>=20
>> +    @classmethod +    def getNumOfCpuCores(cls): +        pfile =3D
>> os.popen('cat /proc/cpuinfo | grep cpu\ cores | cut -d: -f2') +      =20
>> contents =3D pfile.readlines() +        num =3D int(contents[0]) +      =
=20
>> return num
>=20
> I'm curious what you're using the number of cores to do? It doesn't seem
> used by your code?
>=20
>=20
>> diff --git a/lib/bb/command.py b/lib/bb/command.py
>> index 05555c5..eaf8236 100644
>> --- a/lib/bb/command.py
>> +++ b/lib/bb/command.py
>> @@ -30,6 +30,7 @@ Commands are queued in a CommandQueue
>>=20
>>  import bb.event
>>  import bb.cooker
>> +import bb.helper
>>=20
>>  class CommandCompleted(bb.event.Event):
>>      pass
>> @@ -173,6 +174,17 @@ class CommandsSync:
>>          """
>>          command.cooker.reset()
>> +    def getDefaultNumOfThreads(self, command, params): +        """ +=20
>>       Get the default number of threads on the server =3D number of CPUs
>> +        """ +        return bb.helper.CpuInfo.getNumOfCpus() + +  =20
>> def getMaxNumOfThreads(self, command, params): +        """ +      =20
>> Get the max number of threads that the server can tolerate +        """
>> +        return bb.helper.CpuInfo.getNumOfCpus() *
>> bb.helper.CpuInfo.coefficient
>>=20
>=20
> I can understand needing to query the number of cpus but this last
> function seems rather arbitrary. If you want to do bounds checking, I'd
> suggest just adding the factor of 4 into the UI.
OK

> I'm still not convinced
> we should be setting any value for this though, or doing any bounds
> checking on the value.
Which value? We hope when the UI starts up, the UI can take advantage of cp=
us for build and set it as default.
But users can change between 0 ~ max num of threads.

>=20
>=20
> My only other comment would be to use bb.utils instead of creating a
> bb.helper.
>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel




