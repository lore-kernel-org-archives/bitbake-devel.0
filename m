Return-Path: <regulationdango@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E053C04A68
	for <webhook@archiver.kernel.org>; Wed, 27 Jul 2022 15:49:41 +0000 (UTC)
Subject: [REPORT]Some strange behavior with XMLRPC server
To: bitbake-devel@lists.openembedded.org
From: regulationdango@gmail.com
X-Originating-Location: Tokyo, JP (160.237.142.147)
X-Originating-Platform: Windows Chrome 103
User-Agent: GROUPS.IO Web Poster
MIME-Version: 1.0
Date: Wed, 27 Jul 2022 08:49:35 -0700
Message-ID: <bGRy.1658936975483534028.Wbtj@lists.openembedded.org>
Content-Type: multipart/mixed; boundary="JrRAYLabBftJqUlBM3EU"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Jul 2022 15:49:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13859

--JrRAYLabBftJqUlBM3EU
Content-Type: multipart/alternative; boundary="y9sKOy4xRMwGOEyrQdYF"

--y9sKOy4xRMwGOEyrQdYF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi! I'm a newbie of bitbake community!
Recently, I'm trying to implement XMLRPC client for bitbake command(this is=
 similar to tinfoil).
As I do this activity,=C2=A0 I found the following strange behavior.

---

# getRecipePackages commands returns collections.defaultdict object, but it=
's not supported by XMLRPCServer
This is as the title says.=C2=A0The following two places may help you under=
stand.=C2=A0Isn't this a glitch?

