Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13853.1794905621154679839
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 17 Nov 2026 00:53:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@pbarker.dev header.s=fm2 header.b=Av9J1n63;
 dkim=pass header.i=@messagingengine.com header.s=fm3 header.b=QlFjJqkT;
 spf=pass (domain: pbarker.dev, ip: 103.168.172.147, mailfrom: paul@pbarker.dev)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3B828EC011C
	for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 03:53:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 17 Nov 2026 03:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pbarker.dev; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794905620;
	 x=1794992020; bh=gJp9XtUVN8HXaeDplv05/rVBEBBKZPI/PuXYZUyDkUQ=; b=
	Av9J1n63L34ZDrJNTGQl/tBUOWT81tSCN+fFuH0AM6Q6LHIvZvolOUkeD6mFZ8GN
	yXuf7l0Y6JS/Z1zFofllY1/ffAkwUu5tpjTJ6kuekiJ3x/vW7m8L9mhszQEn5EYl
	Nhpq9e/+NSAUOcdpriwJ+hSgh5+JD2cxNOSyx+Jnb32JwM/hduwKfT9r7a23lwqm
	rMc8Oy0vS9fdvnBag0SVNh/xevNVwb0VL2Da+EEfmzXOv3wFlFWOIRJfkyvKUCrh
	VvJsZkEmTxM9X5xkswlBmk120WjF08J3KVVDnH04PevI1ftLsq4m1r6bQAElMs/3
	LnNAaW3pey6O7pVR0/RH0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794905620; x=1794992020; bh=g
	Jp9XtUVN8HXaeDplv05/rVBEBBKZPI/PuXYZUyDkUQ=; b=QlFjJqkT5oqhN51D3
	Q9vqyu3KQreZG6aLr0RMZ4Xl+bpk7VQHjXhJnSQrFomq/VzQRS6ICTZPbTCNrbq4
	JO05p0oLNQyBZcQHeFfkhMEwPnI66toyj5GVft9ptrI37kvhvJx2oue9munZOp2d
	75ZADAmB837HlKhY7CwiqSH9SSU57ohd/AILGtFn/bxWpcXjFs5NM64pdQeeWkIO
	hw593g1XgD6OCtpIJraA7pIVKqPVSHPkiMNCineQa/fyIuQFO6ypQiFBBKAMtoMe
	XrdNUUbxXN11A/XlsBoxugXwqBv3JxkTbUoVMyoEvRXO8mCeJcn67qttjbLRdo73
	jz3dQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pbarker.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794905620; d=pbarker.dev;
	mf=PHBhdWxAcGJhcmtlci5kZXY+;
	rt=PGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4=;
	s=fm2:rsa-sha256:iRRkaBgTLvTwON4e9MpgYg2UGvVd++H89zcxdo4qTFgFfMf
	MiSEzzrAFu2xp0rO9MIpDQ/UAu+kFEF0OW3awOIvuqb0OTt2cNEwUXUvPplg/E01
	heqEVz9rhYeVw0xQDYIUMF9FNdQVOIIVshEwxfKWmSCwmMuUUBjuCtBKXawIG+qc
	1So91qid+aVD3Ja7IV09kkPOCjmxxYiXDHGb0nptT5opP4MjNKUSk27lLQhqjBgr
	XTI4mr3zJKHavodq14ymNYdPA6uPHKYp53XQDZ3qph+/WbGPvVUB8fzIKFgOkICD
	tKI66I6N4Lu0zk7nKW+Tbl8yu7xEvhgKCPrfcxw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=content-transfer-encoding,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:uxmwlYGr5cGgtTaGNJYVfcGQxgKqpNsOKOXy6L5TcUU=:med2C8d8OcJfuX78VIadceFQOuF1b1RA10hiothi3c0=;
X-ME-Sender: <xms:FBb8aoZO1CD-o2qo4VB-auhjT0bxv5YTKt1g2x-SGcceeMcIyKPTVw>
    <xme:FBb8apZyDSlXKdnqBfjkBj-dFVl4pFpbLw-nA32Y7m5jeX1fBkd4lh4w45g32Igdh
    OoCIz0hRNlBw5wo1VtYfpt9XB7tv1pl5xBCESW9JXScmJpofmoBHwO7>
