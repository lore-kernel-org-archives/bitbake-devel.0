Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SKM5m-0007eC-8d
	for bitbake-devel@lists.openembedded.org;
	Wed, 18 Apr 2012 06:02:06 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 17 Apr 2012 20:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="90319322"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by AZSMGA002.ch.intel.com with ESMTP; 17 Apr 2012 20:52:37 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 17 Apr 2012 20:52:36 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.57]) by
	SHSMSX101.ccr.corp.intel.com ([169.254.1.195]) with mapi id
	14.01.0355.002; Wed, 18 Apr 2012 11:52:35 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, "Xu, Dongxiao"
	<dongxiao.xu@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 1/4] bitbake: Retain order for
	__depends and __base_depends
Thread-Index: AQHNHIZ7SRWqnLc9O0OQvPfq4Il105af8lKQ
Date: Wed, 18 Apr 2012 03:52:34 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC0FD4FABC@SHSMSX102.ccr.corp.intel.com>
References: <cover.1334650694.git.dongxiao.xu@intel.com>
	<49da1e00e1a8a0b0b241942cc70cfc89be232a2a.1334650694.git.dongxiao.xu@intel.com>
	<1334659179.616.72.camel@ted>
In-Reply-To: <1334659179.616.72.camel@ted>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/4] bitbake: Retain order for __depends and __base_depends
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
X-List-Received-Date: Wed, 18 Apr 2012 04:02:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Richard Purdie wrote on 2012-04-17:
> Hi Dongxiao,
>=20
> I've spent a while thinking about this patch and its implications. We
> have several potential correctness issues here. I finally realised there
> is a correctness issue for get_file_depends() with the ordering which

Currently the only user of get_file_depends() is the variable BBINCLUDED=20
which is used by eclipse plugin. I'm not sure whether other uses of __(base=
_)depends
care about the order, but eclipse plugin doesn't care about the order very =
much,
as long as the patch doesn't change the BBINCLUDED content.

> means I can't merge it :(. I'm going to give all the feedback I came up
> with whilst considering it as there are other details we need to get
> right.
>=20
> The issue is that we need consider what we're using this variable for
> and how. We need the data to be meaningful, useful and correct. We're
> trying to use the data for multiple things and it needs to be correct in
> each case.
>=20
> On Tue, 2012-04-17 at 16:21 +0800, Dongxiao Xu wrote:
>> Bitbake take seriously with variables order, therefore when setting
>> values to __depends and __base_depends, we need to retain its order.
>>=20
>> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
>> ---
>>  lib/bb/cache.py          |    6 ++++--
>>  lib/bb/cooker.py         |    6 ++++--
>>  lib/bb/parse/__init__.py |   12 ++++++++----
>>  3 files changed, 16 insertions(+), 8 deletions(-)
>> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
>> index 47e814b..a114582 100644
>> --- a/lib/bb/cache.py
>> +++ b/lib/bb/cache.py
>> @@ -391,12 +391,14 @@ class Cache(object):
>>          """Parse the specified filename, returning the recipe informati=
on"""
>>          infos =3D []
>>          datastores =3D cls.load_bbfile(filename, appends, configdata)
>> -        depends =3D set()
>> +        depends =3D []
>>          for variant, data in sorted(datastores.iteritems(),
>>                                      key=3Dlambda i: i[0],
>>                                      reverse=3DTrue):
>>              virtualfn =3D cls.realfn2virtual(filename, variant)
>> -            depends |=3D (data.getVar("__depends", False) or set())
>> +            for dep in (data.getVar("__depends", False) or []):
>> +                if dep not in depends:
>> +                    depends.append(dep)
>>              if depends and not variant:
>>                  data.setVar("__depends", depends)
>=20
> This one is the hardest to get right. We really need to:
>=20
> * Save off the original __depends
> * Check the returned __depends and compute what was added compared to
> the original __depends value for each variant, then add only these
> additions to the base __depends value.
>=20
>=20
>> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
>> index dea0aad..51341fa 100644
>> --- a/lib/bb/cooker.py
>> +++ b/lib/bb/cooker.py
>> @@ -680,8 +680,10 @@ class BBCooker:
>>          # Generate a list of parsed configuration files by searching th=
e files
>>          # listed in the __depends and __base_depends variables with a .=
conf suffix.
>>          conffiles =3D []
>> -        dep_files =3D self.configuration.data.getVar('__depends') or se=
t()
>> -        dep_files.union(self.configuration.data.getVar('__base_depends'=
) or set())
>> +        dep_files =3D self.configuration.data.getVar('__depends') or []
>> +        for dep in (self.configuration.data.getVar('__base_depends') or=
 []):
>> +            if dep not in dep_files:
>> +                dep_files.append(dep)
>=20
> Here we may as well do:
>=20
>     dep_files =3D set(self.configuration.data.getVar('__depends') or [])
>     dep_files.update(self.configuration.data.getVar('__base_depends') or =
[])
> since order and duplicates don't matter.
>=20
>>          for f in dep_files:
>>              if f[0].endswith(".conf"):
>> diff --git a/lib/bb/parse/__init__.py b/lib/bb/parse/__init__.py
>> index 7b9c47e..f223ff9 100644
>> --- a/lib/bb/parse/__init__.py
>> +++ b/lib/bb/parse/__init__.py
>> @@ -73,8 +73,10 @@ def update_mtime(f):
>>  def mark_dependency(d, f):
>>      if f.startswith('./'):
>>          f =3D "%s/%s" % (os.getcwd(), f[2:])
>> -    deps =3D d.getVar('__depends') or set()
>> -    deps.update([(f, cached_mtime(f))])
>> +    deps =3D d.getVar('__depends') or []
>> +    t =3D cached_mtime(f)
>> +    if (f, t) not in deps:
>> +        deps.append((f, t))
>>      d.setVar('__depends', deps)
>=20
> I think this should be unconditional even if it introduces duplicates so
> that we can know if the file was included more than once:
>=20
>     deps =3D d.getVar('__depends') or []
>     t =3D cached_mtime(f)
>     deps.append((f, t))
>     d.setVar('__depends', deps)
>>  def supports(fn, data): @@ -134,8 +136,10 @@ def vars_from_file(mypkg,
>>  d): def get_file_depends(d):
>>      '''Return the dependent files'''
>>      dep_files =3D []
>> -    depends =3D d.getVar('__depends', True) or set()
>> -    depends =3D depends.union(d.getVar('__base_depends', True) or set()=
)
>> +    depends =3D d.getVar('__depends', True) or []
>> +    for dep in (d.getVar('__base_depends', True) or []):
>> +        if dep not in depends:
>> +            depends.append(dep)
>>      for (fn, _) in depends:
>>          dep_files.append(os.path.abspath(fn))
>>      return " ".join(dep_files)
>=20
> This is the one that really worried me. __base_depends needs to be
> listed before __depends as that was the order used. Again, we shouldn't
> be removing duplicates so:
>=20
>     depends =3D d.getVar('__base_depends', True) or []
>     for dep in (d.getVar('__depends', True) or []):
>         depends.append(dep)
> Also, in cache.py:cacheValidUpdate(), we might as well do something like:
>=20
> -  for f, old_mtime in depends:
> +  for f, old_mtime in set(depends):
>=20
> although this is a micro optimisation. We could do that when the value
> is placed in the cache I guess and reduce cache size too.
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

Best Regards,
Lianhao



