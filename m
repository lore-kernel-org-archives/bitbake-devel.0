Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1719.1794858679158494844
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Nov 2026 11:51:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=aiNB3Isf;
 spf=pass (domain: snapchat.com, ip: 209.85.128.48, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a210470b49so32095715e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Nov 2026 11:51:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794858677; cv=none;
        d=google.com; s=arc-20260327;
        b=Ls2rfAxuVNUiK5BS5CfYSuihhZtBy33IIalSKopzcmxdmivCcWDQGHuUCnBirmQ7Rt
         cV+39qrsk85ORtG2HnxEJWk+jGyiwhrnqsO+c7Ss6tPEEDPVbOPtns2nPNw2ANyT1cJ6
         c6+CFfnBaQ6QXwN03oYCKkebazAqGdLcfMCX//gbi1O9Zh2tjq8uJEp7AHYlBTXc4r3w
         x2BmnfaCkJ5IiR6dXl+Q8+eGXtDWS/PyTYIiO6PywqHdUk3XRUP7JF4/iiKRsG6zgTcr
         7Ue1U92bnFOwrFoW8KS7Bxp7rKEBxoIMNrYk4Pno/+7lP08M2Rou90OoyqrOFxwkQt+7
         rYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=VfH2MRaFl2e3y4mTecmvh303beq5xYSRDnsmoCR/7tw=;
        fh=4cv8OkrADdXrYqq9g0hWQIrZEgXUgKDcZ+KmKKbZ1O0=;
        b=MogmvCqH/55B5MJ6FQzGbDSksRZN1szIoJ7tQ/sWNbSGKA9jUgCbYIg6UIcXgkTO3M
         +gcH75lcSTt5qyUzfkjB45aux2OtE/rF0wQMQViVgR2nV4t9NdGjzN66DJ9klRLG47Ic
         7vtxCRZ5UVbFTaUXn7fTCQzmoen/E2SxXtoQz1MkZihH91I+TBVvttR/x/kF3gSvfCo1
         AQrc9vjGED33SYLtp4HmOG//2bIKGQmOLpzTc95jE1N5aUveFh3HLDQSjgUefwY0aNkL
         Ejay0OiQs6Zk40YvlDNjErXncCAqXo004BQ1tVZxCsLxossDQ6tC7NxplpaoAT50u29Y
         h9cw==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1794858677; x=1795463477; darn=lists.openembedded.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VfH2MRaFl2e3y4mTecmvh303beq5xYSRDnsmoCR/7tw=;
        b=aiNB3Isf/s/hZiUpr0IOhxFT7oS2JN/sJTNOm7muWPz8yhcmSK00FH3iyi9YK57MYi
         vIVOU/V6H6U14MDucrmH+DF6gwxL7h6ynxUi3gXJ9JA4sacTDBdeTolhQ5TCa46BIMTZ
         qnw5RVNWVc3hAiQ8AUq7QWfTQBd0hABLWfC+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858677; x=1795463477;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VfH2MRaFl2e3y4mTecmvh303beq5xYSRDnsmoCR/7tw=;
        b=rC5Vv4tCN/yaH/nLklVeRumPL34FSP46g8SETt1hr1HjWumiPdxQzBFZdj1dOFdYej
         dz64Tt7c9UTEe6Ma7fX5S2oK16dTafULYCfdooH/Ma1kqKGT/wnEA5Q+ylSRe5mXbwVg
         ZekhGHtvCbKeXDaEYFV0OE8gB/q6dQNYMoev8S9RgZdN7n9bRmPAiNECuF7fmtOoVgBG
         w6cAKQvc+hh20euhSjq5I5Vbtnq36JLwcqbLlDvhyLLS6X/IX7eWXlgNGpjnZZ/VaTdG
         IfLu9Omof+UQtE2hWdVjx+oPe8BUS2ACiWan4dG+uB11rwGzMbyedcJfooCJkIFGv5AV
         Cdng==
X-Gm-Message-State: APuU4Z8YlYrj3BYe8aDUcpA/xJkHxAeWzftDQKSCkIwVgNlqOHy7f9Rv
	RjNTztrbB23qpgmq7oGyj375oFRI2UJW1n0rmQi1sXcRurGPZslr9aogStNR5+m1dKESWMyq3gJ
	JnNURdt/Qf73irXHA4XLKm9klaU0avo/5A1GlOx5PQxkl952Zo9HlG0I=
X-Gm-Gg: AYBFou06u+jF6UiuIq3FoncVFxIw3KPkZMZOvetflhMJWgnwmoWc4uJpeQVv2P1i4sl
	NtCzLwGcIx8dUAzh7aBuPtHhXMwUZOKrdiR9c/wGLyZvQUyN00DG0DNll+A+WbtlxIBJ940aQZY
	eiwKAKA8w0JRk7hYME62msbcTGaJFVpElZtqYZ1UJu6kA82WvhWJ337WN8Mw8rK2Xw4DY9b9ph7
	ISN0pIkoSaO0YwAHmf4saCFZIYi6daWoVeFZDfxyEeiZy+rUk101Hsn7eUm/VujIhc3BD0q3fMB
	afSISYPpwA9uAafxkd/hKS38RxNPErIN9iuPAQx5ATLBBXFePWliT0ArGvWQproHejYp5AVdoXt
	scgx/new7t1DjhE40xY2O957X4ZpI7B2LCGWyxAeU1ueNKYlzJZxkqqvfkac7Inw96Qgh0oPzCb
	3IHxa5qASm5S6QrXRykgptdwDA9lfF
X-Received: by 2002:a05:600c:46cb:b0:4bb:52d8:73ef with SMTP id
 5b1f17b1804b1-4bb55af12e1mr250717995e9.34.1794858677028; Mon, 16 Nov 2026
 11:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20260928125051.2483039-1-ecordonnier@snap.com> <20260928125051.2483039-2-ecordonnier@snap.com>
In-Reply-To: <20260928125051.2483039-2-ecordonnier@snap.com>
From: Etienne Cordonnier <ecordonnier@snap.com>
Date: Mon, 16 Nov 2026 20:51:05 +0100
X-Gm-Features: Aa3M54oO2880jU8FCqFwRkysUGVGWKx0oiv8QnSznoW5VvnS-EOB5s72Jez5roQ
Message-ID: <CAHUKmYYpvYHaAbFVoBk7XJivpQet0G3wQ5or0BohNBMhMNH26A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fetch/wget: Have checkstatus() capture
 connection_cache, not fetch
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000de02c506606a19a5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 16 Nov 2026 19:51:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20441

--000000000000de02c506606a19a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
is the patch OK? I see that it has been in master-next for a while. Is
there some potential issue I should address?

=C3=89tienne

On Mon, Sep 28, 2026 at 2:51=E2=80=AFPM <ecordonnier@snap.com> wrote:

> From: Etienne Cordonnier <ecordonnier@snap.com>
>
> checkstatus()'s nested handler classes referenced fetch.connection_cache,
> so their methods closed over the fetch parameter itself rather than just
> the connection cache. Capture connection_cache in a local variable instea=
d
> and use that everywhere. No behaviour change; this makes the next commit,
> which caches the urllib opener built from these handlers, safe: a cached
> opener's closures no longer keep the Fetch object that built it alive.
>
> AI-Generated: Uses Claude Code (Claude Opus 5.5)
> Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
> ---
>  lib/bb/fetch/wget.py | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/lib/bb/fetch/wget.py b/lib/bb/fetch/wget.py
> index 972c84048..fe2de25d3 100644
> --- a/lib/bb/fetch/wget.py
> +++ b/lib/bb/fetch/wget.py
> @@ -178,23 +178,24 @@ class Wget(FetchMethod):
>      def checkstatus(self, fetch, ud, d, try_again=3DTrue):
>          check_certs =3D self.check_certs(d)
>          newenv =3D bb.fetch.get_fetcher_environment(d)
> +        connection_cache =3D fetch.connection_cache
>
>          class HTTPConnectionCache(http.client.HTTPConnection):
>              def cache_id(self):
>                  return None
>
> -            if fetch.connection_cache:
> +            if connection_cache:
>                  def connect(self):
>                      """Connect to the host and port specified in
> __init__."""
>
> -                    sock =3D fetch.connection_cache.get_connection(
> +                    sock =3D connection_cache.get_connection(
>                          self.host, self.port, self.cache_id())
>                      if sock:
>                          self.sock =3D sock
>                      else:
>                          self.sock =3D socket.create_connection((self.hos=
t,
> self.port),
>                                      self.timeout, self.source_address)
> -                        fetch.connection_cache.add_connection(
> +                        connection_cache.add_connection(
>                              self.host, self.port, self.sock,
> self.cache_id())
>
>                      if self._tunnel_host:
> @@ -206,17 +207,17 @@ class Wget(FetchMethod):
>                          newenv.get("SSL_CERT_FILE"),
>                          self._tunnel_host, self._tunnel_port)
>
> -            if fetch.connection_cache:
> +            if connection_cache:
>                  def connect(self):
>                      """Reuse an established TLS connection when
> available."""
>
> -                    sock =3D fetch.connection_cache.get_connection(
> +                    sock =3D connection_cache.get_connection(
>                          self.host, self.port, self.cache_id())
>                      if sock:
>                          self.sock =3D sock
>                      else:
>                          super().connect()
> -                        fetch.connection_cache.add_connection(
> +                        connection_cache.add_connection(
>                              self.host, self.port, self.sock,
> self.cache_id())
>
>          class CacheHTTPHandler(urllib.request.HTTPHandler):
> @@ -252,7 +253,7 @@ class Wget(FetchMethod):
>                  # request.
>
>                  # Don't close connection when connection_cache is enable=
d,
> -                if fetch.connection_cache is None:
> +                if connection_cache is None:
>                      headers["Connection"] =3D "close"
>                  else:
>                      headers["Connection"] =3D "Keep-Alive" # Works for
> HTTP/1.0
> @@ -282,8 +283,8 @@ class Wget(FetchMethod):
>                      # with the dead connection removed from the cache.
>                      # If it still fails, we give up, which can happen fo=
r
> bad
>                      # HTTP proxy settings.
> -                    if fetch.connection_cache:
> -                        fetch.connection_cache.remove_connection(
> +                    if connection_cache:
> +                        connection_cache.remove_connection(
>                              h.host, h.port, h.cache_id())
>                      h.close()
>                      raise
> @@ -316,9 +317,9 @@ class Wget(FetchMethod):
>                  resp.msg =3D r.reason
>
>                  # Close connection when server request it.
> -                if fetch.connection_cache is not None:
> +                if connection_cache is not None:
>                      if 'Connection' in r.msg and r.msg['Connection'] =3D=
=3D
> 'close':
> -                        fetch.connection_cache.remove_connection(
> +                        connection_cache.remove_connection(
>                              h.host, h.port, h.cache_id())
>
>                  return resp
> --
> 2.43.0
>
>

--000000000000de02c506606a19a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGksPGJyPmlzIHRoZSBwYXRjaCBPSz8gSSBzZWUgdGhhdCBpdCBoYXMg
YmVlbiBpbiBtYXN0ZXItbmV4dCBmb3IgYSB3aGlsZS4gSXMgdGhlcmUgc29tZSBwb3RlbnRpYWwg
aXNzdWUgSSBzaG91bGQgYWRkcmVzcz88YnI+PGJyPsOJdGllbm5lPC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIGdtYWlsX3F1b3RlX2NvbnRhaW5lciI+PGRpdiBkaXI9Imx0ciIgY2xh
c3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgU2VwIDI4LCAyMDI2IGF0IDI6NTHigK9QTSAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmVjb3Jkb25uaWVyQHNuYXAuY29tIj5lY29yZG9ubmllckBzbmFwLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0
eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigy
MDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+RnJvbTogRXRpZW5uZSBDb3Jkb25uaWVyICZs
dDs8YSBocmVmPSJtYWlsdG86ZWNvcmRvbm5pZXJAc25hcC5jb20iIHRhcmdldD0iX2JsYW5rIj5l
Y29yZG9ubmllckBzbmFwLmNvbTwvYT4mZ3Q7PGJyPg0KPGJyPg0KY2hlY2tzdGF0dXMoKSYjMzk7
cyBuZXN0ZWQgaGFuZGxlciBjbGFzc2VzIHJlZmVyZW5jZWQgZmV0Y2guY29ubmVjdGlvbl9jYWNo
ZSw8YnI+DQpzbyB0aGVpciBtZXRob2RzIGNsb3NlZCBvdmVyIHRoZSBmZXRjaCBwYXJhbWV0ZXIg
aXRzZWxmIHJhdGhlciB0aGFuIGp1c3Q8YnI+DQp0aGUgY29ubmVjdGlvbiBjYWNoZS4gQ2FwdHVy
ZSBjb25uZWN0aW9uX2NhY2hlIGluIGEgbG9jYWwgdmFyaWFibGUgaW5zdGVhZDxicj4NCmFuZCB1
c2UgdGhhdCBldmVyeXdoZXJlLiBObyBiZWhhdmlvdXIgY2hhbmdlOyB0aGlzIG1ha2VzIHRoZSBu
ZXh0IGNvbW1pdCw8YnI+DQp3aGljaCBjYWNoZXMgdGhlIHVybGxpYiBvcGVuZXIgYnVpbHQgZnJv
bSB0aGVzZSBoYW5kbGVycywgc2FmZTogYSBjYWNoZWQ8YnI+DQpvcGVuZXImIzM5O3MgY2xvc3Vy
ZXMgbm8gbG9uZ2VyIGtlZXAgdGhlIEZldGNoIG9iamVjdCB0aGF0IGJ1aWx0IGl0IGFsaXZlLjxi
cj4NCjxicj4NCkFJLUdlbmVyYXRlZDogVXNlcyBDbGF1ZGUgQ29kZSAoQ2xhdWRlIE9wdXMgNS41
KTxicj4NClNpZ25lZC1vZmYtYnk6IEV0aWVubmUgQ29yZG9ubmllciAmbHQ7PGEgaHJlZj0ibWFp
bHRvOmVjb3Jkb25uaWVyQHNuYXAuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZWNvcmRvbm5pZXJAc25h
cC5jb208L2E+Jmd0Ozxicj4NCi0tLTxicj4NCsKgbGliL2JiL2ZldGNoL3dnZXQucHkgfCAyMyAr
KysrKysrKysrKystLS0tLS0tLS0tLTxicj4NCsKgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9saWIvYmIvZmV0
Y2gvd2dldC5weSBiL2xpYi9iYi9mZXRjaC93Z2V0LnB5PGJyPg0KaW5kZXggOTcyYzg0MDQ4Li5m
ZTJkZTI1ZDMgMTAwNjQ0PGJyPg0KLS0tIGEvbGliL2JiL2ZldGNoL3dnZXQucHk8YnI+DQorKysg
Yi9saWIvYmIvZmV0Y2gvd2dldC5weTxicj4NCkBAIC0xNzgsMjMgKzE3OCwyNCBAQCBjbGFzcyBX
Z2V0KEZldGNoTWV0aG9kKTo8YnI+DQrCoCDCoCDCoGRlZiBjaGVja3N0YXR1cyhzZWxmLCBmZXRj
aCwgdWQsIGQsIHRyeV9hZ2Fpbj1UcnVlKTo8YnI+DQrCoCDCoCDCoCDCoCDCoGNoZWNrX2NlcnRz
ID0gc2VsZi5jaGVja19jZXJ0cyhkKTxicj4NCsKgIMKgIMKgIMKgIMKgbmV3ZW52ID0gYmIuZmV0
Y2guZ2V0X2ZldGNoZXJfZW52aXJvbm1lbnQoZCk8YnI+DQorwqAgwqAgwqAgwqAgY29ubmVjdGlv
bl9jYWNoZSA9IGZldGNoLmNvbm5lY3Rpb25fY2FjaGU8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDC
oGNsYXNzIEhUVFBDb25uZWN0aW9uQ2FjaGUoaHR0cC5jbGllbnQuSFRUUENvbm5lY3Rpb24pOjxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgZGVmIGNhY2hlX2lkKHNlbGYpOjxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIE5vbmU8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgaWYgZmV0Y2guY29ubmVjdGlvbl9jYWNoZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYg
Y29ubmVjdGlvbl9jYWNoZTo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlZiBjb25u
ZWN0KHNlbGYpOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7JnF1
b3Q7JnF1b3Q7Q29ubmVjdCB0byB0aGUgaG9zdCBhbmQgcG9ydCBzcGVjaWZpZWQgaW4gX19pbml0
X18uJnF1b3Q7JnF1b3Q7JnF1b3Q7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHNvY2sgPSBmZXRjaC5jb25uZWN0aW9uX2NhY2hlLmdldF9jb25uZWN0aW9uKDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzb2NrID0gY29ubmVjdGlvbl9jYWNoZS5n
ZXRfY29ubmVjdGlvbig8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHNlbGYuaG9zdCwgc2VsZi5wb3J0LCBzZWxmLmNhY2hlX2lkKCkpPGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBpZiBzb2NrOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgc2VsZi5zb2NrID0gc29jazxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgZWxzZTo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHNlbGYuc29jayA9IHNvY2tldC5jcmVhdGVfY29ubmVjdGlvbigoc2VsZi5ob3N0LCBzZWxm
LnBvcnQpLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc2VsZi50aW1lb3V0LCBzZWxmLnNvdXJjZV9hZGRyZXNzKTxicj4NCi3CoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmZXRjaC5jb25uZWN0aW9uX2NhY2hlLmFk
ZF9jb25uZWN0aW9uKDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBj
b25uZWN0aW9uX2NhY2hlLmFkZF9jb25uZWN0aW9uKDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VsZi5ob3N0LCBzZWxmLnBvcnQsIHNlbGYuc29jaywg
c2VsZi5jYWNoZV9pZCgpKTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaWYgc2VsZi5fdHVubmVsX2hvc3Q6PGJyPg0KQEAgLTIwNiwxNyArMjA3LDE3IEBAIGNsYXNz
IFdnZXQoRmV0Y2hNZXRob2QpOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgbmV3ZW52LmdldCgmcXVvdDtTU0xfQ0VSVF9GSUxFJnF1b3Q7KSw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGYuX3R1bm5lbF9ob3N0LCBzZWxmLl90
dW5uZWxfcG9ydCk8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgaWYgZmV0Y2guY29ubmVj
dGlvbl9jYWNoZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgaWYgY29ubmVjdGlvbl9jYWNoZTo8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRlZiBjb25uZWN0KHNlbGYpOjxicj4NCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJnF1b3Q7JnF1b3Q7JnF1b3Q7UmV1c2UgYW4g
ZXN0YWJsaXNoZWQgVExTIGNvbm5lY3Rpb24gd2hlbiBhdmFpbGFibGUuJnF1b3Q7JnF1b3Q7JnF1
b3Q7PGJyPg0KPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNvY2sgPSBmZXRj
aC5jb25uZWN0aW9uX2NhY2hlLmdldF9jb25uZWN0aW9uKDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBzb2NrID0gY29ubmVjdGlvbl9jYWNoZS5nZXRfY29ubmVjdGlvbig8YnI+
DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNlbGYuaG9zdCwgc2VsZi5w
b3J0LCBzZWxmLmNhY2hlX2lkKCkpPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBpZiBzb2NrOjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2Vs
Zi5zb2NrID0gc29jazxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZTo8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN1cGVyKCkuY29ubmVj
dCgpPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZldGNoLmNvbm5l
Y3Rpb25fY2FjaGUuYWRkX2Nvbm5lY3Rpb24oPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIGNvbm5lY3Rpb25fY2FjaGUuYWRkX2Nvbm5lY3Rpb24oPGJyPg0KwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZWxmLmhvc3QsIHNlbGYucG9y
dCwgc2VsZi5zb2NrLCBzZWxmLmNhY2hlX2lkKCkpPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqBj
bGFzcyBDYWNoZUhUVFBIYW5kbGVyKHVybGxpYi5yZXF1ZXN0LkhUVFBIYW5kbGVyKTo8YnI+DQpA
QCAtMjUyLDcgKzI1Myw3IEBAIGNsYXNzIFdnZXQoRmV0Y2hNZXRob2QpOjxicj4NCsKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIyByZXF1ZXN0Ljxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIyBEb24mIzM5O3QgY2xvc2UgY29ubmVjdGlvbiB3aGVuIGNvbm5lY3Rpb25fY2Fj
aGUgaXMgZW5hYmxlZCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgZmV0Y2guY29u
bmVjdGlvbl9jYWNoZSBpcyBOb25lOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiBj
b25uZWN0aW9uX2NhY2hlIGlzIE5vbmU6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBoZWFkZXJzWyZxdW90O0Nvbm5lY3Rpb24mcXVvdDtdID0gJnF1b3Q7Y2xvc2UmcXVvdDs8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGVsc2U6PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBoZWFkZXJzWyZxdW90O0Nvbm5lY3Rpb24mcXVvdDtdID0gJnF1b3Q7
S2VlcC1BbGl2ZSZxdW90OyAjIFdvcmtzIGZvciBIVFRQLzEuMDxicj4NCkBAIC0yODIsOCArMjgz
LDggQEAgY2xhc3MgV2dldChGZXRjaE1ldGhvZCk6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAjIHdpdGggdGhlIGRlYWQgY29ubmVjdGlvbiByZW1vdmVkIGZyb20gdGhlIGNh
Y2hlLjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIyBJZiBpdCBzdGlsbCBm
YWlscywgd2UgZ2l2ZSB1cCwgd2hpY2ggY2FuIGhhcHBlbiBmb3IgYmFkPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAjIEhUVFAgcHJveHkgc2V0dGluZ3MuPGJyPg0KLcKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIGZldGNoLmNvbm5lY3Rpb25fY2FjaGU6PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGZldGNoLmNvbm5lY3Rpb25fY2Fj
aGUucmVtb3ZlX2Nvbm5lY3Rpb24oPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGlmIGNvbm5lY3Rpb25fY2FjaGU6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIGNvbm5lY3Rpb25fY2FjaGUucmVtb3ZlX2Nvbm5lY3Rpb24oPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBoLmhvc3QsIGgucG9ydCwgaC5jYWNo
ZV9pZCgpKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaC5jbG9zZSgpPGJy
Pg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByYWlzZTxicj4NCkBAIC0zMTYsOSAr
MzE3LDkgQEAgY2xhc3MgV2dldChGZXRjaE1ldGhvZCk6PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqByZXNwLm1zZyA9IHIucmVhc29uPGJyPg0KPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAjIENsb3NlIGNvbm5lY3Rpb24gd2hlbiBzZXJ2ZXIgcmVxdWVzdCBpdC48YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgZmV0Y2guY29ubmVjdGlvbl9jYWNoZSBpcyBub3Qg
Tm9uZTo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgY29ubmVjdGlvbl9jYWNoZSBp
cyBub3QgTm9uZTo8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICYjMzk7
Q29ubmVjdGlvbiYjMzk7IGluIHIubXNnIGFuZCByLm1zZ1smIzM5O0Nvbm5lY3Rpb24mIzM5O10g
PT0gJiMzOTtjbG9zZSYjMzk7Ojxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBmZXRjaC5jb25uZWN0aW9uX2NhY2hlLnJlbW92ZV9jb25uZWN0aW9uKDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb25uZWN0aW9uX2NhY2hlLnJlbW92ZV9j
b25uZWN0aW9uKDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgaC5ob3N0LCBoLnBvcnQsIGguY2FjaGVfaWQoKSk8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldHVybiByZXNwPGJyPg0KLS0gPGJyPg0KMi40My4wPGJyPg0KPGJyPg0K
PC9ibG9ja3F1b3RlPjwvZGl2Pg0K
--000000000000de02c506606a19a5--