X-ME-Received: <xmr:FBb8agmEPXpj0tcjaoP6ma2gbb2_I-075-zTCfvwfVHg0Fvt2P0W0L3Bh9dayBZQYyCOYacDLz8_ZYVVx3cr-knwRgoJ>
X-ME-Proxy-Cause: dmFkZTEAffJUUFrRvXR2WxinmsNucwJYddo8Fz120o9Z/AZelo5YT5uQSc7Go1S8h4hgG4
    2OUKeDw0he3jcoUXo78vrmP2vfEf+C4cB9F1gS89KZmTohJVFK4iestcv/DI6ta1HT/GQm
    ImN4p9o+hcJ79N2XhPGEQrcjZKwGLPM8nBGD2ZUXf2AKG97x1451o5bJM1Pbbceq9OMiJW
    twl2kJljtloGtKOTy4ha4KUMsxD3r3DdamGyEnWL74hRV4xjH4a/5aks5p/KkqD6K/YiJA
    xs8J3T8f9wgE8GYmOtYMkNMYlWSFjATEV0V8KZGuswVGVSsVHK8lm5UrZTLRSbHjDwTqLs
    h+I1mUCf+XS9Bgxv3OVnQwJNg2OTVfwEvfYhn8E+vmT1jHwdsjArcJzO6W1I8WJmRh/yFS
    SGFk/yLD39fIaGfCzE10SqSvSZyKbpOPy2uXRMDLE9SqEVAb9D8Qfg4ge7stxxyjYtHkWR
    W1WB5mIyjXsaK7ygkOyUN+KoBM+bt29pk3ceH5UDpRkIJwwYkW5p7TfEDCzvmR3ACcyjjh
    dNCDaOmWXWufwlDf5ezpTgUMif2GqghKBTDh0t9oxhJvb13Kc9VQWS2VUEDuxGAhtX1GTr
    mQUgOqHVpeI90JDvUkdqK14/DpEiIs4Xz/nUAy6dLDkS782ENF0p3VmAwhfQ
X-ME-Proxy: <xmx:FBb8atyW9_4qhks3YGMpheQL43UOvvrq_VOdIp3IAuAa_FGjWS8ojg>
    <xmx:FBb8amNhi8XNo9wWe7mSSrDNDb_oRzCcb7H6eOv-aAXpecB8dwIFyg>
    <xmx:FBb8apRUs5TCnVnYnq84uSQj2gxDxULFT_Y2OuoyF_qjs6xI7FAfqA>
    <xmx:FBb8asatXJqUD54gRufD1YxreLncEgamObGKF51VvclFsO2LAwcbAw>
    <xmx:FBb8asZu8J6_8bW6nZDLgafjIECf-krXDMc0frn-m3ON6dZvre4VE-Mr>
