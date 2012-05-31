Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]
	helo=tx2outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1SZtiw-0002ZK-VH
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 May 2012 02:58:47 +0200
Received: from mail89-tx2-R.bigfish.com (10.9.14.244) by
	TX2EHSOBE006.bigfish.com (10.9.40.26) with Microsoft SMTP Server id
	14.1.225.23; Thu, 31 May 2012 00:32:54 +0000
Received: from mail89-tx2 (localhost [127.0.0.1])	by mail89-tx2-R.bigfish.com
	(Postfix) with ESMTP id E58024401E7;
	Thu, 31 May 2012 00:32:53 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: -9
X-BigFish: VS-9(zz9371I1432N98dKzz1202hzz8275bh8275dhz2dh2a8h668h839h8e2h8e3hf0ahbe9i)
Received: from mail89-tx2 (localhost.localdomain [127.0.0.1]) by mail89-tx2
	(MessageSwitch) id 1338424372366984_18073;
	Thu, 31 May 2012 00:32:52 +0000 (UTC)
Received: from TX2EHSMHS014.bigfish.com (unknown [10.9.14.241])	by
	mail89-tx2.bigfish.com (Postfix) with ESMTP id 4CA26C0046;
	Thu, 31 May 2012 00:32:52 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by TX2EHSMHS014.bigfish.com
	(10.9.99.114) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Thu, 31 May 2012 00:32:52 +0000
Received: from 039-SN1MPN1-001.039d.mgd.msft.net ([169.254.1.135]) by
	039-SN1MMR1-003.039d.mgd.msft.net ([10.84.1.16]) with mapi id
	14.02.0298.005; Wed, 30 May 2012 19:33:17 -0500
From: McClintock Matthew-B29882 <B29882@freescale.com>
To: Lianhao Lu <lianhao.lu@intel.com>
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake/persist_data: Reconnect
	when DB is locked
Thread-Index: AQHNPsT4hbuVg22/eUC94wQYHGCpiw==
Date: Thu, 31 May 2012 00:33:17 +0000
Message-ID: <CAEsOVNeBNFH6KbbCUHqEhEjx0dGwzeZ2qCiRc6UirbE_X=1yfQ@mail.gmail.com>
References: <cover.1326686612.git.lianhao.lu@intel.com>
	<554ae4c9ee0ac70254c6ca6a5ba44db844cf86b3.1326686612.git.lianhao.lu@intel.com>
In-Reply-To: <554ae4c9ee0ac70254c6ca6a5ba44db844cf86b3.1326686612.git.lianhao.lu@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.112.201.132]
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] bitbake/persist_data: Reconnect when DB is locked
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
Reply-To: McClintock Matthew-B29882 <B29882@freescale.com>
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 31 May 2012 00:58:47 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <ABF7BA3409F5F84E8F083652475D42D4@mgd.freescale.com>
Content-Transfer-Encoding: quoted-printable

This needs to be in edison-next. It cherry-pick's cleanly as an added
plus (doing more testing now). Seems like it's already in denzil-next

-M

On Sun, Jan 15, 2012 at 10:07 PM, Lianhao Lu <lianhao.lu@intel.com> wrote:
> [YOCTO #1761]
> Reconnect to the backend Sqlite DB in 'database is locked' exception so
> the timeout can be leveraged in each time retry.
>
> Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
> ---
> =A0bitbake/lib/bb/persist_data.py | =A0 12 +++++++-----
> =A01 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data=
.py
> index 17620ef..c4ea23b 100644
> --- a/bitbake/lib/bb/persist_data.py
> +++ b/bitbake/lib/bb/persist_data.py
> @@ -47,9 +47,10 @@ if hasattr(sqlite3, 'enable_shared_cache'):
> =A0@total_ordering
> =A0class SQLTable(collections.MutableMapping):
> =A0 =A0 """Object representing a table/domain in the database"""
> - =A0 =A0def __init__(self, cursor, table):
> - =A0 =A0 =A0 =A0self.cursor =3D cursor
> + =A0 =A0def __init__(self, cachefile, table):
> + =A0 =A0 =A0 =A0self.cachefile =3D cachefile
> =A0 =A0 =A0 =A0 self.table =3D table
> + =A0 =A0 =A0 =A0self.cursor =3D connect(self.cachefile)
>
> =A0 =A0 =A0 =A0 self._execute("CREATE TABLE IF NOT EXISTS %s(key TEXT, va=
lue TEXT);"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 % table)
> @@ -63,6 +64,8 @@ class SQLTable(collections.MutableMapping):
> =A0 =A0 =A0 =A0 =A0 =A0 except sqlite3.OperationalError as exc:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if 'database is locked' in str(exc) and c=
ount < 500:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D count + 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.cursor.close()
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0self.cursor =3D connect(self.cac=
hefile)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 raise
>
> @@ -188,7 +191,7 @@ class PersistData(object):
> =A0 =A0 =A0 =A0 del self.data[domain][key]
>
> =A0def connect(database):
> - =A0 =A0return sqlite3.connect(database, timeout=3D30, isolation_level=
=3DNone)
> + =A0 =A0return sqlite3.connect(database, timeout=3D5, isolation_level=3D=
None)
>
> =A0def persist(domain, d):
> =A0 =A0 """Convenience factory for SQLTable objects based upon metadata""=
"
> @@ -201,5 +204,4 @@ def persist(domain, d):
>
> =A0 =A0 bb.utils.mkdirhier(cachedir)
> =A0 =A0 cachefile =3D os.path.join(cachedir, "bb_persist_data.sqlite3")
> - =A0 =A0connection =3D connect(cachefile)
> - =A0 =A0return SQLTable(connection, domain)
> + =A0 =A0return SQLTable(cachefile, domain)
> --
> 1.7.0.4
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel=



