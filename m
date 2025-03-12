Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2282EC28B28
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 14:35:30 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web11.38802.1741790124089544109
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Mar 2025 07:35:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=edxBNy+U;
 spf=pass (domain: gmail.com, ip: 209.85.167.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-549644ae382so8067127e87.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Mar 2025 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741790122; x=1742394922; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGN7omUPJYS4KKnnbDoJFqZ2nyCXjHkqYfLE+sZ6lLk=;
        b=edxBNy+UEEombDxNLOoxkazb9HinD1f0k8sqaQ8SCzOpnt/GGMNk2jyEQMBCVXIb0o
         TUu6ck8UhaCnKEZ+EZSZMBQbFn/xRe4+UrC0wLghF1L1vAA3siFelcgqMmfOmL7NdWwL
         W7bVDjn69BjqXH7ug5OOyB8eJKsuFyVDOBYz7WUX/VUR4OFyGIASm031B3VZf62hzSrK
         jdvVbFBr075i2UIVtcf18jxOcAYDAOh9t3D+6lReofqbm88Fx9F0V7Cmyu8SUGyqXI/Z
         tABxIDLT25sVTFU8OfVrAjpZeNEh1lbuK/+NichwyO0erP4/yHdp56tK0EoLbGs+EhU5
         KUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741790122; x=1742394922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGN7omUPJYS4KKnnbDoJFqZ2nyCXjHkqYfLE+sZ6lLk=;
        b=AO1RKSTqYsGqH9uW0b9zFVPLB2JL5/9VaNxZMGwNAunS+FbA70YmXqN5No4ytDQaNk
         VuBFoBfJRYX/5KSGGmNkhkm/p5USlN5Fn9kkOVa/bZiYYjRgoG9bVxDMWE54epHF53b3
         3UJYZn52ZXz9kuO7lOxJVLETiqihfG7FKwH3DLldOXgQqacqQ2P/6wbR2oVZFsy4QbqU
         TciaWK8zL6+jC51Dnc7ew5+4vlNAowioABiYWkWg+tlVxkf+wGWtvI1C/oygbxMI6Zd6
         aiLSw5OOhFJwauGKiaA5wmLs7QUODyP4L0/lZiFqQXsZynG6WJpJHBcsyibS63ZjRiR0
         Dj8w==
X-Gm-Message-State: AOJu0YwjAbWIw/roPOl9q8F4v3ZC/hTWWDRkqowcJraS6s8r15+jc4/7
	sxtMjx9TVmK9SEaGU+ezMlIdRBY4ufrzzEI+U945ECzPEMzQB2Hs9jNYDoteIhH0nDjSB2Wp3Wx
	P1AKreZsJYm3wFOI8eBb54GXnAAOwQQ==
X-Gm-Gg: ASbGnctr9Oy5aTCQ5DHUtEJQH8NhpK47xi2coZxzGHgKrrD7lHup8ughLYC9vT0EgZj
	OX3i07XxEOb4W+YwUAyyiJ2Mt9czI1s6dI3Icm8q4ZqkDBHujaSYny994hGMG91IJpOOyqU4Yv0
	dtlLlmjbdk5xSveiw0bU7zvCyuQg==
X-Google-Smtp-Source: AGHT+IGUGEkTYbVzPRl26CesIRGDPTRVqtjca2h4HjTOL7mRNhWGvgOlZeNBIm8YXlNIEHEERiuXN1kN6CbRxEmOBQU=
X-Received: by 2002:a05:6512:39d4:b0:542:91a5:2478 with SMTP id
 2adb3069b0e04-54990ead684mr8377508e87.32.1741790121928; Wed, 12 Mar 2025
 07:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250310140118.2649050-1-alexandre.marques@ctw.bmwgroup.com> <20250310140118.2649050-2-alexandre.marques@ctw.bmwgroup.com>
In-Reply-To: <20250310140118.2649050-2-alexandre.marques@ctw.bmwgroup.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Wed, 12 Mar 2025 08:35:08 -0600
X-Gm-Features: AQ5f1Jq1vhkhHrGB1dm6OWbzg_POzMw6gxCHn_k-fVJgFxc2S0hHA1TBmiw4nLM
Message-ID: <CAJdd5Gbr65WAA2DcNZW_JhSyaU=aPJUDVX2PgghF1mOPtnn0jQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/1] hashserv: Add `gc-mark-stream`
 command for batch hash marking