Feedback-ID: i51494658:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 03:53:39 -0500 (EST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 08:53:38 +0000
Message-Id: <DMXCXTQOM1ZW.1OMQYIZFM1ZTV@pbarker.dev>
Subject: Re: [PATCH v2 1/2] fetch/wget: Have checkstatus() capture
 connection_cache, not fetch
From: "Paul Barker" <paul@pbarker.dev>
To: "Etienne Cordonnier" <ecordonnier@snap.com>,
 <bitbake-devel@lists.openembedded.org>
X-Mailer: aerc 0.22.0
References: <20260928125051.2483039-1-ecordonnier@snap.com>
 <20260928125051.2483039-2-ecordonnier@snap.com>
 <CAHUKmYYpvYHaAbFVoBk7XJivpQet0G3wQ5or0BohNBMhMNH26A@mail.gmail.com>
In-Reply-To: <CAHUKmYYpvYHaAbFVoBk7XJivpQet0G3wQ5or0BohNBMhMNH26A@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 17 Nov 2026 08:53:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20442

On Mon Nov 16, 2026 at 7:51 PM GMT, Etienne Cordonnier wrote:
> Hi,
> is the patch OK? I see that it has been in master-next for a while. Is
> there some potential issue I should address?

Hi =C3=89tienne,

Unfortunately we have limited bandwidth for reviewing changes and there
is a lot of work in progress. Apologies that this got stuck in the
queue.

This patch looks fine, I will take a look at the second patch in the
series and give some feedback.

>
> On Mon, Sep 28, 2026 at 2:51=E2=80=AFPM <ecordonnier@snap.com> wrote:
>
>> From: Etienne Cordonnier <ecordonnier@snap.com>
>>
>> checkstatus()'s nested handler classes referenced fetch.connection_cache=
,
>> so their methods closed over the fetch parameter itself rather than just
>> the connection cache. Capture connection_cache in a local variable inste=
ad
>> and use that everywhere. No behaviour change; this makes the next commit=
,
>> which caches the urllib opener built from these handlers, safe: a cached
>> opener's closures no longer keep the Fetch object that built it alive.
>>
>> AI-Generated: Uses Claude Code (Claude Opus 5.5)
>> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
>> ---
>>  lib/bb/fetch/wget.py | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
>> index 972c84048..fe2de25d3 100644
>> --- a/lib/bb/fetch/wget.py
>> +++ b/lib/bb/fetch/wget.py
>> @@ -178,23 +178,24 @@ class Wget(FetchMethod):
>>      def checkstatus(self, fetch, ud, d, try_again=3DTrue):
>>          check_certs =3D self.check_certs(d)
>>          newenv =3D bb.fetch.get_fetcher_environment(d)
>> +        connection_cache =3D fetch.connection_cache
>>
>>          class HTTPConnectionCache(http.client.HTTPConnection):
>>              def cache_id(self):
>>                  return None
>>
>> -            if fetch.connection_cache:
>> +            if connection_cache:
>>                  def connect(self):
>>                      """Connect to the host and port specified in
>> __init__."""
>>
>> -                    sock =3D fetch.connection_cache.get_connection(
>> +                    sock =3D connection_cache.get_connection(
>>                          self.host, self.port, self.cache_id())
>>                      if sock:
>>                          self.sock =3D sock
>>                      else:
>>                          self.sock =3D socket.create_connection((self.ho=
st,
>> self.port),
>>                                      self.timeout, self.source_address)
>> -                        fetch.connection_cache.add_connection(
>> +                        connection_cache.add_connection(
>>                              self.host, self.port, self.sock,
>> self.cache_id())
>>
>>                      if self._tunnel_host:
>> @@ -206,17 +207,17 @@ class Wget(FetchMethod):
>>                          newenv.get("SSL_CERT_FILE"),
>>                          self._tunnel_host, self._tunnel_port)
>>
>> -            if fetch.connection_cache:
>> +            if connection_cache:
>>                  def connect(self):
>>                      """Reuse an established TLS connection when
>> available."""
>>
>> -                    sock =3D fetch.connection_cache.get_connection(
>> +                    sock =3D connection_cache.get_connection(
>>                          self.host, self.port, self.cache_id())
>>                      if sock:
>>                          self.sock =3D sock
>>                      else:
>>                          super().connect()
>> -                        fetch.connection_cache.add_connection(
>> +                        connection_cache.add_connection(
>>                              self.host, self.port, self.sock,
>> self.cache_id())
>>
>>          class CacheHTTPHandler(urllib.request.HTTPHandler):
>> @@ -252,7 +253,7 @@ class Wget(FetchMethod):
>>                  # request.
>>
>>                  # Don't close connection when connection_cache is enabl=
ed,
>> -                if fetch.connection_cache is None:
>> +                if connection_cache is None:
>>                      headers["Connection"] =3D "close"
>>                  else:
>>                      headers["Connection"] =3D "Keep-Alive" # Works for
>> HTTP/1.0
>> @@ -282,8 +283,8 @@ class Wget(FetchMethod):
>>                      # with the dead connection removed from the cache.
>>                      # If it still fails, we give up, which can happen f=
or
>> bad
>>                      # HTTP proxy settings.
>> -                    if fetch.connection_cache:
>> -                        fetch.connection_cache.remove_connection(
>> +                    if connection_cache:
>> +                        connection_cache.remove_connection(
>>                              h.host, h.port, h.cache_id())
>>                      h.close()
>>                      raise
>> @@ -316,9 +317,9 @@ class Wget(FetchMethod):
>>                  resp.msg =3D r.reason
>>
>>                  # Close connection when server request it.
>> -                if fetch.connection_cache is not None:
>> +                if connection_cache is not None:
>>                      if 'Connection' in r.msg and r.msg['Connection'] =
=3D=3D
>> 'close':
>> -                        fetch.connection_cache.remove_connection(
>> +                        connection_cache.remove_connection(
>>                              h.host, h.port, h.cache_id())
>>
>>                  return resp
>> --
>> 2.43.0
>>
>>



Best regards,

--=20
Paul Barker

