Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1RmdLg-0006W9-Rb
	for bitbake-devel@lists.openembedded.org;
	Mon, 16 Jan 2012 04:35:09 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 15 Jan 2012 19:27:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="56759240"
Received: from pgsmsx601.gar.corp.intel.com ([10.221.43.69])
	by AZSMGA002.ch.intel.com with ESMTP; 15 Jan 2012 19:27:30 -0800
Received: from pgsmsx509.gar.corp.intel.com (172.30.13.17) by
	pgsmsx601.gar.corp.intel.com (10.221.43.69) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 16 Jan 2012 11:27:02 +0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	PGSMSX509.gar.corp.intel.com (172.30.13.17) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 16 Jan 2012 11:27:02 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.88]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.223]) with mapi id
	14.01.0355.002; Mon, 16 Jan 2012 11:27:00 +0800
From: "Lu, Lianhao" <lianhao.lu@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 1/9] cache: Use configuration's hash
	value	to validate cache
Thread-Index: AQHM0c2Dc1JFVYOSjUeTOXAdIV0RX5YOWKPg
Date: Mon, 16 Jan 2012 03:27:00 +0000
Message-ID: <857BE142E5399E46B20FD45B9DB8A7BC0FCA92DC@SHSMSX102.ccr.corp.intel.com>
References: <cover.1326442655.git.dongxiao.xu@intel.com>
	<a31c35deb05708090c2c51c7106efd67ba828a54.1326442655.git.dongxiao.xu@intel.com>
In-Reply-To: <a31c35deb05708090c2c51c7106efd67ba828a54.1326442655.git.dongxiao.xu@intel.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 1/9] cache: Use configuration's hash value	to validate cache
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
X-List-Received-Date: Mon, 16 Jan 2012 03:35:09 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Is it possbile to add a "force-reparse" option to bitbake, since some scrip=
ts are using the conf file time stamp to retrigger the parsing now?