To: c137.marques@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexandre Marques <alexandre.marques@ctw.bmwgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Mar 2025 14:35:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17436

LGTM, thanks.

Reviewed-by: Joshua Watt <JPEWhacker@gmail.com>

On Mon, Mar 10, 2025 at 8:02=E2=80=AFAM Alexandre Marques via
lists.openembedded.org <c137.marques=3Dgmail.com@lists.openembedded.org>
wrote:
>
> Implements the `gc-mark-stream` command to allow for marking equivalence =
entries
> in batch, by  making use of stream mode communication to the server.
>
> The aim of this is to improve efficiency by reducing the impact of latenc=
y when
> marking a high volume of hash entries.
>
> Example usage of the new `gc-mark-stream` command:
>
> ```
> $ cat << HASHES | \
> ./bin/bitbake-hashclient --address "ws://localhost:8688/ws" gc-mark-strea=
m "alive"
> unihash f37918cc02eb5a520b1aff86faacbc0a38124646
> unihash af36b199320e611fbb16f1f277d3ee1d619ca58b
> taskhash a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c0 method oe.sstatesig.OEO=
uthashBasic
> HASHES
> ```
> ---
>  bin/bitbake-hashclient | 30 ++++++++++++++++++++++++++++++
>  lib/hashserv/client.py | 22 ++++++++++++++++++++++
>  lib/hashserv/server.py | 29 +++++++++++++++++++++++++++++
>  lib/hashserv/tests.py  | 42 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 123 insertions(+)
>
> diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
> index 610787ed2..4ce3c9540 100755
> --- a/bin/bitbake-hashclient
> +++ b/bin/bitbake-hashclient
> @@ -212,6 +212,26 @@ def main():
>          print("New hashes marked: %d" % result["count"])
>          return 0
>
> +    def handle_gc_mark_stream(args, client):
> +        stdin =3D (l.strip() for l in sys.stdin)
> +        marked_hashes =3D 0
> +
> +        try:
> +            result =3D client.gc_mark_stream(args.mark, stdin)
> +            marked_hashes =3D result["count"]
> +        except ConnectionError:
> +            logger.warning(
> +                "Server doesn't seem to support `gc-mark-stream`. Sendin=
g "
> +                "hashes sequentially using `gc-mark` API."
> +            )
> +            for line in stdin:
> +                db_column, hash =3D line.split()
> +                result =3D client.gc_mark(args.mark, {db_column: hash})
> +                marked_hashes +=3D result["count"]
> +
> +        print("New hashes marked: %d" % marked_hashes)
> +        return 0
> +
>      def handle_gc_sweep(args, client):
>          result =3D client.gc_sweep(args.mark)
>          print("Removed %d rows" % result["count"])
> @@ -313,6 +333,16 @@ def main():
>                               help=3D"Keep entries in table where KEY =3D=
=3D VALUE")
>      gc_mark_parser.set_defaults(func=3Dhandle_gc_mark)
>
> +    gc_mark_parser_stream =3D subparsers.add_parser(
> +        'gc-mark-stream',
> +        help=3D(
> +            "Mark multiple hashes to be retained for garbage collection.=
 Input should be provided via stdin, "
> +            "with each line formatted as key-value pairs separated by sp=
aces, for example 'column1 foo column2 bar'."
> +        )
> +    )
> +    gc_mark_parser_stream.add_argument("mark", help=3D"Mark for this gar=
bage collection operation")
> +    gc_mark_parser_stream.set_defaults(func=3Dhandle_gc_mark_stream)
> +
>      gc_sweep_parser =3D subparsers.add_parser('gc-sweep', help=3D"Perfor=
m garbage collection and delete any entries that are not marked")
>      gc_sweep_parser.add_argument("mark", help=3D"Mark for this garbage c=
ollection operation")
>      gc_sweep_parser.set_defaults(func=3Dhandle_gc_sweep)
> diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
> index 775faf935..8973c3d18 100644
> --- a/lib/hashserv/client.py
> +++ b/lib/hashserv/client.py
> @@ -78,6 +78,7 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
>      MODE_NORMAL =3D 0
>      MODE_GET_STREAM =3D 1
>      MODE_EXIST_STREAM =3D 2
> +    MODE_MARK_STREAM =3D 3
>
>      def __init__(self, username=3DNone, password=3DNone):
>          super().__init__("OEHASHEQUIV", "1.1", logger)
> @@ -160,6 +161,8 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
>              await normal_to_stream("get-stream")
>          elif new_mode =3D=3D self.MODE_EXIST_STREAM:
>              await normal_to_stream("exists-stream")
> +        elif new_mode =3D=3D self.MODE_MARK_STREAM:
> +            await normal_to_stream("gc-mark-stream")
>          elif new_mode !=3D self.MODE_NORMAL:
>              raise Exception("Undefined mode transition {self.mode!r} -> =
{new_mode!r}")
>
> @@ -302,6 +305,24 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
>          """
>          return await self.invoke({"gc-mark": {"mark": mark, "where": whe=
re}})
>
> +    async def gc_mark_stream(self, mark, rows):
> +        """
> +        Similar to `gc-mark`, but accepts a list of "where" key-value pa=
ir
> +        conditions. It utilizes stream mode to mark hashes, which helps =
reduce
> +        the impact of latency when communicating with the hash equivalen=
ce
> +        server.
> +        """
> +        def row_to_dict(row):
> +            pairs =3D row.split()
> +            return dict(zip(pairs[::2], pairs[1::2]))
> +
> +        responses =3D await self.send_stream_batch(
> +            self.MODE_MARK_STREAM,
> +            (json.dumps({"mark": mark, "where": row_to_dict(row)}) for r=
ow in rows),
> +        )
> +
> +        return {"count": sum(int(json.loads(r)["count"]) for r in respon=
ses)}
> +
>      async def gc_sweep(self, mark):
>          """
>          Finishes garbage collection for "mark". All unihash entries that=
 have
> @@ -347,6 +368,7 @@ class Client(bb.asyncrpc.Client):
>              "get_db_query_columns",
>              "gc_status",
>              "gc_mark",
> +            "gc_mark_stream",
>              "gc_sweep",
>          )
>
> diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
> index 68f64f983..58f95c7bc 100644
> --- a/lib/hashserv/server.py
> +++ b/lib/hashserv/server.py
> @@ -10,6 +10,7 @@ import math
>  import time
>  import os
>  import base64
> +import json
>  import hashlib
>  from . import create_async_client
>  import bb.asyncrpc
> @@ -256,6 +257,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection)=
:
>                      "backfill-wait": self.handle_backfill_wait,
>                      "remove": self.handle_remove,
>                      "gc-mark": self.handle_gc_mark,
> +                    "gc-mark-stream": self.handle_gc_mark_stream,
>                      "gc-sweep": self.handle_gc_sweep,
>                      "gc-status": self.handle_gc_status,
>                      "clean-unused": self.handle_clean_unused,
> @@ -583,6 +585,33 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection=
):
>
>          return {"count": await self.db.gc_mark(mark, condition)}
>
> +    @permissions(DB_ADMIN_PERM)
> +    async def handle_gc_mark_stream(self, request):
> +        async def handler(line):
> +            try:
> +                decoded_line =3D json.loads(line)
> +            except json.JSONDecodeError as exc:
> +                raise bb.asyncrpc.InvokeError(
> +                    "Could not decode JSONL input '%s'" % line
> +                ) from exc
> +
> +            try:
> +                mark =3D decoded_line["mark"]
> +                condition =3D decoded_line["where"]
> +                if not isinstance(mark, str):
> +                    raise TypeError("Bad mark type %s" % type(mark))
> +
> +                if not isinstance(condition, dict):
> +                    raise TypeError("Bad condition type %s" % type(condi=
tion))
> +            except KeyError as exc:
> +                raise bb.asyncrpc.InvokeError(
> +                    "Input line is missing key '%s' " % exc
> +                ) from exc
> +
> +            return json.dumps({"count": await self.db.gc_mark(mark, cond=
ition)})
> +
> +        return await self._stream_handler(handler)
> +
>      @permissions(DB_ADMIN_PERM)
>      async def handle_gc_sweep(self, request):
>          mark =3D request["mark"]
> diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
> index 5349cd586..9f9ec720a 100644
> --- a/lib/hashserv/tests.py
> +++ b/lib/hashserv/tests.py
> @@ -1054,6 +1054,48 @@ class HashEquivalenceCommonTests(object):
>          # First hash is still present
>          self.assertClientGetHash(self.client, taskhash, unihash)
>
> +    def test_gc_stream(self):
> +        taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
> +        outhash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd=
03f72b67ce7a8'
> +        unihash =3D 'f37918cc02eb5a520b1aff86faacbc0a38124646'
> +
> +        result =3D self.client.report_unihash(taskhash, self.METHOD, out=
hash, unihash)
> +        self.assertEqual(result['unihash'], unihash, 'Server returned ba=
d unihash')
> +
> +        taskhash2 =3D '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
> +        outhash2 =3D '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c536=
0e136b852967b4'
> +        unihash2 =3D 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
> +
> +        result =3D self.client.report_unihash(taskhash2, self.METHOD, ou=
thash2, unihash2)
> +        self.assertClientGetHash(self.client, taskhash2, unihash2)
> +
> +        taskhash3 =3D 'a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c0'
> +        outhash3 =3D '7289c414905303700a1117c1f5a7c9ab2f5a39cc6fe5e61521=
69d09c04f9a53c'
> +        unihash3 =3D '905303700a1117c1f5a7c9ab2f5a39cc6fe5e615'
> +
> +        result =3D self.client.report_unihash(taskhash3, self.METHOD, ou=
thash3, unihash3)
> +        self.assertClientGetHash(self.client, taskhash3, unihash3)
> +
> +        # Mark the first unihash to be kept
> +        ret =3D self.client.gc_mark_stream("ABC", (f"unihash {h}" for h =
in [unihash, unihash2]))
> +        self.assertEqual(ret, {"count": 2})
> +
> +        ret =3D self.client.gc_status()
> +        self.assertEqual(ret, {"mark": "ABC", "keep": 2, "remove": 1})
> +
> +        # Third hash is still there; mark doesn't delete hashes
> +        self.assertClientGetHash(self.client, taskhash3, unihash3)
> +
> +        ret =3D self.client.gc_sweep("ABC")
> +        self.assertEqual(ret, {"count": 1})
> +
> +        # Hash is gone. Taskhash is returned for second hash
> +        self.assertClientGetHash(self.client, taskhash3, None)
> +        # First hash is still present
> +        self.assertClientGetHash(self.client, taskhash, unihash)
> +        # Second hash is still present
> +        self.assertClientGetHash(self.client, taskhash2, unihash2)
> +
>      def test_gc_switch_mark(self):
>          taskhash =3D '53b8dce672cb6d0c73170be43f540460bfc347b4'
>          outhash =3D '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd=
03f72b67ce7a8'
> --
> 2.25.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17419): https://lists.openembedded.org/g/bitbake-deve=
l/message/17419
> Mute This Topic: https://lists.openembedded.org/mt/111619243/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