* getRecipePackages command returns=C2=A0command.cooker.recipecaches[mc].pa=
ckages(See https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/command.py=
#n343 ) ( https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/command.py#=
n343 )
* command.cooker.recipecaches[mc].packages is set as defaultdict(list) (See=
 https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/cache.py#n153 )

This causes an exception when calling getRecipePackages commands. See the a=
ttached log file.
We can fix this by returning as a dict object.

```
return dict(command.cooker.recipecaches[mc].packages)
```

#=C2=A0getLayerPriorities command clears recipescache
I noticed that `getLayerPriorities` command deletes cache data because `get=
LayerPriorities` calls `cooker.parseConfiguration()`, and this deletes cook=
er.recipecaches.
Is this behavior as intended?

1. getLayerPriorities=C2=A0command calls command.cooker.parseConfiguration(=
)(See https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/command.py#n298=
 )
2. parseConfiguration deletes recipecaches(See https://git.yoctoproject.org=
/poky/tree/bitbake/lib/bb/cooker.py#n467 )

Therefore, If user calls commands by following order, the results of the th=
ird and fifth getRecipes are different because the fourth getLayerPrioritie=
s clears the cache.

1. parseConfiguration command
2. parseFiles command
3.=C2=A0getRecipes command=C2=A0 =C2=A0<- user can get info normaly
3.=C2=A0getLayerPriorities command
4. getRecipes command=C2=A0 =C2=A0=C2=A0=C2=A0<- user can get empty info!

---

This is my first post to this mailing list, so please forgive me if I am ru=
de in any way. Thanks for reading!

--y9sKOy4xRMwGOEyrQdYF
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi! I'm a newbie of bitbake community!&nbsp;<br />Recently, I'm trying to i=
mplement XMLRPC client for bitbake command(this is similar to tinfoil).&nbs=
p;<br />As I do this activity,&nbsp; I found the following strange behavior=
.<br /><br />---<br /><br /># getRecipePackages commands returns collection=
s.defaultdict object, but it's not supported by XMLRPCServer<br />This is a=
s the title says.&nbsp;The following two places may help you understand.&nb=
sp;Isn't this a glitch?<br /><br />* getRecipePackages command returns&nbsp=
;command.cooker.recipecaches[mc].packages(See&nbsp;<a href=3D"https://git.y=
octoproject.org/poky/tree/bitbake/lib/bb/command.py#n343" target=3D"_blank"=
 rel=3D"noopener">https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/com=
mand.py#n343 )</a><br />* command.cooker.recipecaches[mc].packages is set a=
s defaultdict(list) (See <a href=3D"https://git.yoctoproject.org/poky/tree/=
bitbake/lib/bb/cache.py#n153" target=3D"_blank" rel=3D"noopener">https://gi=
t.yoctoproject.org/poky/tree/bitbake/lib/bb/cache.py#n153</a>)<br /><br />T=
his causes an exception when calling getRecipePackages commands. See the at=
tached log file.&nbsp;<br />We can fix this by returning as a dict object.&=
nbsp;<br /><br />```<br />return dict(command.cooker.recipecaches[mc].packa=
ges)<br />```<br /><br />#&nbsp;getLayerPriorities command clears recipesca=
che<br />I noticed that `getLayerPriorities` command deletes cache data bec=
ause `getLayerPriorities` calls `cooker.parseConfiguration()`, and this del=
etes cooker.recipecaches.<br />Is this behavior as intended?<br /><br />1. =
getLayerPriorities&nbsp;command calls command.cooker.parseConfiguration()(S=
ee <a href=3D"https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/command=
.py#n298" target=3D"_blank" rel=3D"noopener">https://git.yoctoproject.org/p=
oky/tree/bitbake/lib/bb/command.py#n298</a>)<br />2. parseConfiguration del=
etes recipecaches(See&nbsp;<a href=3D"https://git.yoctoproject.org/poky/tre=
e/bitbake/lib/bb/cooker.py#n467" target=3D"_blank" rel=3D"noopener">https:/=
/git.yoctoproject.org/poky/tree/bitbake/lib/bb/cooker.py#n467</a>)<br /><br=
 />Therefore, If user calls commands by following order, the results of the=
 third and fifth getRecipes are different because the fourth getLayerPriori=
ties clears the cache.<br /><br />1. parseConfiguration command
<div>2. parseFiles command<br />3.&nbsp;getRecipes command&nbsp; &nbsp;&lt;=
- user can get info normaly<br />3.&nbsp;getLayerPriorities command<br />4.=
 getRecipes command&nbsp; &nbsp;&nbsp;&nbsp;&lt;- user can get empty info!&=
nbsp;<br /><br />---<br /><br />This is my first post to this mailing list,=
 so please forgive me if I am rude in any way. Thanks for reading!<br /><br=
 /></div>

--y9sKOy4xRMwGOEyrQdYF--

--JrRAYLabBftJqUlBM3EU
Content-Type: application/octet-stream; name="log"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="log"

L3Vzci9saWIvcHl0aG9uMy9kaXN0LXBhY2thZ2VzL2h0bWw1bGliL190cmllL19iYXNlLnB5OjM6
IERlcHJlY2F0aW9uV2FybmluZzogVXNpbmcgb3IgaW1wb3J0aW5nIHRoZSBBQkNzIGZyb20gJ2Nv
bGxlY3Rpb25zJyBpbnN0ZWFkIG9mIGZyb20gJ2NvbGxlY3Rpb25zLmFiYycgaXMgZGVwcmVjYXRl
ZCBzaW5jZSBQeXRob24gMy4zLCBhbmQgaW4gMy4xMCBpdCB3aWxsIHN0b3Agd29ya2luZwogIGZy
b20gY29sbGVjdGlvbnMgaW1wb3J0IE1hcHBpbmcKV0FSTklORzogeWFjYyB0YWJsZSBmaWxlIHZl
cnNpb24gaXMgb3V0IG9mIGRhdGUKTG9hZGluZyBjYWNoZTogMTAwJSB8IyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyN8IFRpbWU6IDA6MDA6MDAKTG9hZGVkIDE2NzIgZW50cmll
cyBmcm9tIGRlcGVuZGVuY3kgY2FjaGUuCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KZ2V0UmVjaXBl
UGFja2FnZXMKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi9ob21l
L3lvc3VrZS93b3JrL2dpdC9iYmNsaW50L3Rlc3QvYmJjbGllbnQvYmJjbGllbnQucHkiLCBsaW5l
IDc5OSwgaW4gX19ydW5fY29tbWFuZAogICAgcmVzdWx0ID0gc2VydmVyX2Nvbm5lY3Rpb24uY29u
bmVjdGlvbi5ydW5Db21tYW5kKGNvbW1hbmRsaW5lKQogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMu
OC94bWxycGMvY2xpZW50LnB5IiwgbGluZSAxMTA5LCBpbiBfX2NhbGxfXwogICAgcmV0dXJuIHNl
bGYuX19zZW5kKHNlbGYuX19uYW1lLCBhcmdzKQogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMuOC94
bWxycGMvY2xpZW50LnB5IiwgbGluZSAxNDUwLCBpbiBfX3JlcXVlc3QKICAgIHJlc3BvbnNlID0g
c2VsZi5fX3RyYW5zcG9ydC5yZXF1ZXN0KAogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMuOC94bWxy
cGMvY2xpZW50LnB5IiwgbGluZSAxMTUzLCBpbiByZXF1ZXN0CiAgICByZXR1cm4gc2VsZi5zaW5n
bGVfcmVxdWVzdChob3N0LCBoYW5kbGVyLCByZXF1ZXN0X2JvZHksIHZlcmJvc2UpCiAgRmlsZSAi
L3Vzci9saWIvcHl0aG9uMy44L3htbHJwYy9jbGllbnQucHkiLCBsaW5lIDExNjksIGluIHNpbmds
ZV9yZXF1ZXN0CiAgICByZXR1cm4gc2VsZi5wYXJzZV9yZXNwb25zZShyZXNwKQogIEZpbGUgIi91
c3IvbGliL3B5dGhvbjMuOC94bWxycGMvY2xpZW50LnB5IiwgbGluZSAxMzQxLCBpbiBwYXJzZV9y
ZXNwb25zZQogICAgcmV0dXJuIHUuY2xvc2UoKQogIEZpbGUgIi91c3IvbGliL3B5dGhvbjMuOC94
bWxycGMvY2xpZW50LnB5IiwgbGluZSA2NTUsIGluIGNsb3NlCiAgICByYWlzZSBGYXVsdCgqKnNl
bGYuX3N0YWNrWzBdKQp4bWxycGMuY2xpZW50LkZhdWx0OiA8RmF1bHQgMTogIjxjbGFzcyAnVHlw
ZUVycm9yJz46Y2Fubm90IG1hcnNoYWwgPGNsYXNzICdjb2xsZWN0aW9ucy5kZWZhdWx0ZGljdCc+
IG9iamVjdHMiPgoKRHVyaW5nIGhhbmRsaW5nIG9mIHRoZSBhYm92ZSBleGNlcHRpb24sIGFub3Ro
ZXIgZXhjZXB0aW9uIG9jY3VycmVkOgoKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3Qp
OgogIEZpbGUgIi4vbWFpbi5weSIsIGxpbmUgNzIsIGluIDxtb2R1bGU+CiAgICBtYWluKCkKICBG
aWxlICIuL21haW4ucHkiLCBsaW5lIDUzLCBpbiBtYWluCiAgICByZXQgPSBjbGllbnQuZ2V0X3Jl
Y2lwZV9wYWNrYWdlcygpCiAgRmlsZSAiL2hvbWUveW9zdWtlL3dvcmsvZ2l0L2JiY2xpbnQvdGVz
dC9iYmNsaWVudC9iYmNsaWVudC5weSIsIGxpbmUgNDk4LCBpbiBnZXRfcmVjaXBlX3BhY2thZ2Vz
CiAgICByZXR1cm4gc2VsZi5fX3J1bl9jb21tYW5kKCAgIyB0eXBlOiBpZ25vcmUKICBGaWxlICIv
aG9tZS95b3N1a2Uvd29yay9naXQvYmJjbGludC90ZXN0L2JiY2xpZW50L2JiY2xpZW50LnB5Iiwg
bGluZSA4MDMsIGluIF9fcnVuX2NvbW1hbmQKICAgIHByaW50KHJlc3VsdCkKVW5ib3VuZExvY2Fs
RXJyb3I6IGxvY2FsIHZhcmlhYmxlICdyZXN1bHQnIHJlZmVyZW5jZWQgYmVmb3JlIGFzc2lnbm1l
bnQK

--JrRAYLabBftJqUlBM3EU--