Best Regards,
Lianhao

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-=
bounces@lists.openembedded.org] On Behalf Of Dongxiao
> Xu
> Sent: Friday, January 13, 2012 4:31 PM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/9] cache: Use configuration's hash valu=
e to validate cache
>=20
> Previously we use the file time stamp to judge if a cache is valid.
> Here this commit introduce a new method, which calculates the total
> hash value for a certain configuration's key/value paris, and tag
> it into cache filename, for example, bb_cache.dat.xxxyyyzzz.
>=20
> This mechanism also ensures the cache's correctness if user
> dynamically setting variables from some frontend GUI, like HOB.
>=20
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/cache.py      |   32 ++++++++++++--------------------
>  lib/bb/cooker.py     |    4 +++-
>  lib/bb/data_smart.py |   21 +++++++++++++++++++++
>  3 files changed, 36 insertions(+), 21 deletions(-)
>=20
> diff --git a/lib/bb/cache.py b/lib/bb/cache.py
> index 6b7fa6f..955b6df 100644
> --- a/lib/bb/cache.py
> +++ b/lib/bb/cache.py
> @@ -42,10 +42,10 @@ except ImportError:
>      logger.info("Importing cPickle failed. "
>                  "Falling back to a very slow implementation.")
>=20
> -__cache_version__ =3D "142"
> +__cache_version__ =3D "143"
>=20
> -def getCacheFile(path, filename):
> -    return os.path.join(path, filename)
> +def getCacheFile(path, filename, data_hash):
> +    return os.path.join(path, filename + "." + data_hash)
>=20
>  # RecipeInfoCommon defines common data retrieving methods
>  # from meta data for caches. CoreRecipeInfo as well as other
> @@ -254,7 +254,7 @@ class Cache(object):
>      BitBake Cache implementation
>      """
>=20
> -    def __init__(self, data, caches_array):
> +    def __init__(self, data, data_hash, caches_array):
>          # Pass caches_array information into Cache Constructor
>          # It will be used in later for deciding whether we
>          # need extra cache file dump/load support
> @@ -266,6 +266,7 @@ class Cache(object):
>          self.data =3D None
>          self.data_fn =3D None
>          self.cacheclean =3D True
> +        self.data_hash =3D data_hash
>=20
>          if self.cachedir in [None, '']:
>              self.has_cache =3D False
> @@ -274,26 +275,17 @@ class Cache(object):
>              return
>=20
>          self.has_cache =3D True
> -        self.cachefile =3D getCacheFile(self.cachedir, "bb_cache.dat")
> +        self.cachefile =3D getCacheFile(self.cachedir, "bb_cache.dat", s=
elf.data_hash)
>=20
>          logger.debug(1, "Using cache in '%s'", self.cachedir)
>          bb.utils.mkdirhier(self.cachedir)
>=20
> -        # If any of configuration.data's dependencies are newer than the
> -        # cache there isn't even any point in loading it...
> -        newest_mtime =3D 0
> -        deps =3D data.getVar("__base_depends")
> -
> -        old_mtimes =3D [old_mtime for _, old_mtime in deps]
> -        old_mtimes.append(newest_mtime)
> -        newest_mtime =3D max(old_mtimes)
> -
>          cache_ok =3D True
>          if self.caches_array:
>              for cache_class in self.caches_array:
>                  if type(cache_class) is type and issubclass(cache_class,=
 RecipeInfoCommon):
> -                    cachefile =3D getCacheFile(self.cachedir, cache_clas=
s.cachefile)
> -                    cache_ok =3D cache_ok and (bb.parse.cached_mtime_noe=
rror(cachefile) >=3D newest_mtime)
> +                    cachefile =3D getCacheFile(self.cachedir, cache_clas=
s.cachefile, self.data_hash)
> +                    cache_ok =3D cache_ok and os.path.exists(cachefile)
>                      cache_class.init_cacheData(self)
>          if cache_ok:
>              self.load_cachefile()
> @@ -327,7 +319,7 @@ class Cache(object):
>          # Calculate the correct cachesize of all those cache files
>          for cache_class in self.caches_array:
>              if type(cache_class) is type and issubclass(cache_class, Rec=
ipeInfoCommon):
> -                cachefile =3D getCacheFile(self.cachedir, cache_class.ca=
chefile)
> +                cachefile =3D getCacheFile(self.cachedir, cache_class.ca=
chefile, self.data_hash)
>                  with open(cachefile, "rb") as cachefile:
>                      cachesize +=3D os.fstat(cachefile.fileno()).st_size
>=20
> @@ -335,7 +327,7 @@ class Cache(object):
>=20
>          for cache_class in self.caches_array:
>              if type(cache_class) is type and issubclass(cache_class, Rec=
ipeInfoCommon):
> -                cachefile =3D getCacheFile(self.cachedir, cache_class.ca=
chefile)
> +                cachefile =3D getCacheFile(self.cachedir, cache_class.ca=
chefile, self.data_hash)
>                  with open(cachefile, "rb") as cachefile:
>                      pickled =3D pickle.Unpickler(cachefile)
>                      while cachefile:
> @@ -588,7 +580,7 @@ class Cache(object):
>          for cache_class in self.caches_array:
>              if type(cache_class) is type and issubclass(cache_class, Rec=
ipeInfoCommon):
>                  cache_class_name =3D cache_class.__name__
> -                cachefile =3D getCacheFile(self.cachedir, cache_class.ca=
chefile)
> +                cachefile =3D getCacheFile(self.cachedir, cache_class.ca=
chefile, self.data_hash)
>                  file_dict[cache_class_name] =3D open(cachefile, "wb")
>                  pickler_dict[cache_class_name] =3D  pickle.Pickler(file_=
dict[cache_class_name], pickle.HIGHEST_PROTOCOL)
>=20
> @@ -693,7 +685,7 @@ def init(cooker):
>      Files causing parsing errors are evicted from the cache.
>=20
>      """
> -    return Cache(cooker.configuration.data)
> +    return Cache(cooker.configuration.data, cooker.configuration.data_ha=
sh)
>=20
>=20
>  class CacheData(object):
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 194046e..403aa88 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -858,6 +858,7 @@ class BBCooker:
>          bb.parse.init_parser(data)
>          bb.event.fire(bb.event.ConfigParsed(), data)
>          self.configuration.data =3D data
> +        self.configuration.data_hash =3D data.get_hash()
>=20
>      def handleCollections( self, collections ):
>          """Handle collections"""
> @@ -1431,6 +1432,7 @@ class CookerParser(object):
>          self.filelist =3D filelist
>          self.cooker =3D cooker
>          self.cfgdata =3D cooker.configuration.data
> +        self.cfghash =3D cooker.configuration.data_hash
>=20
>          # Accounting statistics
>          self.parsed =3D 0
> @@ -1446,7 +1448,7 @@ class CookerParser(object):
>          self.num_processes =3D int(self.cfgdata.getVar("BB_NUMBER_PARSE_=
THREADS", True) or
>                                   multiprocessing.cpu_count())
>=20
> -        self.bb_cache =3D bb.cache.Cache(self.cfgdata, cooker.caches_arr=
ay)
> +        self.bb_cache =3D bb.cache.Cache(self.cfgdata, self.cfghash, coo=
ker.caches_array)
>          self.fromcache =3D []
>          self.willparse =3D []
>          for filename in self.filelist:
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index ea13478..9864034 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -31,6 +31,7 @@ BitBake build tools.
>  import copy, re
>  from collections import MutableMapping
>  import logging
> +import hashlib
>  import bb, bb.codeparser
>  from bb   import utils
>  from bb.COW  import COWDictBase
> @@ -459,3 +460,23 @@ class DataSmart(MutableMapping):
>=20
>      def __delitem__(self, var):
>          self.delVar(var)
> +
> +    def get_hash(self):
> +        data =3D ""
> +        keys =3D iter(self)
> +        for key in keys:
> +            if key =3D=3D "TIME":
> +                continue
> +            if key =3D=3D "__depends":
> +                deps =3D list(self.getVar(key, False))
> +                deps.sort()
> +                value =3D [deps[i][0] for i in range(len(deps))]
> +            elif key =3D=3D "PATH":
> +                path =3D list(set(self.getVar(key, False).split(':')))
> +                path.sort()
> +                value =3D " ".join(path)
> +            else:
> +                value =3D self.getVar(key, False) or ""
> +            data =3D data + key + ': ' + str(value) + '\n'
> +
> +        return hashlib.md5(data).hexdigest()
> --
> 1.7.0.4
>=20
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


