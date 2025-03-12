Return-Path: <c137.marques@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2402C28B28
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 11:27:48 +0000 (UTC)
Subject: Re: [PATCH v3 1/1] hashserv: Add `gc-mark-stream` command for batch hash marking
To: bitbake-devel@lists.openembedded.org
From: "Alexandre Marques" <c137.marques@gmail.com>
X-Originating-Location: Vila Nova de Foz Coa, Guarda, PT (213.205.68.220)
X-Originating-Platform: Linux Firefox 135
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 12 Mar 2025 04:27:39 -0700
References: <20250311163233.452668-1-c137.marques@gmail.com>
In-Reply-To: <20250311163233.452668-1-c137.marques@gmail.com>
Message-ID: <7223.1741778859296436732@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="73MU1HNi1iWdqZEQm55I"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Mar 2025 11:27:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17435

--73MU1HNi1iWdqZEQm55I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 09:32 AM, Alexandre Marques wrote:

>=20
> From: Alexandre Marques <c137.marques@gmail.com>
>=20
> Implements the `gc-mark-stream` command to allow for marking equivalence
> entries
> in batch, by making use of stream mode communication to the server.
>=20
> The aim of this is to improve efficiency by reducing the impact of latenc=
y
> when
> marking a high volume of hash entries.
>=20
> Example usage of the new `gc-mark-stream` command:
>=20
> ```
> $ cat << HASHES | \
> ./bin/bitbake-hashclient --address "ws://localhost:8688/ws" gc-mark-strea=
m
> "alive"
> unihash f37918cc02eb5a520b1aff86faacbc0a38124646
> unihash af36b199320e611fbb16f1f277d3ee1d619ca58b
> taskhash a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c0 method
> oe.sstatesig.OEOuthashBasic
> HASHES
> ```
>=20
> Signed-off-by: Alexander Marques <c137.marques@gmail.com>
> ---
> bin/bitbake-hashclient | 31 +++++++++++++++++++++++++++++++
> lib/hashserv/client.py | 22 ++++++++++++++++++++++
> lib/hashserv/server.py | 29 +++++++++++++++++++++++++++++
> lib/hashserv/tests.py | 42 ++++++++++++++++++++++++++++++++++++++++++
> tmp | 0
> 5 files changed, 124 insertions(+)
> create mode 100644 tmp
>=20
> diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
> index a50701a88..b8755c579 100755
> --- a/bin/bitbake-hashclient
> +++ b/bin/bitbake-hashclient
> @@ -227,6 +227,27 @@ def main():
> print("New hashes marked: %d" % result["count"])
> return 0
>=20
> + def handle_gc_mark_stream(args, client):
> + stdin =3D (l.strip() for l in sys.stdin)
> + marked_hashes =3D 0
> +
> + try:
> + result =3D client.gc_mark_stream(args.mark, stdin)
> + marked_hashes =3D result["count"]
> + except ConnectionError:
> + logger.warning(
> + "Server doesn't seem to support `gc-mark-stream`. Sending "
> + "hashes sequentially using `gc-mark` API."
> + )
> + for line in stdin:
> + pairs =3D line.split()
> + condition =3D dict(zip(pairs[::2], pairs[1::2]))
> + result =3D client.gc_mark(args.mark, condition)
> + marked_hashes +=3D result["count"]
> +
> + print("New hashes marked: %d" % marked_hashes)
> + return 0
> +
> def handle_gc_sweep(args, client):
> result =3D client.gc_sweep(args.mark)
> print("Removed %d rows" % result["count"])
> @@ -366,6 +387,16 @@ def main():
> help=3D"Keep entries in table where KEY =3D=3D VALUE")
> gc_mark_parser.set_defaults(func=3Dhandle_gc_mark)
>=20
> + gc_mark_parser_stream =3D subparsers.add_parser(
> + 'gc-mark-stream',
> + help=3D(
> + "Mark multiple hashes to be retained for garbage collection. Input
> should be provided via stdin, "
> + "with each line formatted as key-value pairs separated by spaces, for
> example 'column1 foo column2 bar'."
> + )
> + )
> + gc_mark_parser_stream.add_argument("mark", help=3D"Mark for this garbag=
e
> collection operation")
> + gc_mark_parser_stream.set_defaults(func=3Dhandle_gc_mark_stream)
> +
> gc_sweep_parser =3D subparsers.add_parser('gc-sweep', help=3D"Perform gar=
bage
> collection and delete any entries that are not marked")
> gc_sweep_parser.add_argument("mark", help=3D"Mark for this garbage
> collection operation")
> gc_sweep_parser.set_defaults(func=3Dhandle_gc_sweep)
> diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
> index a510f3284..8cb18050a 100644
> --- a/lib/hashserv/client.py
> +++ b/lib/hashserv/client.py
> @@ -78,6 +78,7 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
> MODE_NORMAL =3D 0
> MODE_GET_STREAM =3D 1
> MODE_EXIST_STREAM =3D 2
> + MODE_MARK_STREAM =3D 3
>=20
> def __init__(self, username=3DNone, password=3DNone):
> super().__init__("OEHASHEQUIV", "1.1", logger)
> @@ -164,6 +165,8 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
> await normal_to_stream("get-stream")
> elif new_mode =3D=3D self.MODE_EXIST_STREAM:
> await normal_to_stream("exists-stream")
> + elif new_mode =3D=3D self.MODE_MARK_STREAM:
> + await normal_to_stream("gc-mark-stream")
> elif new_mode !=3D self.MODE_NORMAL:
> raise Exception("Undefined mode transition {self.mode!r} -> {new_mode!r}"=
)
>=20
>=20
> @@ -306,6 +309,24 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
> """
> return await self.invoke({"gc-mark": {"mark": mark, "where": where}})
>=20
> + async def gc_mark_stream(self, mark, rows):
> + """
> + Similar to `gc-mark`, but accepts a list of "where" key-value pair
> + conditions. It utilizes stream mode to mark hashes, which helps reduce
> + the impact of latency when communicating with the hash equivalence
> + server.
> + """
> + def row_to_dict(row):
> + pairs =3D row.split()
> + return dict(zip(pairs[::2], pairs[1::2]))
> +
> + responses =3D await self.send_stream_batch(
> + self.MODE_MARK_STREAM,
> + (json.dumps({"mark": mark, "where": row_to_dict(row)}) for row in rows)=
,
>=20
> + )
> +
> + return {"count": sum(int(json.loads(r)["count"]) for r in responses)}
> +
> async def gc_sweep(self, mark):
> """
> Finishes garbage collection for "mark". All unihash entries that have
> @@ -351,6 +372,7 @@ class Client(bb.asyncrpc.Client):
> "get_db_query_columns",
> "gc_status",
> "gc_mark",
> + "gc_mark_stream",
> "gc_sweep",
> )
>=20
> diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> index 68f64f983..58f95c7bc 100644
> --- a/lib/hashserv/server.py
> +++ b/lib/hashserv/server.py
> @@ -10,6 +10,7 @@ import math
> import time
> import os
> import base64
> +import json
> import hashlib
> from . import create_async_client
> import bb.asyncrpc
> @@ -256,6 +257,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection)=
:
>=20
> "backfill-wait": self.handle_backfill_wait,
> "remove": self.handle_remove,
> "gc-mark": self.handle_gc_mark,
> + "gc-mark-stream": self.handle_gc_mark_stream,
> "gc-sweep": self.handle_gc_sweep,
> "gc-status": self.handle_gc_status,
> "clean-unused": self.handle_clean_unused,
> @@ -583,6 +585,33 @@ class
> ServerClient(bb.asyncrpc.AsyncServerConnection):
>=20
> return {"count": await self.db.gc_mark(mark, condition)}
>=20
> + @permissions(DB_ADMIN_PERM)
> + async def handle_gc_mark_stream(self, request):
> + async def handler(line):
> + try:
> + decoded_line =3D json.loads(line)
> + except json.JSONDecodeError as exc:
> + raise bb.asyncrpc.InvokeError(
> + "Could not decode JSONL input '%s'" % line
> + ) from exc
> +
> + try:
> + mark =3D decoded_line["mark"]
> + condition =3D decoded_line["where"]
> + if not isinstance(mark, str):
> + raise TypeError("Bad mark type %s" % type(mark))
> +
> + if not isinstance(condition, dict):
> + raise TypeError("Bad condition type %s" % type(condition))
> + except KeyError as exc:
> + raise bb.asyncrpc.InvokeError(
> + "Input line is missing key '%s' " % exc
> + ) from exc
> +
> + return json.dumps({"count": await self.db.gc_mark(mark, condition)})
> +
> + return await self._stream_handler(handler)
> +
> @permissions(DB_ADMIN_PERM)
> async def handle_gc_sweep(self, request):
> mark =3D request["mark"]
> diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
> index 13ccb20eb..da3f8e088 100644
> --- a/lib/hashserv/tests.py
> +++ b/lib/hashserv/tests.py
> @@ -969,6 +969,48 @@ class HashEquivalenceCommonTests(object):
> # First hash is still present
> self.assertClientGetHash(self.client, taskhash, unihash)
>=20
> + def test_gc_stream(self):
> + taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
> + outhash =3D
> '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
> + unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'
> +
> + result =3D self.client.report_unihash(taskhash, self.METHOD, outhash,
> unihash)
> + self.assertEqual(result['unihash'], unihash, 'Server returned bad
> unihash')
> +
> + taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
> + outhash2 =3D
> '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
> + unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
> +
> + result =3D self.client.report_unihash(taskhash2, self.METHOD, outhash2,
> unihash2)
> + self.assertClientGetHash(self.client, taskhash2, unihash2)
> +
> + taskhash3 =3D 'a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c0'
> + outhash3 =3D
> '7289c414905303700a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c04f9a53c'
> + unihash3 =3D '905303700a1117c1f5a7c9ab2f5a39cc6fe5e615'
> +
> + result =3D self.client.report_unihash(taskhash3, self.METHOD, outhash3,
> unihash3)
> + self.assertClientGetHash(self.client, taskhash3, unihash3)
> +
> + # Mark the first unihash to be kept
> + ret =3D self.client.gc_mark_stream("ABC", (f"unihash {h}" for h in
> [unihash, unihash2]))
> + self.assertEqual(ret, {"count": 2})
> +
> + ret =3D self.client.gc_status()
> + self.assertEqual(ret, {"mark": "ABC", "keep": 2, "remove": 1})
> +
> + # Third hash is still there; mark doesn't delete hashes
> + self.assertClientGetHash(self.client, taskhash3, unihash3)
> +
> + ret =3D self.client.gc_sweep("ABC")
> + self.assertEqual(ret, {"count": 1})
> +
> + # Hash is gone. Taskhash is returned for second hash
> + self.assertClientGetHash(self.client, taskhash3, None)
> + # First hash is still present
> + self.assertClientGetHash(self.client, taskhash, unihash)
> + # Second hash is still present
> + self.assertClientGetHash(self.client, taskhash2, unihash2)
> +
> def test_gc_switch_mark(self):
> taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
> outhash =3D
> '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'

Pushed an empty tmp file by mistake.
>=20
> diff --git a/tmp b/tmp
> new file mode 100644
> index 000000000..e69de29bb
> --
> 2.34.1

--73MU1HNi1iWdqZEQm55I
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<div>On Tue, Mar 11, 2025 at 09:32 AM, Alexandre Marques wrote:</div>
<div>
<blockquote>From: Alexandre Marques &lt;c137.marques@gmail.com&gt;<br /><br=
 />Implements the `gc-mark-stream` command to allow for marking equivalence=
 entries<br />in batch, by making use of stream mode communication to the s=
erver.<br /><br />The aim of this is to improve efficiency by reducing the =
impact of latency when<br />marking a high volume of hash entries.<br /><br=
 />Example usage of the new `gc-mark-stream` command:<br /><br />```<br />$=
 cat &lt;&lt; HASHES | \<br />./bin/bitbake-hashclient --address "ws://loca=
lhost:8688/ws" gc-mark-stream "alive"<br />unihash f37918cc02eb5a520b1aff86=
faacbc0a38124646<br />unihash af36b199320e611fbb16f1f277d3ee1d619ca58b<br /=
>taskhash a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c0 method oe.sstatesig.OEOu=
thashBasic<br />HASHES<br />```<br /><br />Signed-off-by: Alexander Marques=
 &lt;c137.marques@gmail.com&gt;<br />---<br />bin/bitbake-hashclient | 31 +=
++++++++++++++++++++++++++++++<br />lib/hashserv/client.py | 22 +++++++++++=
+++++++++++<br />lib/hashserv/server.py | 29 +++++++++++++++++++++++++++++<=
br />lib/hashserv/tests.py | 42 ++++++++++++++++++++++++++++++++++++++++++<=
br />tmp | 0<br />5 files changed, 124 insertions(+)<br />create mode 10064=
4 tmp<br /><br />diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclie=
nt<br />index a50701a88..b8755c579 100755<br />--- a/bin/bitbake-hashclient=
<br />+++ b/bin/bitbake-hashclient<br />@@ -227,6 +227,27 @@ def main():<br=
 />print("New hashes marked: %d" % result["count"])<br />return 0<br /><br =
/>+ def handle_gc_mark_stream(args, client):<br />+ stdin =3D (l.strip() fo=
r l in sys.stdin)<br />+ marked_hashes =3D 0<br />+<br />+ try:<br />+ resu=
lt =3D client.gc_mark_stream(args.mark, stdin)<br />+ marked_hashes =3D res=
ult["count"]<br />+ except ConnectionError:<br />+ logger.warning(<br />+ "=
Server doesn't seem to support `gc-mark-stream`. Sending "<br />+ "hashes s=
equentially using `gc-mark` API."<br />+ )<br />+ for line in stdin:<br />+=
 pairs =3D line.split()<br />+ condition =3D dict(zip(pairs[::2], pairs[1::=
2]))<br />+ result =3D client.gc_mark(args.mark, condition)<br />+ marked_h=
ashes +=3D result["count"]<br />+<br />+ print("New hashes marked: %d" % ma=
rked_hashes)<br />+ return 0<br />+<br />def handle_gc_sweep(args, client):=
<br />result =3D client.gc_sweep(args.mark)<br />print("Removed %d rows" % =
result["count"])<br />@@ -366,6 +387,16 @@ def main():<br />help=3D"Keep en=
tries in table where KEY =3D=3D VALUE")<br />gc_mark_parser.set_defaults(fu=
nc=3Dhandle_gc_mark)<br /><br />+ gc_mark_parser_stream =3D subparsers.add_=
parser(<br />+ 'gc-mark-stream',<br />+ help=3D(<br />+ "Mark multiple hash=
es to be retained for garbage collection. Input should be provided via stdi=
n, "<br />+ "with each line formatted as key-value pairs separated by space=
s, for example 'column1 foo column2 bar'."<br />+ )<br />+ )<br />+ gc_mark=
_parser_stream.add_argument("mark", help=3D"Mark for this garbage collectio=
n operation")<br />+ gc_mark_parser_stream.set_defaults(func=3Dhandle_gc_ma=
rk_stream)<br />+<br />gc_sweep_parser =3D subparsers.add_parser('gc-sweep'=
, help=3D"Perform garbage collection and delete any entries that are not ma=
rked")<br />gc_sweep_parser.add_argument("mark", help=3D"Mark for this garb=
age collection operation")<br />gc_sweep_parser.set_defaults(func=3Dhandle_=
gc_sweep)<br />diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py=
<br />index a510f3284..8cb18050a 100644<br />--- a/lib/hashserv/client.py<b=
r />+++ b/lib/hashserv/client.py<br />@@ -78,6 +78,7 @@ class AsyncClient(b=
b.asyncrpc.AsyncClient):<br />MODE_NORMAL =3D 0<br />MODE_GET_STREAM =3D 1<=
br />MODE_EXIST_STREAM =3D 2<br />+ MODE_MARK_STREAM =3D 3<br /><br />def _=
_init__(self, username=3DNone, password=3DNone):<br />super().__init__("OEH=
ASHEQUIV", "1.1", logger)<br />@@ -164,6 +165,8 @@ class AsyncClient(bb.asy=
ncrpc.AsyncClient):<br />await normal_to_stream("get-stream")<br />elif new=
_mode =3D=3D self.MODE_EXIST_STREAM:<br />await normal_to_stream("exists-st=
ream")<br />+ elif new_mode =3D=3D self.MODE_MARK_STREAM:<br />+ await norm=
al_to_stream("gc-mark-stream")<br />elif new_mode !=3D self.MODE_NORMAL:<br=
 />raise Exception("Undefined mode transition {self.mode!r} -&gt; {new_mode=
!r}")<br /><br />@@ -306,6 +309,24 @@ class AsyncClient(bb.asyncrpc.AsyncCl=
ient):<br />"""<br />return await self.invoke({"gc-mark": {"mark": mark, "w=
here": where}})<br /><br />+ async def gc_mark_stream(self, mark, rows):<br=
 />+ """<br />+ Similar to `gc-mark`, but accepts a list of "where" key-val=
ue pair<br />+ conditions. It utilizes stream mode to mark hashes, which he=
lps reduce<br />+ the impact of latency when communicating with the hash eq=
uivalence<br />+ server.<br />+ """<br />+ def row_to_dict(row):<br />+ pai=
rs =3D row.split()<br />+ return dict(zip(pairs[::2], pairs[1::2]))<br />+<=
br />+ responses =3D await self.send_stream_batch(<br />+ self.MODE_MARK_ST=
REAM,<br />+ (json.dumps({"mark": mark, "where": row_to_dict(row)}) for row=
 in rows),<br />+ )<br />+<br />+ return {"count": sum(int(json.loads(r)["c=
ount"]) for r in responses)}<br />+<br />async def gc_sweep(self, mark):<br=
 />"""<br />Finishes garbage collection for "mark". All unihash entries tha=
t have<br />@@ -351,6 +372,7 @@ class Client(bb.asyncrpc.Client):<br />"get=
_db_query_columns",<br />"gc_status",<br />"gc_mark",<br />+ "gc_mark_strea=
m",<br />"gc_sweep",<br />)<br /><br />diff --git a/lib/hashserv/server.py =
b/lib/hashserv/server.py<br />index 68f64f983..58f95c7bc 100644<br />--- a/=
lib/hashserv/server.py<br />+++ b/lib/hashserv/server.py<br />@@ -10,6 +10,=
7 @@ import math<br />import time<br />import os<br />import base64<br />+i=
mport json<br />import hashlib<br />from . import create_async_client<br />=
import bb.asyncrpc<br />@@ -256,6 +257,7 @@ class ServerClient(bb.asyncrpc.=
AsyncServerConnection):<br />"backfill-wait": self.handle_backfill_wait,<br=
 />"remove": self.handle_remove,<br />"gc-mark": self.handle_gc_mark,<br />=
+ "gc-mark-stream": self.handle_gc_mark_stream,<br />"gc-sweep": self.handl=
e_gc_sweep,<br />"gc-status": self.handle_gc_status,<br />"clean-unused": s=
elf.handle_clean_unused,<br />@@ -583,6 +585,33 @@ class ServerClient(bb.as=
yncrpc.AsyncServerConnection):<br /><br />return {"count": await self.db.gc=
_mark(mark, condition)}<br /><br />+ @permissions(DB_ADMIN_PERM)<br />+ asy=
nc def handle_gc_mark_stream(self, request):<br />+ async def handler(line)=
:<br />+ try:<br />+ decoded_line =3D json.loads(line)<br />+ except json.J=
SONDecodeError as exc:<br />+ raise bb.asyncrpc.InvokeError(<br />+ "Could =
not decode JSONL input '%s'" % line<br />+ ) from exc<br />+<br />+ try:<br=
 />+ mark =3D decoded_line["mark"]<br />+ condition =3D decoded_line["where=
"]<br />+ if not isinstance(mark, str):<br />+ raise TypeError("Bad mark ty=
pe %s" % type(mark))<br />+<br />+ if not isinstance(condition, dict):<br /=
>+ raise TypeError("Bad condition type %s" % type(condition))<br />+ except=
 KeyError as exc:<br />+ raise bb.asyncrpc.InvokeError(<br />+ "Input line =
is missing key '%s' " % exc<br />+ ) from exc<br />+<br />+ return json.dum=
ps({"count": await self.db.gc_mark(mark, condition)})<br />+<br />+ return =
await self._stream_handler(handler)<br />+<br />@permissions(DB_ADMIN_PERM)=
<br />async def handle_gc_sweep(self, request):<br />mark =3D request["mark=
"]<br />diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py<br />ind=
ex 13ccb20eb..da3f8e088 100644<br />--- a/lib/hashserv/tests.py<br />+++ b/=
lib/hashserv/tests.py<br />@@ -969,6 +969,48 @@ class HashEquivalenceCommon=
Tests(object):<br /># First hash is still present<br />self.assertClientGet=
Hash(self.client, taskhash, unihash)<br /><br />+ def test_gc_stream(self):=
<br />+ taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'<br />+ outh=
ash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'<=
br />+ unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'<br />+<br />+=
 result =3D self.client.report_unihash(taskhash, self.METHOD, outhash, unih=
ash)<br />+ self.assertEqual(result['unihash'], unihash, 'Server returned b=
ad unihash')<br />+<br />+ taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf7=
3afe6b4'<br />+ outhash2 =3D '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f25=
3c5360e136b852967b4'<br />+ unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d6=
19ca58b'<br />+<br />+ result =3D self.client.report_unihash(taskhash2, sel=
f.METHOD, outhash2, unihash2)<br />+ self.assertClientGetHash(self.client, =
taskhash2, unihash2)<br />+<br />+ taskhash3 =3D 'a1117c1f5a7c9ab2f5a39cc6f=
e5e6152169d09c0'<br />+ outhash3 =3D '7289c414905303700a1117c1f5a7c9ab2f5a3=
9cc6fe5e6152169d09c04f9a53c'<br />+ unihash3 =3D '905303700a1117c1f5a7c9ab2=
f5a39cc6fe5e615'<br />+<br />+ result =3D self.client.report_unihash(taskha=
sh3, self.METHOD, outhash3, unihash3)<br />+ self.assertClientGetHash(self.=
client, taskhash3, unihash3)<br />+<br />+ # Mark the first unihash to be k=
ept<br />+ ret =3D self.client.gc_mark_stream("ABC", (f"unihash {h}" for h =
in [unihash, unihash2]))<br />+ self.assertEqual(ret, {"count": 2})<br />+<=
br />+ ret =3D self.client.gc_status()<br />+ self.assertEqual(ret, {"mark"=
: "ABC", "keep": 2, "remove": 1})<br />+<br />+ # Third hash is still there=
; mark doesn't delete hashes<br />+ self.assertClientGetHash(self.client, t=
askhash3, unihash3)<br />+<br />+ ret =3D self.client.gc_sweep("ABC")<br />=
+ self.assertEqual(ret, {"count": 1})<br />+<br />+ # Hash is gone. Taskhas=
h is returned for second hash<br />+ self.assertClientGetHash(self.client, =
taskhash3, None)<br />+ # First hash is still present<br />+ self.assertCli=
entGetHash(self.client, taskhash, unihash)<br />+ # Second hash is still pr=
esent<br />+ self.assertClientGetHash(self.client, taskhash2, unihash2)<br =
/>+<br />def test_gc_switch_mark(self):<br />taskhash =3D '53b8dce672cb6d0c=
73170be43f540460bfc347b4'<br />outhash =3D '5a9cb1649625f0bf41fc7791b635cd9=
c2d7118c7f021ba87dcd03f72b67ce7a8'</blockquote>
Pushed an empty tmp file by mistake.
<blockquote>diff --git a/tmp b/tmp<br />new file mode 100644<br />index 000=
000000..e69de29bb<br />-- <br />2.34.1</blockquote>
</div>

--73MU1HNi1iWdqZEQm55I--

