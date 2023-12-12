Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE0AC4167B
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 21:57:26 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.8911.1702418244221851527
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Dec 2023 13:57:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=YZQWwHCG;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 134CF9C279C;
	Tue, 12 Dec 2023 16:57:23 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id A-rbshxQkJ_q; Tue, 12 Dec 2023 16:57:19 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 6158A9C284E;
	Tue, 12 Dec 2023 16:57:19 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 6158A9C284E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702418239; bh=F2GHFRPrSBzd+iOZmsCwk5U99byhK1CMehxIylAa6ys=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=YZQWwHCGaBFfk3aHBRMDfNARGZe+vyTqBzh1/4jACmz81WCGpmrdFbfqP5xE+ChOa
	 +rmAmx7avPp0Vr/ueShn5Kf4PIM83RYMSzHWuJILc5BA9BtdwxtB3cAUCvXCAX9X0x
	 r7X4HunQNOkoZqjT4+nAtLivlY4m0XWqDNJ0Y0ESN4ffO/tDT+mvtjmamhwJzKBe1+
	 vl4c5CXobpud2oZXPpWn1lHbpwgkHxXkvzBx982mNfqYK7tguVeFGLcohNJ3SdTs74
	 10zzjK7ht+k/k0sQzCqTSTN5dVB1zQFtXD1kaApcdUtlPqi5tc5BXHAUzc1quDO9QC
	 8Kg6gaLLW35kw==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id zKRvwMSS2iXE; Tue, 12 Dec 2023 16:57:18 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id DDBF39C279C;
	Tue, 12 Dec 2023 16:57:17 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
Subject: [PATCH] toaster: Added dataTables library to include sorting and pagination for table element
Date: Tue, 12 Dec 2023 16:57:13 -0500
Message-Id: <20231212215713.235263-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Dec 2023 21:57:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15658

Added jquery.dataTables to customize table rendering in section "Import eve=
ntlogs".
This library includes the following: sorting, pagination, search and CSS st=
yles.

Signed-off-by: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfaire=
linux.com>
---
 .../static/css/jquery.dataTables-1.11.5.css   |   482 +
 .../static/js/jquery.dataTables-1.11.5.js     | 15336 ++++++++++++++++
 .../templates/command_line_builds.html        |     9 +-
 3 files changed, 15826 insertions(+), 1 deletion(-)
 create mode 100644 lib/toaster/toastergui/static/css/jquery.dataTables-1.1=
1.5.css
 create mode 100644 lib/toaster/toastergui/static/js/jquery.dataTables-1.11=
.5.js

diff --git a/lib/toaster/toastergui/static/css/jquery.dataTables-1.11.5.css=
 b/lib/toaster/toastergui/static/css/jquery.dataTables-1.11.5.css
new file mode 100644
index 00000000..46559651
--- /dev/null
+++ b/lib/toaster/toastergui/static/css/jquery.dataTables-1.11.5.css
@@ -0,0 +1,482 @@
+table.dataTable th.dt-left,
+table.dataTable td.dt-left {
+  text-align: left;
+}
+table.dataTable th.dt-center,
+table.dataTable td.dt-center,
+table.dataTable td.dataTables_empty {
+  text-align: center;
+}
+table.dataTable th.dt-right,
+table.dataTable td.dt-right {
+  text-align: right;
+}
+table.dataTable th.dt-justify,
+table.dataTable td.dt-justify {
+  text-align: justify;
+}
+table.dataTable th.dt-nowrap,
+table.dataTable td.dt-nowrap {
+  white-space: nowrap;
+}
+table.dataTable thead th.dt-head-left,
+table.dataTable thead td.dt-head-left,
+table.dataTable tfoot th.dt-head-left,
+table.dataTable tfoot td.dt-head-left {
+  text-align: left;
+}
+table.dataTable thead th.dt-head-center,
+table.dataTable thead td.dt-head-center,
+table.dataTable tfoot th.dt-head-center,
+table.dataTable tfoot td.dt-head-center {
+  text-align: center;
+}
+table.dataTable thead th.dt-head-right,
+table.dataTable thead td.dt-head-right,
+table.dataTable tfoot th.dt-head-right,
+table.dataTable tfoot td.dt-head-right {
+  text-align: right;
+}
+table.dataTable thead th.dt-head-justify,
+table.dataTable thead td.dt-head-justify,
+table.dataTable tfoot th.dt-head-justify,
+table.dataTable tfoot td.dt-head-justify {
+  text-align: justify;
+}
+table.dataTable thead th.dt-head-nowrap,
+table.dataTable thead td.dt-head-nowrap,
+table.dataTable tfoot th.dt-head-nowrap,
+table.dataTable tfoot td.dt-head-nowrap {
+  white-space: nowrap;
+}
+table.dataTable tbody th.dt-body-left,
+table.dataTable tbody td.dt-body-left {
+  text-align: left;
+}
+table.dataTable tbody th.dt-body-center,
+table.dataTable tbody td.dt-body-center {
+  text-align: center;
+}
+table.dataTable tbody th.dt-body-right,
+table.dataTable tbody td.dt-body-right {
+  text-align: right;
+}
+table.dataTable tbody th.dt-body-justify,
+table.dataTable tbody td.dt-body-justify {
+  text-align: justify;
+}
+table.dataTable tbody th.dt-body-nowrap,
+table.dataTable tbody td.dt-body-nowrap {
+  white-space: nowrap;
+}
+table.dataTable td.dt-control {
+  text-align: center;
+  cursor: pointer;
+}
+table.dataTable td.dt-control:before {
+  height: 1em;
+  width: 1em;
+  margin-top: -9px;
+  display: inline-block;
+  color: white;
+  border: 0.15em solid white;
+  border-radius: 1em;
+  box-shadow: 0 0 0.2em #444;
+  box-sizing: content-box;
+  text-align: center;
+  text-indent: 0 !important;
+  font-family: "Courier New", Courier, monospace;
+  line-height: 1em;
+  content: "+";
+  background-color: #31b131;
+}
+table.dataTable tr.dt-hasChild td.dt-control:before {
+  content: "-";
+  background-color: #d33333;
+}
+
+/*
+ * Table styles
+ */
+table.dataTable {
+  width: 100%;
+  margin: 0 auto;
+  clear: both;
+  border-collapse: separate;
+  border-spacing: 0;
+  /*
+   * Header and footer styles
+   */
+  /*
+   * Body styles
+   */
+}
+table.dataTable thead th,
+table.dataTable tfoot th {
+  font-weight: bold;
+}
+table.dataTable thead th,
+table.dataTable thead td {
+  padding: 10px 18px;
+  border-bottom: 1px solid #111;
+}
+table.dataTable thead th:active,
+table.dataTable thead td:active {
+  outline: none;
+}
+table.dataTable tfoot th,
+table.dataTable tfoot td {
+  padding: 10px 18px 6px 18px;
+  border-top: 1px solid #111;
+}
+table.dataTable thead .sorting,
+table.dataTable thead .sorting_asc,
+table.dataTable thead .sorting_desc,
+table.dataTable thead .sorting_asc_disabled,
+table.dataTable thead .sorting_desc_disabled {
+  cursor: pointer;
+  *cursor: hand;
+  background-repeat: no-repeat;
+  background-position: center right;
+}
+table.dataTable thead .sorting {
+  background-image: url("../images/sort_both.png");
+}
+table.dataTable thead .sorting_asc {
+  background-image: url("../images/sort_asc.png") !important;
+}
+table.dataTable thead .sorting_desc {
+  background-image: url("../images/sort_desc.png") !important;
+}
+table.dataTable thead .sorting_asc_disabled {
+  background-image: url("../images/sort_asc_disabled.png");
+}
+table.dataTable thead .sorting_desc_disabled {
+  background-image: url("../images/sort_desc_disabled.png");
+}
+table.dataTable tbody tr {
+  background-color: #ffffff;
+}
+table.dataTable tbody tr.selected {
+  background-color: #B0BED9;
+}
+table.dataTable tbody th,
+table.dataTable tbody td {
+  padding: 8px 10px;
+}
+table.dataTable.row-border tbody th, table.dataTable.row-border tbody td, =
table.dataTable.display tbody th, table.dataTable.display tbody td {
+  border-top: 1px solid #ddd;
+}
+table.dataTable.row-border tbody tr:first-child th,
+table.dataTable.row-border tbody tr:first-child td, table.dataTable.displa=
y tbody tr:first-child th,
+table.dataTable.display tbody tr:first-child td {
+  border-top: none;
+}
+table.dataTable.cell-border tbody th, table.dataTable.cell-border tbody td=
 {
+  border-top: 1px solid #ddd;
+  border-right: 1px solid #ddd;
+}
+table.dataTable.cell-border tbody tr th:first-child,
+table.dataTable.cell-border tbody tr td:first-child {
+  border-left: 1px solid #ddd;
+}
+table.dataTable.cell-border tbody tr:first-child th,
+table.dataTable.cell-border tbody tr:first-child td {
+  border-top: none;
+}
+table.dataTable.stripe tbody tr.odd, table.dataTable.display tbody tr.odd {
+  background-color: #f9f9f9;
+}
+table.dataTable.stripe tbody tr.odd.selected, table.dataTable.display tbod=
y tr.odd.selected {
+  background-color: #acbad4;
+}
+table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hov=
er {
+  background-color: #f6f6f6;
+}
+table.dataTable.hover tbody tr:hover.selected, table.dataTable.display tbo=
dy tr:hover.selected {
+  background-color: #aab7d1;
+}
+table.dataTable.order-column tbody tr > .sorting_1,
+table.dataTable.order-column tbody tr > .sorting_2,
+table.dataTable.order-column tbody tr > .sorting_3, table.dataTable.displa=
y tbody tr > .sorting_1,
+table.dataTable.display tbody tr > .sorting_2,
+table.dataTable.display tbody tr > .sorting_3 {
+  background-color: #fafafa;
+}
+table.dataTable.order-column tbody tr.selected > .sorting_1,
+table.dataTable.order-column tbody tr.selected > .sorting_2,
+table.dataTable.order-column tbody tr.selected > .sorting_3, table.dataTab=
le.display tbody tr.selected > .sorting_1,
+table.dataTable.display tbody tr.selected > .sorting_2,
+table.dataTable.display tbody tr.selected > .sorting_3 {
+  background-color: #acbad5;
+}
+table.dataTable.display tbody tr.odd > .sorting_1, table.dataTable.order-c=
olumn.stripe tbody tr.odd > .sorting_1 {
+  background-color: #f1f1f1;
+}
+table.dataTable.display tbody tr.odd > .sorting_2, table.dataTable.order-c=
olumn.stripe tbody tr.odd > .sorting_2 {
+  background-color: #f3f3f3;
+}
+table.dataTable.display tbody tr.odd > .sorting_3, table.dataTable.order-c=
olumn.stripe tbody tr.odd > .sorting_3 {
+  background-color: whitesmoke;
+}
+table.dataTable.display tbody tr.odd.selected > .sorting_1, table.dataTabl=
e.order-column.stripe tbody tr.odd.selected > .sorting_1 {
+  background-color: #a6b4cd;
+}
+table.dataTable.display tbody tr.odd.selected > .sorting_2, table.dataTabl=
e.order-column.stripe tbody tr.odd.selected > .sorting_2 {
+  background-color: #a8b5cf;
+}
+table.dataTable.display tbody tr.odd.selected > .sorting_3, table.dataTabl=
e.order-column.stripe tbody tr.odd.selected > .sorting_3 {
+  background-color: #a9b7d1;
+}
+table.dataTable.display tbody tr.even > .sorting_1, table.dataTable.order-=
column.stripe tbody tr.even > .sorting_1 {
+  background-color: #fafafa;
+}
+table.dataTable.display tbody tr.even > .sorting_2, table.dataTable.order-=
column.stripe tbody tr.even > .sorting_2 {
+  background-color: #fcfcfc;
+}
+table.dataTable.display tbody tr.even > .sorting_3, table.dataTable.order-=
column.stripe tbody tr.even > .sorting_3 {
+  background-color: #fefefe;
+}
+table.dataTable.display tbody tr.even.selected > .sorting_1, table.dataTab=
le.order-column.stripe tbody tr.even.selected > .sorting_1 {
+  background-color: #acbad5;
+}
+table.dataTable.display tbody tr.even.selected > .sorting_2, table.dataTab=
le.order-column.stripe tbody tr.even.selected > .sorting_2 {
+  background-color: #aebcd6;
+}
+table.dataTable.display tbody tr.even.selected > .sorting_3, table.dataTab=
le.order-column.stripe tbody tr.even.selected > .sorting_3 {
+  background-color: #afbdd8;
+}
+table.dataTable.display tbody tr:hover > .sorting_1, table.dataTable.order=
-column.hover tbody tr:hover > .sorting_1 {
+  background-color: #eaeaea;
+}
+table.dataTable.display tbody tr:hover > .sorting_2, table.dataTable.order=
-column.hover tbody tr:hover > .sorting_2 {
+  background-color: #ececec;
+}
+table.dataTable.display tbody tr:hover > .sorting_3, table.dataTable.order=
-column.hover tbody tr:hover > .sorting_3 {
+  background-color: #efefef;
+}
+table.dataTable.display tbody tr:hover.selected > .sorting_1, table.dataTa=
ble.order-column.hover tbody tr:hover.selected > .sorting_1 {
+  background-color: #a2aec7;
+}
+table.dataTable.display tbody tr:hover.selected > .sorting_2, table.dataTa=
ble.order-column.hover tbody tr:hover.selected > .sorting_2 {
+  background-color: #a3b0c9;
+}
+table.dataTable.display tbody tr:hover.selected > .sorting_3, table.dataTa=
ble.order-column.hover tbody tr:hover.selected > .sorting_3 {
+  background-color: #a5b2cb;
+}
+table.dataTable.no-footer {
+  border-bottom: 1px solid #111;
+}
+table.dataTable.nowrap th, table.dataTable.nowrap td {
+  white-space: nowrap;
+}
+table.dataTable.compact thead th,
+table.dataTable.compact thead td {
+  padding: 4px 17px;
+}
+table.dataTable.compact tfoot th,
+table.dataTable.compact tfoot td {
+  padding: 4px;
+}
+table.dataTable.compact tbody th,
+table.dataTable.compact tbody td {
+  padding: 4px;
+}
+
+table.dataTable th,
+table.dataTable td {
+  box-sizing: content-box;
+}
+
+/*
+ * Control feature layout
+ */
+.dataTables_wrapper {
+  position: relative;
+  clear: both;
+}
+.dataTables_wrapper .dataTables_length {
+  float: left;
+}
+.dataTables_wrapper .dataTables_length select {
+  border: 1px solid #aaa;
+  border-radius: 3px;
+  padding: 5px;
+  background-color: transparent;
+  padding: 4px;
+}
+.dataTables_wrapper .dataTables_filter {
+  float: right;
+  text-align: right;
+}
+.dataTables_wrapper .dataTables_filter input {
+  border: 1px solid #aaa;
+  border-radius: 3px;
+  padding: 5px;
+  background-color: transparent;
+  margin-left: 3px;
+}
+.dataTables_wrapper .dataTables_info {
+  clear: both;
+  float: left;
+  padding-top: 0.755em;
+}
+.dataTables_wrapper .dataTables_paginate {
+  float: right;
+  text-align: right;
+  padding-top: 0.25em;
+}
+.dataTables_wrapper .dataTables_paginate .paginate_button {
+  box-sizing: border-box;
+  display: inline-block;
+  min-width: 1.5em;
+  padding: 0.5em 1em;
+  margin-left: 2px;
+  text-align: center;
+  text-decoration: none !important;
+  cursor: pointer;
+  *cursor: hand;
+  color: #333 !important;
+  border: 1px solid transparent;
+  border-radius: 2px;
+}
+.dataTables_wrapper .dataTables_paginate .paginate_button.current, .dataTa=
bles_wrapper .dataTables_paginate .paginate_button.current:hover {
+  color: #333 !important;
+  border: 1px solid #979797;
+  background-color: white;
+  background: -webkit-gradient(linear, left top, left bottom, color-stop(0=
%, white), color-stop(100%, #dcdcdc));
+  /* Chrome,Safari4+ */
+  background: -webkit-linear-gradient(top, white 0%, #dcdcdc 100%);
+  /* Chrome10+,Safari5.1+ */
+  background: -moz-linear-gradient(top, white 0%, #dcdcdc 100%);
+  /* FF3.6+ */
+  background: -ms-linear-gradient(top, white 0%, #dcdcdc 100%);
+  /* IE10+ */
+  background: -o-linear-gradient(top, white 0%, #dcdcdc 100%);
+  /* Opera 11.10+ */
+  background: linear-gradient(to bottom, white 0%, #dcdcdc 100%);
+  /* W3C */
+}
+.dataTables_wrapper .dataTables_paginate .paginate_button.disabled, .dataT=
ables_wrapper .dataTables_paginate .paginate_button.disabled:hover, .dataTa=
bles_wrapper .dataTables_paginate .paginate_button.disabled:active {
+  cursor: default;
+  color: #666 !important;
+  border: 1px solid transparent;
+  background: transparent;
+  box-shadow: none;
+}
+.dataTables_wrapper .dataTables_paginate .paginate_button:hover {
+  color: white !important;
+  border: 1px solid #111;
+  background-color: #585858;
+  background: -webkit-gradient(linear, left top, left bottom, color-stop(0=
%, #585858), color-stop(100%, #111));
+  /* Chrome,Safari4+ */
+  background: -webkit-linear-gradient(top, #585858 0%, #111 100%);
+  /* Chrome10+,Safari5.1+ */
+  background: -moz-linear-gradient(top, #585858 0%, #111 100%);
+  /* FF3.6+ */
+  background: -ms-linear-gradient(top, #585858 0%, #111 100%);
+  /* IE10+ */
+  background: -o-linear-gradient(top, #585858 0%, #111 100%);
+  /* Opera 11.10+ */
+  background: linear-gradient(to bottom, #585858 0%, #111 100%);
+  /* W3C */
+}
+.dataTables_wrapper .dataTables_paginate .paginate_button:active {
+  outline: none;
+  background-color: #2b2b2b;
+  background: -webkit-gradient(linear, left top, left bottom, color-stop(0=
%, #2b2b2b), color-stop(100%, #0c0c0c));
+  /* Chrome,Safari4+ */
+  background: -webkit-linear-gradient(top, #2b2b2b 0%, #0c0c0c 100%);
+  /* Chrome10+,Safari5.1+ */
+  background: -moz-linear-gradient(top, #2b2b2b 0%, #0c0c0c 100%);
+  /* FF3.6+ */
+  background: -ms-linear-gradient(top, #2b2b2b 0%, #0c0c0c 100%);
+  /* IE10+ */
+  background: -o-linear-gradient(top, #2b2b2b 0%, #0c0c0c 100%);
+  /* Opera 11.10+ */
+  background: linear-gradient(to bottom, #2b2b2b 0%, #0c0c0c 100%);
+  /* W3C */
+  box-shadow: inset 0 0 3px #111;
+}
+.dataTables_wrapper .dataTables_paginate .ellipsis {
+  padding: 0 1em;
+}
+.dataTables_wrapper .dataTables_processing {
+  position: absolute;
+  top: 50%;
+  left: 50%;
+  width: 100%;
+  height: 40px;
+  margin-left: -50%;
+  margin-top: -25px;
+  padding-top: 20px;
+  text-align: center;
+  font-size: 1.2em;
+  background-color: white;
+  background: -webkit-gradient(linear, left top, right top, color-stop(0%,=
 rgba(255, 255, 255, 0)), color-stop(25%, rgba(255, 255, 255, 0.9)), color-=
stop(75%, rgba(255, 255, 255, 0.9)), color-stop(100%, rgba(255, 255, 255, 0=
)));
+  background: -webkit-linear-gradient(left, rgba(255, 255, 255, 0) 0%, rgb=
a(255, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%, rgba(255, 255, 255=
, 0) 100%);
+  background: -moz-linear-gradient(left, rgba(255, 255, 255, 0) 0%, rgba(2=
55, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%, rgba(255, 255, 255, 0=
) 100%);
+  background: -ms-linear-gradient(left, rgba(255, 255, 255, 0) 0%, rgba(25=
5, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%, rgba(255, 255, 255, 0)=
 100%);
+  background: -o-linear-gradient(left, rgba(255, 255, 255, 0) 0%, rgba(255=
, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%, rgba(255, 255, 255, 0) =
100%);
+  background: linear-gradient(to right, rgba(255, 255, 255, 0) 0%, rgba(25=
5, 255, 255, 0.9) 25%, rgba(255, 255, 255, 0.9) 75%, rgba(255, 255, 255, 0)=
 100%);
+}
+.dataTables_wrapper .dataTables_length,
+.dataTables_wrapper .dataTables_filter,
+.dataTables_wrapper .dataTables_info,
+.dataTables_wrapper .dataTables_processing,
+.dataTables_wrapper .dataTables_paginate {
+  color: #333;
+}
+.dataTables_wrapper .dataTables_scroll {
+  clear: both;
+}
+.dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody {
+  *margin-top: -1px;
+  -webkit-overflow-scrolling: touch;
+}
+.dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody > table >=
 thead > tr > th, .dataTables_wrapper .dataTables_scroll div.dataTables_scr=
ollBody > table > thead > tr > td, .dataTables_wrapper .dataTables_scroll d=
iv.dataTables_scrollBody > table > tbody > tr > th, .dataTables_wrapper .da=
taTables_scroll div.dataTables_scrollBody > table > tbody > tr > td {
+  vertical-align: middle;
+}
+.dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody > table >=
 thead > tr > th > div.dataTables_sizing,
+.dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody > table >=
 thead > tr > td > div.dataTables_sizing, .dataTables_wrapper .dataTables_s=
croll div.dataTables_scrollBody > table > tbody > tr > th > div.dataTables_=
sizing,
+.dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody > table >=
 tbody > tr > td > div.dataTables_sizing {
+  height: 0;
+  overflow: hidden;
+  margin: 0 !important;
+  padding: 0 !important;
+}
+.dataTables_wrapper.no-footer .dataTables_scrollBody {
+  border-bottom: 1px solid #111;
+}
+.dataTables_wrapper.no-footer div.dataTables_scrollHead table.dataTable,
+.dataTables_wrapper.no-footer div.dataTables_scrollBody > table {
+  border-bottom: none;
+}
+.dataTables_wrapper:after {
+  visibility: hidden;
+  display: block;
+  content: "";
+  clear: both;
+  height: 0;
+}
+
+@media screen and (max-width: 767px) {
+  .dataTables_wrapper .dataTables_info,
+.dataTables_wrapper .dataTables_paginate {
+    float: none;
+    text-align: center;
+  }
+  .dataTables_wrapper .dataTables_paginate {
+    margin-top: 0.5em;
+  }
+}
+@media screen and (max-width: 640px) {
+  .dataTables_wrapper .dataTables_length,
+.dataTables_wrapper .dataTables_filter {
+    float: none;
+    text-align: center;
+  }
+  .dataTables_wrapper .dataTables_filter {
+    margin-top: 0.5em;
+  }
+}
diff --git a/lib/toaster/toastergui/static/js/jquery.dataTables-1.11.5.js b=
/lib/toaster/toastergui/static/js/jquery.dataTables-1.11.5.js
new file mode 100644
index 00000000..b1d556aa
--- /dev/null
+++ b/lib/toaster/toastergui/static/js/jquery.dataTables-1.11.5.js
@@ -0,0 +1,15336 @@
+/*! DataTables 1.11.5
+ * =C2=A92008-2021 SpryMedia Ltd - datatables.net/license
+ */
+
+/**
+ * @summary     DataTables
+ * @description Paginate, search and order HTML tables
+ * @version     1.11.5
+ * @file        jquery.dataTables.js
+ * @author      SpryMedia Ltd
+ * @contact     www.datatables.net
+ * @copyright   Copyright 2008-2021 SpryMedia Ltd.
+ *
+ * This source file is free software, available under the following licens=
e:
+ *   MIT license - http://datatables.net/license
+ *
+ * This source file is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABIL=
ITY
+ * or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.
+ *
+ * For details please refer to: http://www.datatables.net
+ */
+
+/*jslint evil: true, undef: true, browser: true */
+/*globals $,require,jQuery,define,_selector_run,_selector_opts,_selector_f=
irst,_selector_row_indexes,_ext,_Api,_api_register,_api_registerPlural,_re_=
new_lines,_re_html,_re_formatted_numeric,_re_escape_regex,_empty,_intVal,_n=
umToDecimal,_isNumber,_isHtml,_htmlNumeric,_pluck,_pluck_order,_range,_stri=
pHtml,_unique,_fnBuildAjax,_fnAjaxUpdate,_fnAjaxParameters,_fnAjaxUpdateDra=
w,_fnAjaxDataSrc,_fnAddColumn,_fnColumnOptions,_fnAdjustColumnSizing,_fnVis=
ibleToColumnIndex,_fnColumnIndexToVisible,_fnVisbleColumns,_fnGetColumns,_f=
nColumnTypes,_fnApplyColumnDefs,_fnHungarianMap,_fnCamelToHungarian,_fnLang=
uageCompat,_fnBrowserDetect,_fnAddData,_fnAddTr,_fnNodeToDataIndex,_fnNodeT=
oColumnIndex,_fnGetCellData,_fnSetCellData,_fnSplitObjNotation,_fnGetObject=
DataFn,_fnSetObjectDataFn,_fnGetDataMaster,_fnClearTable,_fnDeleteIndex,_fn=
Invalidate,_fnGetRowElements,_fnCreateTr,_fnBuildHead,_fnDrawHead,_fnDraw,_=
fnReDraw,_fnAddOptionsHtml,_fnDetectHeader,_fnGetUniqueThs,_fnFeatureHtmlFi=
lter,_fnFilterComplete,_fnFilterCustom,_fnFilterColumn,_fnFilter,_fnFilterC=
reateSearch,_fnEscapeRegex,_fnFilterData,_fnFeatureHtmlInfo,_fnUpdateInfo,_=
fnInfoMacros,_fnInitialise,_fnInitComplete,_fnLengthChange,_fnFeatureHtmlLe=
ngth,_fnFeatureHtmlPaginate,_fnPageChange,_fnFeatureHtmlProcessing,_fnProce=
ssingDisplay,_fnFeatureHtmlTable,_fnScrollDraw,_fnApplyToChildren,_fnCalcul=
ateColumnWidths,_fnThrottle,_fnConvertToWidth,_fnGetWidestNode,_fnGetMaxLen=
String,_fnStringToCss,_fnSortFlatten,_fnSort,_fnSortAria,_fnSortListener,_f=
nSortAttachListener,_fnSortingClasses,_fnSortData,_fnSaveState,_fnLoadState=
,_fnSettingsFromNode,_fnLog,_fnMap,_fnBindAction,_fnCallbackReg,_fnCallback=
Fire,_fnLengthOverflow,_fnRenderer,_fnDataSource,_fnRowAttributes*/
+
+(function( factory ) {
+	"use strict";
+
+	if ( typeof define =3D=3D=3D 'function' && define.amd ) {
+		// AMD
+		define( ['jquery'], function ( $ ) {
+			return factory( $, window, document );
+		} );
+	}
+	else if ( typeof exports =3D=3D=3D 'object' ) {
+		// CommonJS
+		module.exports =3D function (root, $) {
+			if ( ! root ) {
+				// CommonJS environments without a window global must pass a
+				// root. This will give an error otherwise
+				root =3D window;
+			}
+
+			if ( ! $ ) {
+				$ =3D typeof window !=3D=3D 'undefined' ? // jQuery's factory checks f=
or a global window
+					require('jquery') :
+					require('jquery')( root );
+			}
+
+			return factory( $, root, root.document );
+		};
+	}
+	else {
+		// Browser
+		window.DataTable =3D factory( jQuery, window, document );
+	}
+}
+(function( $, window, document, undefined ) {
+	"use strict";
+
+=09
+	var DataTable =3D function ( selector, options )
+	{
+		// When creating with `new`, create a new DataTable, returning the API i=
nstance
+		if (this instanceof DataTable) {
+			return $(selector).DataTable(options);
+		}
+		else {
+			// Argument switching
+			options =3D selector;
+		}
+=09
+		/**
+		 * Perform a jQuery selector action on the table's TR elements (from the=
 tbody) and
+		 * return the resulting jQuery object.
+		 *  @param {string|node|jQuery} sSelector jQuery selector or node collec=
tion to act on
+		 *  @param {object} [oOpts] Optional parameters for modifying the rows t=
o be included
+		 *  @param {string} [oOpts.filter=3Dnone] Select TR elements that meet t=
he current filter
+		 *    criterion ("applied") or all TR elements (i.e. no filter).
+		 *  @param {string} [oOpts.order=3Dcurrent] Order of the TR elements in =
the processed array.
+		 *    Can be either 'current', whereby the current sorting of the table =
is used, or
+		 *    'original' whereby the original order the data was read into the t=
able is used.
+		 *  @param {string} [oOpts.page=3Dall] Limit the selection to the curren=
tly displayed page
+		 *    ("current") or not ("all"). If 'current' is given, then order is a=
ssumed to be
+		 *    'current' and filter is 'applied', regardless of what they might b=
e given as.
+		 *  @returns {object} jQuery object, filtered by the given selector.
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Highlight every second row
+		 *      oTable.$('tr:odd').css('backgroundColor', 'blue');
+		 *    } );
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Filter to rows with 'Webkit' in them, add a background colour=
 and then
+		 *      // remove the filter, thus highlighting the 'Webkit' rows only.
+		 *      oTable.fnFilter('Webkit');
+		 *      oTable.$('tr', {"search": "applied"}).css('backgroundColor', 'bl=
ue');
+		 *      oTable.fnFilter('');
+		 *    } );
+		 */
+		this.$ =3D function ( sSelector, oOpts )
+		{
+			return this.api(true).$( sSelector, oOpts );
+		};
+=09=09
+=09=09
+		/**
+		 * Almost identical to $ in operation, but in this case returns the data=
 for the matched
+		 * rows - as such, the jQuery selector used should match TR row nodes or=
 TD/TH cell nodes
+		 * rather than any descendants, so the data can be obtained for the row/=
cell. If matching
+		 * rows are found, the data returned is the original data array/object t=
hat was used to
+		 * create the row (or a generated array if from a DOM source).
+		 *
+		 * This method is often useful in-combination with $ where both function=
s are given the
+		 * same parameters and the array indexes will match identically.
+		 *  @param {string|node|jQuery} sSelector jQuery selector or node collec=
tion to act on
+		 *  @param {object} [oOpts] Optional parameters for modifying the rows t=
o be included
+		 *  @param {string} [oOpts.filter=3Dnone] Select elements that meet the =
current filter
+		 *    criterion ("applied") or all elements (i.e. no filter).
+		 *  @param {string} [oOpts.order=3Dcurrent] Order of the data in the pro=
cessed array.
+		 *    Can be either 'current', whereby the current sorting of the table =
is used, or
+		 *    'original' whereby the original order the data was read into the t=
able is used.
+		 *  @param {string} [oOpts.page=3Dall] Limit the selection to the curren=
tly displayed page
+		 *    ("current") or not ("all"). If 'current' is given, then order is a=
ssumed to be
+		 *    'current' and filter is 'applied', regardless of what they might b=
e given as.
+		 *  @returns {array} Data for the matched elements. If any elements, as =
a result of the
+		 *    selector, were not TR, TD or TH elements in the DataTable, they wi=
ll have a null
+		 *    entry in the array.
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Get the data from the first row in the table
+		 *      var data =3D oTable._('tr:first');
+		 *
+		 *      // Do something useful with the data
+		 *      alert( "First cell is: "+data[0] );
+		 *    } );
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Filter to 'Webkit' and get all data for
+		 *      oTable.fnFilter('Webkit');
+		 *      var data =3D oTable._('tr', {"search": "applied"});
+		 *
+		 *      // Do something with the data
+		 *      alert( data.length+" rows matched the search" );
+		 *    } );
+		 */
+		this._ =3D function ( sSelector, oOpts )
+		{
+			return this.api(true).rows( sSelector, oOpts ).data();
+		};
+=09=09
+=09=09
+		/**
+		 * Create a DataTables Api instance, with the currently selected tables =
for
+		 * the Api's context.
+		 * @param {boolean} [traditional=3Dfalse] Set the API instance's context=
 to be
+		 *   only the table referred to by the `DataTable.ext.iApiIndex` option,=
 as was
+		 *   used in the API presented by DataTables 1.9- (i.e. the traditional =
mode),
+		 *   or if all tables captured in the jQuery object should be used.
+		 * @return {DataTables.Api}
+		 */
+		this.api =3D function ( traditional )
+		{
+			return traditional ?
+				new _Api(
+					_fnSettingsFromNode( this[ _ext.iApiIndex ] )
+				) :
+				new _Api( this );
+		};
+=09=09
+=09=09
+		/**
+		 * Add a single new row or multiple rows of data to the table. Please no=
te
+		 * that this is suitable for client-side processing only - if you are us=
ing
+		 * server-side processing (i.e. "bServerSide": true), then to add data, =
you
+		 * must add it to the data source, i.e. the server-side, through an Ajax=
 call.
+		 *  @param {array|object} data The data to be added to the table. This c=
an be:
+		 *    <ul>
+		 *      <li>1D array of data - add a single row with the data provided</=
li>
+		 *      <li>2D array of arrays - add multiple rows in a single call</li>
+		 *      <li>object - data object when using <i>mData</i></li>
+		 *      <li>array of objects - multiple data objects when using <i>mData=
</i></li>
+		 *    </ul>
+		 *  @param {bool} [redraw=3Dtrue] redraw the table or not
+		 *  @returns {array} An array of integers, representing the list of inde=
xes in
+		 *    <i>aoData</i> ({@link DataTable.models.oSettings}) that have been =
added to
+		 *    the table.
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    // Global var for counter
+		 *    var giCount =3D 2;
+		 *
+		 *    $(document).ready(function() {
+		 *      $('#example').dataTable();
+		 *    } );
+		 *
+		 *    function fnClickAddRow() {
+		 *      $('#example').dataTable().fnAddData( [
+		 *        giCount+".1",
+		 *        giCount+".2",
+		 *        giCount+".3",
+		 *        giCount+".4" ]
+		 *      );
+		 *
+		 *      giCount++;
+		 *    }
+		 */
+		this.fnAddData =3D function( data, redraw )
+		{
+			var api =3D this.api( true );
+=09=09
+			/* Check if we want to add multiple rows or not */
+			var rows =3D Array.isArray(data) && ( Array.isArray(data[0]) || $.isPla=
inObject(data[0]) ) ?
+				api.rows.add( data ) :
+				api.row.add( data );
+=09=09
+			if ( redraw =3D=3D=3D undefined || redraw ) {
+				api.draw();
+			}
+=09=09
+			return rows.flatten().toArray();
+		};
+=09=09
+=09=09
+		/**
+		 * This function will make DataTables recalculate the column sizes, base=
d on the data
+		 * contained in the table and the sizes applied to the columns (in the D=
OM, CSS or
+		 * through the sWidth parameter). This can be useful when the width of t=
he table's
+		 * parent element changes (for example a window resize).
+		 *  @param {boolean} [bRedraw=3Dtrue] Redraw the table or not, you will =
typically want to
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable( {
+		 *        "sScrollY": "200px",
+		 *        "bPaginate": false
+		 *      } );
+		 *
+		 *      $(window).on('resize', function () {
+		 *        oTable.fnAdjustColumnSizing();
+		 *      } );
+		 *    } );
+		 */
+		this.fnAdjustColumnSizing =3D function ( bRedraw )
+		{
+			var api =3D this.api( true ).columns.adjust();
+			var settings =3D api.settings()[0];
+			var scroll =3D settings.oScroll;
+=09=09
+			if ( bRedraw =3D=3D=3D undefined || bRedraw ) {
+				api.draw( false );
+			}
+			else if ( scroll.sX !=3D=3D "" || scroll.sY !=3D=3D "" ) {
+				/* If not redrawing, but scrolling, we want to apply the new column si=
zes anyway */
+				_fnScrollDraw( settings );
+			}
+		};
+=09=09
+=09=09
+		/**
+		 * Quickly and simply clear a table
+		 *  @param {bool} [bRedraw=3Dtrue] redraw the table or not
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Immediately 'nuke' the current rows (perhaps waiting for an A=
jax callback...)
+		 *      oTable.fnClearTable();
+		 *    } );
+		 */
+		this.fnClearTable =3D function( bRedraw )
+		{
+			var api =3D this.api( true ).clear();
+=09=09
+			if ( bRedraw =3D=3D=3D undefined || bRedraw ) {
+				api.draw();
+			}
+		};
+=09=09
+=09=09
+		/**
+		 * The exact opposite of 'opening' a row, this function will close any r=
ows which
+		 * are currently 'open'.
+		 *  @param {node} nTr the table row to 'close'
+		 *  @returns {int} 0 on success, or 1 if failed (can't find the row)
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable;
+		 *
+		 *      // 'open' an information row when a row is clicked on
+		 *      $('#example tbody tr').click( function () {
+		 *        if ( oTable.fnIsOpen(this) ) {
+		 *          oTable.fnClose( this );
+		 *        } else {
+		 *          oTable.fnOpen( this, "Temporary row opened", "info_row" );
+		 *        }
+		 *      } );
+		 *
+		 *      oTable =3D $('#example').dataTable();
+		 *    } );
+		 */
+		this.fnClose =3D function( nTr )
+		{
+			this.api( true ).row( nTr ).child.hide();
+		};
+=09=09
+=09=09
+		/**
+		 * Remove a row for the table
+		 *  @param {mixed} target The index of the row from aoData to be deleted=
, or
+		 *    the TR element you want to delete
+		 *  @param {function|null} [callBack] Callback function
+		 *  @param {bool} [redraw=3Dtrue] Redraw the table or not
+		 *  @returns {array} The row that was deleted
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Immediately remove the first row
+		 *      oTable.fnDeleteRow( 0 );
+		 *    } );
+		 */
+		this.fnDeleteRow =3D function( target, callback, redraw )
+		{
+			var api =3D this.api( true );
+			var rows =3D api.rows( target );
+			var settings =3D rows.settings()[0];
+			var data =3D settings.aoData[ rows[0][0] ];
+=09=09
+			rows.remove();
+=09=09
+			if ( callback ) {
+				callback.call( this, settings, data );
+			}
+=09=09
+			if ( redraw =3D=3D=3D undefined || redraw ) {
+				api.draw();
+			}
+=09=09
+			return data;
+		};
+=09=09
+=09=09
+		/**
+		 * Restore the table to it's original state in the DOM by removing all o=
f DataTables
+		 * enhancements, alterations to the DOM structure of the table and event=
 listeners.
+		 *  @param {boolean} [remove=3Dfalse] Completely remove the table from t=
he DOM
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      // This example is fairly pointless in reality, but shows how fn=
Destroy can be used
+		 *      var oTable =3D $('#example').dataTable();
+		 *      oTable.fnDestroy();
+		 *    } );
+		 */
+		this.fnDestroy =3D function ( remove )
+		{
+			this.api( true ).destroy( remove );
+		};
+=09=09
+=09=09
+		/**
+		 * Redraw the table
+		 *  @param {bool} [complete=3Dtrue] Re-filter and resort (if enabled) th=
e table before the draw.
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Re-draw the table - you wouldn't want to do it here, but it's=
 an example :-)
+		 *      oTable.fnDraw();
+		 *    } );
+		 */
+		this.fnDraw =3D function( complete )
+		{
+			// Note that this isn't an exact match to the old call to _fnDraw - it =
takes
+			// into account the new data, but can hold position.
+			this.api( true ).draw( complete );
+		};
+=09=09
+=09=09
+		/**
+		 * Filter the input based on data
+		 *  @param {string} sInput String to filter the table on
+		 *  @param {int|null} [iColumn] Column to limit filtering to
+		 *  @param {bool} [bRegex=3Dfalse] Treat as regular expression or not
+		 *  @param {bool} [bSmart=3Dtrue] Perform smart filtering or not
+		 *  @param {bool} [bShowGlobal=3Dtrue] Show the input global filter in i=
t's input box(es)
+		 *  @param {bool} [bCaseInsensitive=3Dtrue] Do case-insensitive matching=
 (true) or not (false)
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Sometime later - filter...
+		 *      oTable.fnFilter( 'test string' );
+		 *    } );
+		 */
+		this.fnFilter =3D function( sInput, iColumn, bRegex, bSmart, bShowGlobal=
, bCaseInsensitive )
+		{
+			var api =3D this.api( true );
+=09=09
+			if ( iColumn =3D=3D=3D null || iColumn =3D=3D=3D undefined ) {
+				api.search( sInput, bRegex, bSmart, bCaseInsensitive );
+			}
+			else {
+				api.column( iColumn ).search( sInput, bRegex, bSmart, bCaseInsensitive=
 );
+			}
+=09=09
+			api.draw();
+		};
+=09=09
+=09=09
+		/**
+		 * Get the data for the whole table, an individual row or an individual =
cell based on the
+		 * provided parameters.
+		 *  @param {int|node} [src] A TR row node, TD/TH cell node or an integer=
. If given as
+		 *    a TR node then the data source for the whole row will be returned.=
 If given as a
+		 *    TD/TH cell node then iCol will be automatically calculated and the=
 data for the
+		 *    cell returned. If given as an integer, then this is treated as the=
 aoData internal
+		 *    data index for the row (see fnGetPosition) and the data for that r=
ow used.
+		 *  @param {int} [col] Optional column index that you want the data of.
+		 *  @returns {array|object|string} If mRow is undefined, then the data f=
or all rows is
+		 *    returned. If mRow is defined, just data for that row, and is iCol =
is
+		 *    defined, only data for the designated cell is returned.
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    // Row data
+		 *    $(document).ready(function() {
+		 *      oTable =3D $('#example').dataTable();
+		 *
+		 *      oTable.$('tr').click( function () {
+		 *        var data =3D oTable.fnGetData( this );
+		 *        // ... do something with the array / object of data for the row
+		 *      } );
+		 *    } );
+		 *
+		 *  @example
+		 *    // Individual cell data
+		 *    $(document).ready(function() {
+		 *      oTable =3D $('#example').dataTable();
+		 *
+		 *      oTable.$('td').click( function () {
+		 *        var sData =3D oTable.fnGetData( this );
+		 *        alert( 'The cell clicked on had the value of '+sData );
+		 *      } );
+		 *    } );
+		 */
+		this.fnGetData =3D function( src, col )
+		{
+			var api =3D this.api( true );
+=09=09
+			if ( src !=3D=3D undefined ) {
+				var type =3D src.nodeName ? src.nodeName.toLowerCase() : '';
+=09=09
+				return col !=3D=3D undefined || type =3D=3D 'td' || type =3D=3D 'th' ?
+					api.cell( src, col ).data() :
+					api.row( src ).data() || null;
+			}
+=09=09
+			return api.data().toArray();
+		};
+=09=09
+=09=09
+		/**
+		 * Get an array of the TR nodes that are used in the table's body. Note =
that you will
+		 * typically want to use the '$' API method in preference to this as it =
is more
+		 * flexible.
+		 *  @param {int} [iRow] Optional row index for the TR element you want
+		 *  @returns {array|node} If iRow is undefined, returns an array of all =
TR elements
+		 *    in the table's body, or iRow is defined, just the TR element reque=
sted.
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Get the nodes from the table
+		 *      var nNodes =3D oTable.fnGetNodes( );
+		 *    } );
+		 */
+		this.fnGetNodes =3D function( iRow )
+		{
+			var api =3D this.api( true );
+=09=09
+			return iRow !=3D=3D undefined ?
+				api.row( iRow ).node() :
+				api.rows().nodes().flatten().toArray();
+		};
+=09=09
+=09=09
+		/**
+		 * Get the array indexes of a particular cell from it's DOM element
+		 * and column index including hidden columns
+		 *  @param {node} node this can either be a TR, TD or TH in the table's =
body
+		 *  @returns {int} If nNode is given as a TR, then a single index is ret=
urned, or
+		 *    if given as a cell, an array of [row index, column index (visible),
+		 *    column index (all)] is given.
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      $('#example tbody td').click( function () {
+		 *        // Get the position of the current data from the node
+		 *        var aPos =3D oTable.fnGetPosition( this );
+		 *
+		 *        // Get the data array for this row
+		 *        var aData =3D oTable.fnGetData( aPos[0] );
+		 *
+		 *        // Update the data array and return the value
+		 *        aData[ aPos[1] ] =3D 'clicked';
+		 *        this.innerHTML =3D 'clicked';
+		 *      } );
+		 *
+		 *      // Init DataTables
+		 *      oTable =3D $('#example').dataTable();
+		 *    } );
+		 */
+		this.fnGetPosition =3D function( node )
+		{
+			var api =3D this.api( true );
+			var nodeName =3D node.nodeName.toUpperCase();
+=09=09
+			if ( nodeName =3D=3D 'TR' ) {
+				return api.row( node ).index();
+			}
+			else if ( nodeName =3D=3D 'TD' || nodeName =3D=3D 'TH' ) {
+				var cell =3D api.cell( node ).index();
+=09=09
+				return [
+					cell.row,
+					cell.columnVisible,
+					cell.column
+				];
+			}
+			return null;
+		};
+=09=09
+=09=09
+		/**
+		 * Check to see if a row is 'open' or not.
+		 *  @param {node} nTr the table row to check
+		 *  @returns {boolean} true if the row is currently open, false otherwise
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable;
+		 *
+		 *      // 'open' an information row when a row is clicked on
+		 *      $('#example tbody tr').click( function () {
+		 *        if ( oTable.fnIsOpen(this) ) {
+		 *          oTable.fnClose( this );
+		 *        } else {
+		 *          oTable.fnOpen( this, "Temporary row opened", "info_row" );
+		 *        }
+		 *      } );
+		 *
+		 *      oTable =3D $('#example').dataTable();
+		 *    } );
+		 */
+		this.fnIsOpen =3D function( nTr )
+		{
+			return this.api( true ).row( nTr ).child.isShown();
+		};
+=09=09
+=09=09
+		/**
+		 * This function will place a new row directly after a row which is curr=
ently
+		 * on display on the page, with the HTML contents that is passed into the
+		 * function. This can be used, for example, to ask for confirmation that=
 a
+		 * particular record should be deleted.
+		 *  @param {node} nTr The table row to 'open'
+		 *  @param {string|node|jQuery} mHtml The HTML to put into the row
+		 *  @param {string} sClass Class to give the new TD cell
+		 *  @returns {node} The row opened. Note that if the table row passed in=
 as the
+		 *    first parameter, is not found in the table, this method will silen=
tly
+		 *    return.
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable;
+		 *
+		 *      // 'open' an information row when a row is clicked on
+		 *      $('#example tbody tr').click( function () {
+		 *        if ( oTable.fnIsOpen(this) ) {
+		 *          oTable.fnClose( this );
+		 *        } else {
+		 *          oTable.fnOpen( this, "Temporary row opened", "info_row" );
+		 *        }
+		 *      } );
+		 *
+		 *      oTable =3D $('#example').dataTable();
+		 *    } );
+		 */
+		this.fnOpen =3D function( nTr, mHtml, sClass )
+		{
+			return this.api( true )
+				.row( nTr )
+				.child( mHtml, sClass )
+				.show()
+				.child()[0];
+		};
+=09=09
+=09=09
+		/**
+		 * Change the pagination - provides the internal logic for pagination in=
 a simple API
+		 * function. With this function you can have a DataTables table go to th=
e next,
+		 * previous, first or last pages.
+		 *  @param {string|int} mAction Paging action to take: "first", "previou=
s", "next" or "last"
+		 *    or page number to jump to (integer), note that page 0 is the first=
 page.
+		 *  @param {bool} [bRedraw=3Dtrue] Redraw the table or not
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *      oTable.fnPageChange( 'next' );
+		 *    } );
+		 */
+		this.fnPageChange =3D function ( mAction, bRedraw )
+		{
+			var api =3D this.api( true ).page( mAction );
+=09=09
+			if ( bRedraw =3D=3D=3D undefined || bRedraw ) {
+				api.draw(false);
+			}
+		};
+=09=09
+=09=09
+		/**
+		 * Show a particular column
+		 *  @param {int} iCol The column whose display should be changed
+		 *  @param {bool} bShow Show (true) or hide (false) the column
+		 *  @param {bool} [bRedraw=3Dtrue] Redraw the table or not
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Hide the second column after initialisation
+		 *      oTable.fnSetColumnVis( 1, false );
+		 *    } );
+		 */
+		this.fnSetColumnVis =3D function ( iCol, bShow, bRedraw )
+		{
+			var api =3D this.api( true ).column( iCol ).visible( bShow );
+=09=09
+			if ( bRedraw =3D=3D=3D undefined || bRedraw ) {
+				api.columns.adjust().draw();
+			}
+		};
+=09=09
+=09=09
+		/**
+		 * Get the settings for a particular table for external manipulation
+		 *  @returns {object} DataTables settings object. See
+		 *    {@link DataTable.models.oSettings}
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *      var oSettings =3D oTable.fnSettings();
+		 *
+		 *      // Show an example parameter from the settings
+		 *      alert( oSettings._iDisplayStart );
+		 *    } );
+		 */
+		this.fnSettings =3D function()
+		{
+			return _fnSettingsFromNode( this[_ext.iApiIndex] );
+		};
+=09=09
+=09=09
+		/**
+		 * Sort the table by a particular column
+		 *  @param {int} iCol the data index to sort on. Note that this will not=
 match the
+		 *    'display index' if you have hidden data entries
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Sort immediately with columns 0 and 1
+		 *      oTable.fnSort( [ [0,'asc'], [1,'asc'] ] );
+		 *    } );
+		 */
+		this.fnSort =3D function( aaSort )
+		{
+			this.api( true ).order( aaSort ).draw();
+		};
+=09=09
+=09=09
+		/**
+		 * Attach a sort listener to an element for a given column
+		 *  @param {node} nNode the element to attach the sort listener to
+		 *  @param {int} iColumn the column that a click on this node will sort =
on
+		 *  @param {function} [fnCallback] callback function when sort is run
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *
+		 *      // Sort on column 1, when 'sorter' is clicked on
+		 *      oTable.fnSortListener( document.getElementById('sorter'), 1 );
+		 *    } );
+		 */
+		this.fnSortListener =3D function( nNode, iColumn, fnCallback )
+		{
+			this.api( true ).order.listener( nNode, iColumn, fnCallback );
+		};
+=09=09
+=09=09
+		/**
+		 * Update a table cell or row - this method will accept either a single =
value to
+		 * update the cell with, an array of values with one element for each co=
lumn or
+		 * an object in the same format as the original data source. The functio=
n is
+		 * self-referencing in order to make the multi column updates easier.
+		 *  @param {object|array|string} mData Data to update the cell/row with
+		 *  @param {node|int} mRow TR element you want to update or the aoData i=
ndex
+		 *  @param {int} [iColumn] The column to update, give as null or undefin=
ed to
+		 *    update a whole row.
+		 *  @param {bool} [bRedraw=3Dtrue] Redraw the table or not
+		 *  @param {bool} [bAction=3Dtrue] Perform pre-draw actions or not
+		 *  @returns {int} 0 on success, 1 on error
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *      oTable.fnUpdate( 'Example update', 0, 0 ); // Single cell
+		 *      oTable.fnUpdate( ['a', 'b', 'c', 'd', 'e'], $('tbody tr')[0] ); =
// Row
+		 *    } );
+		 */
+		this.fnUpdate =3D function( mData, mRow, iColumn, bRedraw, bAction )
+		{
+			var api =3D this.api( true );
+=09=09
+			if ( iColumn =3D=3D=3D undefined || iColumn =3D=3D=3D null ) {
+				api.row( mRow ).data( mData );
+			}
+			else {
+				api.cell( mRow, iColumn ).data( mData );
+			}
+=09=09
+			if ( bAction =3D=3D=3D undefined || bAction ) {
+				api.columns.adjust();
+			}
+=09=09
+			if ( bRedraw =3D=3D=3D undefined || bRedraw ) {
+				api.draw();
+			}
+			return 0;
+		};
+=09=09
+=09=09
+		/**
+		 * Provide a common method for plug-ins to check the version of DataTabl=
es being used, in order
+		 * to ensure compatibility.
+		 *  @param {string} sVersion Version string to check for, in the format =
"X.Y.Z". Note that the
+		 *    formats "X" and "X.Y" are also acceptable.
+		 *  @returns {boolean} true if this version of DataTables is greater or =
equal to the required
+		 *    version, or false if this version of DataTales is not suitable
+		 *  @method
+		 *  @dtopt API
+		 *  @deprecated Since v1.10
+		 *
+		 *  @example
+		 *    $(document).ready(function() {
+		 *      var oTable =3D $('#example').dataTable();
+		 *      alert( oTable.fnVersionCheck( '1.9.0' ) );
+		 *    } );
+		 */
+		this.fnVersionCheck =3D _ext.fnVersionCheck;
+=09=09
+=09
+		var _that =3D this;
+		var emptyInit =3D options =3D=3D=3D undefined;
+		var len =3D this.length;
+=09
+		if ( emptyInit ) {
+			options =3D {};
+		}
+=09
+		this.oApi =3D this.internal =3D _ext.internal;
+=09
+		// Extend with old style plug-in API methods
+		for ( var fn in DataTable.ext.internal ) {
+			if ( fn ) {
+				this[fn] =3D _fnExternApiFunc(fn);
+			}
+		}
+=09
+		this.each(function() {
+			// For each initialisation we want to give it a clean initialisation
+			// object that can be bashed around
+			var o =3D {};
+			var oInit =3D len > 1 ? // optimisation for single table case
+				_fnExtend( o, options, true ) :
+				options;
+=09
+			/*global oInit,_that,emptyInit*/
+			var i=3D0, iLen, j, jLen, k, kLen;
+			var sId =3D this.getAttribute( 'id' );
+			var bInitHandedOff =3D false;
+			var defaults =3D DataTable.defaults;
+			var $this =3D $(this);
+=09=09=09
+=09=09=09
+			/* Sanity check */
+			if ( this.nodeName.toLowerCase() !=3D 'table' )
+			{
+				_fnLog( null, 0, 'Non-table node initialisation ('+this.nodeName+')', =
2 );
+				return;
+			}
+=09=09=09
+			/* Backwards compatibility for the defaults */
+			_fnCompatOpts( defaults );
+			_fnCompatCols( defaults.column );
+=09=09=09
+			/* Convert the camel-case defaults to Hungarian */
+			_fnCamelToHungarian( defaults, defaults, true );
+			_fnCamelToHungarian( defaults.column, defaults.column, true );
+=09=09=09
+			/* Setting up the initialisation object */
+			_fnCamelToHungarian( defaults, $.extend( oInit, $this.data() ), true );
+=09=09=09
+=09=09=09
+=09=09=09
+			/* Check to see if we are re-initialising a table */
+			var allSettings =3D DataTable.settings;
+			for ( i=3D0, iLen=3DallSettings.length ; i<iLen ; i++ )
+			{
+				var s =3D allSettings[i];
+=09=09=09
+				/* Base check on table node */
+				if (
+					s.nTable =3D=3D this ||
+					(s.nTHead && s.nTHead.parentNode =3D=3D this) ||
+					(s.nTFoot && s.nTFoot.parentNode =3D=3D this)
+				) {
+					var bRetrieve =3D oInit.bRetrieve !=3D=3D undefined ? oInit.bRetrieve=
 : defaults.bRetrieve;
+					var bDestroy =3D oInit.bDestroy !=3D=3D undefined ? oInit.bDestroy : =
defaults.bDestroy;
+=09=09=09
+					if ( emptyInit || bRetrieve )
+					{
+						return s.oInstance;
+					}
+					else if ( bDestroy )
+					{
+						s.oInstance.fnDestroy();
+						break;
+					}
+					else
+					{
+						_fnLog( s, 0, 'Cannot reinitialise DataTable', 3 );
+						return;
+					}
+				}
+=09=09=09
+				/* If the element we are initialising has the same ID as a table which=
 was previously
+				 * initialised, but the table nodes don't match (from before) then we =
destroy the old
+				 * instance by simply deleting it. This is under the assumption that t=
he table has been
+				 * destroyed by other methods. Anyone using non-id selectors will need=
 to do this manually
+				 */
+				if ( s.sTableId =3D=3D this.id )
+				{
+					allSettings.splice( i, 1 );
+					break;
+				}
+			}
+=09=09=09
+			/* Ensure the table has an ID - required for accessibility */
+			if ( sId =3D=3D=3D null || sId =3D=3D=3D "" )
+			{
+				sId =3D "DataTables_Table_"+(DataTable.ext._unique++);
+				this.id =3D sId;
+			}
+=09=09=09
+			/* Create the settings object for this table and set some of the defaul=
t parameters */
+			var oSettings =3D $.extend( true, {}, DataTable.models.oSettings, {
+				"sDestroyWidth": $this[0].style.width,
+				"sInstance":     sId,
+				"sTableId":      sId
+			} );
+			oSettings.nTable =3D this;
+			oSettings.oApi   =3D _that.internal;
+			oSettings.oInit  =3D oInit;
+=09=09=09
+			allSettings.push( oSettings );
+=09=09=09
+			// Need to add the instance after the instance after the settings objec=
t has been added
+			// to the settings array, so we can self reference the table instance i=
f more than one
+			oSettings.oInstance =3D (_that.length=3D=3D=3D1) ? _that : $this.dataTa=
ble();
+=09=09=09
+			// Backwards compatibility, before we apply all the defaults
+			_fnCompatOpts( oInit );
+			_fnLanguageCompat( oInit.oLanguage );
+=09=09=09
+			// If the length menu is given, but the init display length is not, use=
 the length menu
+			if ( oInit.aLengthMenu && ! oInit.iDisplayLength )
+			{
+				oInit.iDisplayLength =3D Array.isArray( oInit.aLengthMenu[0] ) ?
+					oInit.aLengthMenu[0][0] : oInit.aLengthMenu[0];
+			}
+=09=09=09
+			// Apply the defaults and init options to make a single init object wil=
l all
+			// options defined from defaults and instance options.
+			oInit =3D _fnExtend( $.extend( true, {}, defaults ), oInit );
+=09=09=09
+=09=09=09
+			// Map the initialisation options onto the settings object
+			_fnMap( oSettings.oFeatures, oInit, [
+				"bPaginate",
+				"bLengthChange",
+				"bFilter",
+				"bSort",
+				"bSortMulti",
+				"bInfo",
+				"bProcessing",
+				"bAutoWidth",
+				"bSortClasses",
+				"bServerSide",
+				"bDeferRender"
+			] );
+			_fnMap( oSettings, oInit, [
+				"asStripeClasses",
+				"ajax",
+				"fnServerData",
+				"fnFormatNumber",
+				"sServerMethod",
+				"aaSorting",
+				"aaSortingFixed",
+				"aLengthMenu",
+				"sPaginationType",
+				"sAjaxSource",
+				"sAjaxDataProp",
+				"iStateDuration",
+				"sDom",
+				"bSortCellsTop",
+				"iTabIndex",
+				"fnStateLoadCallback",
+				"fnStateSaveCallback",
+				"renderer",
+				"searchDelay",
+				"rowId",
+				[ "iCookieDuration", "iStateDuration" ], // backwards compat
+				[ "oSearch", "oPreviousSearch" ],
+				[ "aoSearchCols", "aoPreSearchCols" ],
+				[ "iDisplayLength", "_iDisplayLength" ]
+			] );
+			_fnMap( oSettings.oScroll, oInit, [
+				[ "sScrollX", "sX" ],
+				[ "sScrollXInner", "sXInner" ],
+				[ "sScrollY", "sY" ],
+				[ "bScrollCollapse", "bCollapse" ]
+			] );
+			_fnMap( oSettings.oLanguage, oInit, "fnInfoCallback" );
+=09=09=09
+			/* Callback functions which are array driven */
+			_fnCallbackReg( oSettings, 'aoDrawCallback',       oInit.fnDrawCallback=
,      'user' );
+			_fnCallbackReg( oSettings, 'aoServerParams',       oInit.fnServerParams=
,      'user' );
+			_fnCallbackReg( oSettings, 'aoStateSaveParams',    oInit.fnStateSavePar=
ams,   'user' );
+			_fnCallbackReg( oSettings, 'aoStateLoadParams',    oInit.fnStateLoadPar=
ams,   'user' );
+			_fnCallbackReg( oSettings, 'aoStateLoaded',        oInit.fnStateLoaded,=
       'user' );
+			_fnCallbackReg( oSettings, 'aoRowCallback',        oInit.fnRowCallback,=
       'user' );
+			_fnCallbackReg( oSettings, 'aoRowCreatedCallback', oInit.fnCreatedRow, =
       'user' );
+			_fnCallbackReg( oSettings, 'aoHeaderCallback',     oInit.fnHeaderCallba=
ck,    'user' );
+			_fnCallbackReg( oSettings, 'aoFooterCallback',     oInit.fnFooterCallba=
ck,    'user' );
+			_fnCallbackReg( oSettings, 'aoInitComplete',       oInit.fnInitComplete=
,      'user' );
+			_fnCallbackReg( oSettings, 'aoPreDrawCallback',    oInit.fnPreDrawCallb=
ack,   'user' );
+=09=09=09
+			oSettings.rowIdFn =3D _fnGetObjectDataFn( oInit.rowId );
+=09=09=09
+			/* Browser support detection */
+			_fnBrowserDetect( oSettings );
+=09=09=09
+			var oClasses =3D oSettings.oClasses;
+=09=09=09
+			$.extend( oClasses, DataTable.ext.classes, oInit.oClasses );
+			$this.addClass( oClasses.sTable );
+=09=09=09
+=09=09=09
+			if ( oSettings.iInitDisplayStart =3D=3D=3D undefined )
+			{
+				/* Display start point, taking into account the save saving */
+				oSettings.iInitDisplayStart =3D oInit.iDisplayStart;
+				oSettings._iDisplayStart =3D oInit.iDisplayStart;
+			}
+=09=09=09
+			if ( oInit.iDeferLoading !=3D=3D null )
+			{
+				oSettings.bDeferLoading =3D true;
+				var tmp =3D Array.isArray( oInit.iDeferLoading );
+				oSettings._iRecordsDisplay =3D tmp ? oInit.iDeferLoading[0] : oInit.iD=
eferLoading;
+				oSettings._iRecordsTotal =3D tmp ? oInit.iDeferLoading[1] : oInit.iDef=
erLoading;
+			}
+=09=09=09
+			/* Language definitions */
+			var oLanguage =3D oSettings.oLanguage;
+			$.extend( true, oLanguage, oInit.oLanguage );
+=09=09=09
+			if ( oLanguage.sUrl )
+			{
+				/* Get the language definitions from a file - because this Ajax call m=
akes the language
+				 * get async to the remainder of this function we use bInitHandedOff t=
o indicate that
+				 * _fnInitialise will be fired by the returned Ajax handler, rather th=
an the constructor
+				 */
+				$.ajax( {
+					dataType: 'json',
+					url: oLanguage.sUrl,
+					success: function ( json ) {
+						_fnCamelToHungarian( defaults.oLanguage, json );
+						_fnLanguageCompat( json );
+						$.extend( true, oLanguage, json );
+=09=09=09
+						_fnCallbackFire( oSettings, null, 'i18n', [oSettings]);
+						_fnInitialise( oSettings );
+					},
+					error: function () {
+						// Error occurred loading language file, continue on as best we can
+						_fnInitialise( oSettings );
+					}
+				} );
+				bInitHandedOff =3D true;
+			}
+			else {
+				_fnCallbackFire( oSettings, null, 'i18n', [oSettings]);
+			}
+=09=09=09
+			/*
+			 * Stripes
+			 */
+			if ( oInit.asStripeClasses =3D=3D=3D null )
+			{
+				oSettings.asStripeClasses =3D[
+					oClasses.sStripeOdd,
+					oClasses.sStripeEven
+				];
+			}
+=09=09=09
+			/* Remove row stripe classes if they are already on the table row */
+			var stripeClasses =3D oSettings.asStripeClasses;
+			var rowOne =3D $this.children('tbody').find('tr').eq(0);
+			if ( $.inArray( true, $.map( stripeClasses, function(el, i) {
+				return rowOne.hasClass(el);
+			} ) ) !=3D=3D -1 ) {
+				$('tbody tr', this).removeClass( stripeClasses.join(' ') );
+				oSettings.asDestroyStripes =3D stripeClasses.slice();
+			}
+=09=09=09
+			/*
+			 * Columns
+			 * See if we should load columns automatically or use defined ones
+			 */
+			var anThs =3D [];
+			var aoColumnsInit;
+			var nThead =3D this.getElementsByTagName('thead');
+			if ( nThead.length !=3D=3D 0 )
+			{
+				_fnDetectHeader( oSettings.aoHeader, nThead[0] );
+				anThs =3D _fnGetUniqueThs( oSettings );
+			}
+=09=09=09
+			/* If not given a column array, generate one with nulls */
+			if ( oInit.aoColumns =3D=3D=3D null )
+			{
+				aoColumnsInit =3D [];
+				for ( i=3D0, iLen=3DanThs.length ; i<iLen ; i++ )
+				{
+					aoColumnsInit.push( null );
+				}
+			}
+			else
+			{
+				aoColumnsInit =3D oInit.aoColumns;
+			}
+=09=09=09
+			/* Add the columns */
+			for ( i=3D0, iLen=3DaoColumnsInit.length ; i<iLen ; i++ )
+			{
+				_fnAddColumn( oSettings, anThs ? anThs[i] : null );
+			}
+=09=09=09
+			/* Apply the column definitions */
+			_fnApplyColumnDefs( oSettings, oInit.aoColumnDefs, aoColumnsInit, funct=
ion (iCol, oDef) {
+				_fnColumnOptions( oSettings, iCol, oDef );
+			} );
+=09=09=09
+			/* HTML5 attribute detection - build an mData object automatically if t=
he
+			 * attributes are found
+			 */
+			if ( rowOne.length ) {
+				var a =3D function ( cell, name ) {
+					return cell.getAttribute( 'data-'+name ) !=3D=3D null ? name : null;
+				};
+=09=09=09
+				$( rowOne[0] ).children('th, td').each( function (i, cell) {
+					var col =3D oSettings.aoColumns[i];
+=09=09=09
+					if ( col.mData =3D=3D=3D i ) {
+						var sort =3D a( cell, 'sort' ) || a( cell, 'order' );
+						var filter =3D a( cell, 'filter' ) || a( cell, 'search' );
+=09=09=09
+						if ( sort !=3D=3D null || filter !=3D=3D null ) {
+							col.mData =3D {
+								_:      i+'.display',
+								sort:   sort !=3D=3D null   ? i+'.@data-'+sort   : undefined,
+								type:   sort !=3D=3D null   ? i+'.@data-'+sort   : undefined,
+								filter: filter !=3D=3D null ? i+'.@data-'+filter : undefined
+							};
+=09=09=09
+							_fnColumnOptions( oSettings, i );
+						}
+					}
+				} );
+			}
+=09=09=09
+			var features =3D oSettings.oFeatures;
+			var loadedInit =3D function () {
+				/*
+				 * Sorting
+				 * @todo For modularisation (1.11) this needs to do into a sort start =
up handler
+				 */
+=09=09=09
+				// If aaSorting is not defined, then we use the first indicator in asS=
orting
+				// in case that has been altered, so the default sort reflects that op=
tion
+				if ( oInit.aaSorting =3D=3D=3D undefined ) {
+					var sorting =3D oSettings.aaSorting;
+					for ( i=3D0, iLen=3Dsorting.length ; i<iLen ; i++ ) {
+						sorting[i][1] =3D oSettings.aoColumns[ i ].asSorting[0];
+					}
+				}
+=09=09=09
+				/* Do a first pass on the sorting classes (allows any size changes to =
be taken into
+				 * account, and also will apply sorting disabled classes if disabled
+				 */
+				_fnSortingClasses( oSettings );
+=09=09=09
+				if ( features.bSort ) {
+					_fnCallbackReg( oSettings, 'aoDrawCallback', function () {
+						if ( oSettings.bSorted ) {
+							var aSort =3D _fnSortFlatten( oSettings );
+							var sortedColumns =3D {};
+=09=09=09
+							$.each( aSort, function (i, val) {
+								sortedColumns[ val.src ] =3D val.dir;
+							} );
+=09=09=09
+							_fnCallbackFire( oSettings, null, 'order', [oSettings, aSort, sorte=
dColumns] );
+							_fnSortAria( oSettings );
+						}
+					} );
+				}
+=09=09=09
+				_fnCallbackReg( oSettings, 'aoDrawCallback', function () {
+					if ( oSettings.bSorted || _fnDataSource( oSettings ) =3D=3D=3D 'ssp' =
|| features.bDeferRender ) {
+						_fnSortingClasses( oSettings );
+					}
+				}, 'sc' );
+=09=09=09
+=09=09=09
+				/*
+				 * Final init
+				 * Cache the header, body and footer as required, creating them if nee=
ded
+				 */
+=09=09=09
+				// Work around for Webkit bug 83867 - store the caption-side before re=
moving from doc
+				var captions =3D $this.children('caption').each( function () {
+					this._captionSide =3D $(this).css('caption-side');
+				} );
+=09=09=09
+				var thead =3D $this.children('thead');
+				if ( thead.length =3D=3D=3D 0 ) {
+					thead =3D $('<thead/>').appendTo($this);
+				}
+				oSettings.nTHead =3D thead[0];
+=09=09=09
+				var tbody =3D $this.children('tbody');
+				if ( tbody.length =3D=3D=3D 0 ) {
+					tbody =3D $('<tbody/>').insertAfter(thead);
+				}
+				oSettings.nTBody =3D tbody[0];
+=09=09=09
+				var tfoot =3D $this.children('tfoot');
+				if ( tfoot.length =3D=3D=3D 0 && captions.length > 0 && (oSettings.oSc=
roll.sX !=3D=3D "" || oSettings.oScroll.sY !=3D=3D "") ) {
+					// If we are a scrolling table, and no footer has been given, then we=
 need to create
+					// a tfoot element for the caption element to be appended to
+					tfoot =3D $('<tfoot/>').appendTo($this);
+				}
+=09=09=09
+				if ( tfoot.length =3D=3D=3D 0 || tfoot.children().length =3D=3D=3D 0 )=
 {
+					$this.addClass( oClasses.sNoFooter );
+				}
+				else if ( tfoot.length > 0 ) {
+					oSettings.nTFoot =3D tfoot[0];
+					_fnDetectHeader( oSettings.aoFooter, oSettings.nTFoot );
+				}
+=09=09=09
+				/* Check if there is data passing into the constructor */
+				if ( oInit.aaData ) {
+					for ( i=3D0 ; i<oInit.aaData.length ; i++ ) {
+						_fnAddData( oSettings, oInit.aaData[ i ] );
+					}
+				}
+				else if ( oSettings.bDeferLoading || _fnDataSource( oSettings ) =3D=3D=
 'dom' ) {
+					/* Grab the data from the page - only do this when deferred loading o=
r no Ajax
+					 * source since there is no point in reading the DOM data if we are t=
hen going
+					 * to replace it with Ajax data
+					 */
+					_fnAddTr( oSettings, $(oSettings.nTBody).children('tr') );
+				}
+=09=09=09
+				/* Copy the data index array */
+				oSettings.aiDisplay =3D oSettings.aiDisplayMaster.slice();
+=09=09=09
+				/* Initialisation complete - table can be drawn */
+				oSettings.bInitialised =3D true;
+=09=09=09
+				/* Check if we need to initialise the table (it might not have been ha=
nded off to the
+				 * language processor)
+				 */
+				if ( bInitHandedOff =3D=3D=3D false ) {
+					_fnInitialise( oSettings );
+				}
+			};
+=09=09=09
+			/* Must be done after everything which can be overridden by the state s=
aving! */
+			_fnCallbackReg( oSettings, 'aoDrawCallback', _fnSaveState, 'state_save'=
 );
+=09=09=09
+			if ( oInit.bStateSave )
+			{
+				features.bStateSave =3D true;
+				_fnLoadState( oSettings, oInit, loadedInit );
+			}
+			else {
+				loadedInit();
+			}
+=09=09=09
+		} );
+		_that =3D null;
+		return this;
+	};
+=09
+=09
+	/*
+	 * It is useful to have variables which are scoped locally so only the
+	 * DataTables functions can access them and they don't leak into global s=
pace.
+	 * At the same time these functions are often useful over multiple files =
in the
+	 * core and API, so we list, or at least document, all variables which ar=
e used
+	 * by DataTables as private variables here. This also ensures that there =
is no
+	 * clashing of variable names and that they can easily referenced for reu=
se.
+	 */
+=09
+=09
+	// Defined else where
+	//  _selector_run
+	//  _selector_opts
+	//  _selector_first
+	//  _selector_row_indexes
+=09
+	var _ext; // DataTable.ext
+	var _Api; // DataTable.Api
+	var _api_register; // DataTable.Api.register
+	var _api_registerPlural; // DataTable.Api.registerPlural
+=09
+	var _re_dic =3D {};
+	var _re_new_lines =3D /[\r\n\u2028]/g;
+	var _re_html =3D /<.*?>/g;
+=09
+	// This is not strict ISO8601 - Date.parse() is quite lax, although
+	// implementations differ between browsers.
+	var _re_date =3D /^\d{2,4}[\.\/\-]\d{1,2}[\.\/\-]\d{1,2}([T ]{1}\d{1,2}[:=
\.]\d{2}([\.:]\d{2})?)?$/;
+=09
+	// Escape regular expression special characters
+	var _re_escape_regex =3D new RegExp( '(\\' + [ '/', '.', '*', '+', '?', '=
|', '(', ')', '[', ']', '{', '}', '\\', '$', '^', '-' ].join('|\\') + ')', =
'g' );
+=09
+	// http://en.wikipedia.org/wiki/Foreign_exchange_market
+	// - \u20BD - Russian ruble.
+	// - \u20a9 - South Korean Won
+	// - \u20BA - Turkish Lira
+	// - \u20B9 - Indian Rupee
+	// - R - Brazil (R$) and South Africa
+	// - fr - Swiss Franc
+	// - kr - Swedish krona, Norwegian krone and Danish krone
+	// - \u2009 is thin space and \u202F is narrow no-break space, both used =
in many
+	// - =C9=83 - Bitcoin
+	// - =CE=9E - Ethereum
+	//   standards as thousands separators.
+	var _re_formatted_numeric =3D /['\u00A0,$=C2=A3=E2=82=AC=C2=A5%\u2009\u20=
2F\u20BD\u20a9\u20BArfk=C9=83=CE=9E]/gi;
+=09
+=09
+	var _empty =3D function ( d ) {
+		return !d || d =3D=3D=3D true || d =3D=3D=3D '-' ? true : false;
+	};
+=09
+=09
+	var _intVal =3D function ( s ) {
+		var integer =3D parseInt( s, 10 );
+		return !isNaN(integer) && isFinite(s) ? integer : null;
+	};
+=09
+	// Convert from a formatted number with characters other than `.` as the
+	// decimal place, to a Javascript number
+	var _numToDecimal =3D function ( num, decimalPoint ) {
+		// Cache created regular expressions for speed as this function is calle=
d often
+		if ( ! _re_dic[ decimalPoint ] ) {
+			_re_dic[ decimalPoint ] =3D new RegExp( _fnEscapeRegex( decimalPoint ),=
 'g' );
+		}
+		return typeof num =3D=3D=3D 'string' && decimalPoint !=3D=3D '.' ?
+			num.replace( /\./g, '' ).replace( _re_dic[ decimalPoint ], '.' ) :
+			num;
+	};
+=09
+=09
+	var _isNumber =3D function ( d, decimalPoint, formatted ) {
+		var strType =3D typeof d =3D=3D=3D 'string';
+=09
+		// If empty return immediately so there must be a number if it is a
+		// formatted string (this stops the string "k", or "kr", etc being detec=
ted
+		// as a formatted number for currency
+		if ( _empty( d ) ) {
+			return true;
+		}
+=09
+		if ( decimalPoint && strType ) {
+			d =3D _numToDecimal( d, decimalPoint );
+		}
+=09
+		if ( formatted && strType ) {
+			d =3D d.replace( _re_formatted_numeric, '' );
+		}
+=09
+		return !isNaN( parseFloat(d) ) && isFinite( d );
+	};
+=09
+=09
+	// A string without HTML in it can be considered to be HTML still
+	var _isHtml =3D function ( d ) {
+		return _empty( d ) || typeof d =3D=3D=3D 'string';
+	};
+=09
+=09
+	var _htmlNumeric =3D function ( d, decimalPoint, formatted ) {
+		if ( _empty( d ) ) {
+			return true;
+		}
+=09
+		var html =3D _isHtml( d );
+		return ! html ?
+			null :
+			_isNumber( _stripHtml( d ), decimalPoint, formatted ) ?
+				true :
+				null;
+	};
+=09
+=09
+	var _pluck =3D function ( a, prop, prop2 ) {
+		var out =3D [];
+		var i=3D0, ien=3Da.length;
+=09
+		// Could have the test in the loop for slightly smaller code, but speed
+		// is essential here
+		if ( prop2 !=3D=3D undefined ) {
+			for ( ; i<ien ; i++ ) {
+				if ( a[i] && a[i][ prop ] ) {
+					out.push( a[i][ prop ][ prop2 ] );
+				}
+			}
+		}
+		else {
+			for ( ; i<ien ; i++ ) {
+				if ( a[i] ) {
+					out.push( a[i][ prop ] );
+				}
+			}
+		}
+=09
+		return out;
+	};
+=09
+=09
+	// Basically the same as _pluck, but rather than looping over `a` we use =
`order`
+	// as the indexes to pick from `a`
+	var _pluck_order =3D function ( a, order, prop, prop2 )
+	{
+		var out =3D [];
+		var i=3D0, ien=3Dorder.length;
+=09
+		// Could have the test in the loop for slightly smaller code, but speed
+		// is essential here
+		if ( prop2 !=3D=3D undefined ) {
+			for ( ; i<ien ; i++ ) {
+				if ( a[ order[i] ][ prop ] ) {
+					out.push( a[ order[i] ][ prop ][ prop2 ] );
+				}
+			}
+		}
+		else {
+			for ( ; i<ien ; i++ ) {
+				out.push( a[ order[i] ][ prop ] );
+			}
+		}
+=09
+		return out;
+	};
+=09
+=09
+	var _range =3D function ( len, start )
+	{
+		var out =3D [];
+		var end;
+=09
+		if ( start =3D=3D=3D undefined ) {
+			start =3D 0;
+			end =3D len;
+		}
+		else {
+			end =3D start;
+			start =3D len;
+		}
+=09
+		for ( var i=3Dstart ; i<end ; i++ ) {
+			out.push( i );
+		}
+=09
+		return out;
+	};
+=09
+=09
+	var _removeEmpty =3D function ( a )
+	{
+		var out =3D [];
+=09
+		for ( var i=3D0, ien=3Da.length ; i<ien ; i++ ) {
+			if ( a[i] ) { // careful - will remove all falsy values!
+				out.push( a[i] );
+			}
+		}
+=09
+		return out;
+	};
+=09
+=09
+	var _stripHtml =3D function ( d ) {
+		return d.replace( _re_html, '' );
+	};
+=09
+=09
+	/**
+	 * Determine if all values in the array are unique. This means we can sho=
rt
+	 * cut the _unique method at the cost of a single loop. A sorted array is=
 used
+	 * to easily check the values.
+	 *
+	 * @param  {array} src Source array
+	 * @return {boolean} true if all unique, false otherwise
+	 * @ignore
+	 */
+	var _areAllUnique =3D function ( src ) {
+		if ( src.length < 2 ) {
+			return true;
+		}
+=09
+		var sorted =3D src.slice().sort();
+		var last =3D sorted[0];
+=09
+		for ( var i=3D1, ien=3Dsorted.length ; i<ien ; i++ ) {
+			if ( sorted[i] =3D=3D=3D last ) {
+				return false;
+			}
+=09
+			last =3D sorted[i];
+		}
+=09
+		return true;
+	};
+=09
+=09
+	/**
+	 * Find the unique elements in a source array.
+	 *
+	 * @param  {array} src Source array
+	 * @return {array} Array of unique items
+	 * @ignore
+	 */
+	var _unique =3D function ( src )
+	{
+		if ( _areAllUnique( src ) ) {
+			return src.slice();
+		}
+=09
+		// A faster unique method is to use object keys to identify used values,
+		// but this doesn't work with arrays or objects, which we must also
+		// consider. See jsperf.com/compare-array-unique-versions/4 for more
+		// information.
+		var
+			out =3D [],
+			val,
+			i, ien=3Dsrc.length,
+			j, k=3D0;
+=09
+		again: for ( i=3D0 ; i<ien ; i++ ) {
+			val =3D src[i];
+=09
+			for ( j=3D0 ; j<k ; j++ ) {
+				if ( out[j] =3D=3D=3D val ) {
+					continue again;
+				}
+			}
+=09
+			out.push( val );
+			k++;
+		}
+=09
+		return out;
+	};
+=09
+	// Surprisingly this is faster than [].concat.apply
+	// https://jsperf.com/flatten-an-array-loop-vs-reduce/2
+	var _flatten =3D function (out, val) {
+		if (Array.isArray(val)) {
+			for (var i=3D0 ; i<val.length ; i++) {
+				_flatten(out, val[i]);
+			}
+		}
+		else {
+			out.push(val);
+		}
+=09=20=20
+		return out;
+	}
+=09
+	var _includes =3D function (search, start) {
+		if (start =3D=3D=3D undefined) {
+			start =3D 0;
+		}
+=09
+		return this.indexOf(search, start) !=3D=3D -1;=09
+	};
+=09
+	// Array.isArray polyfill.
+	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Glob=
al_Objects/Array/isArray
+	if (! Array.isArray) {
+	    Array.isArray =3D function(arg) {
+	        return Object.prototype.toString.call(arg) =3D=3D=3D '[object Arr=
ay]';
+	    };
+	}
+=09
+	if (! Array.prototype.includes) {
+		Array.prototype.includes =3D _includes;
+	}
+=09
+	// .trim() polyfill
+	// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Glob=
al_Objects/String/trim
+	if (!String.prototype.trim) {
+	  String.prototype.trim =3D function () {
+	    return this.replace(/^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, '');
+	  };
+	}
+=09
+	if (! String.prototype.includes) {
+		String.prototype.includes =3D _includes;
+	}
+=09
+	/**
+	 * DataTables utility methods
+	 *=20
+	 * This namespace provides helper methods that DataTables uses internally=
 to
+	 * create a DataTable, but which are not exclusively used only for DataTa=
bles.
+	 * These methods can be used by extension authors to save the duplication=
 of
+	 * code.
+	 *
+	 *  @namespace
+	 */
+	DataTable.util =3D {
+		/**
+		 * Throttle the calls to a function. Arguments and context are maintained
+		 * for the throttled function.
+		 *
+		 * @param {function} fn Function to be called
+		 * @param {integer} freq Call frequency in mS
+		 * @return {function} Wrapped function
+		 */
+		throttle: function ( fn, freq ) {
+			var
+				frequency =3D freq !=3D=3D undefined ? freq : 200,
+				last,
+				timer;
+=09
+			return function () {
+				var
+					that =3D this,
+					now  =3D +new Date(),
+					args =3D arguments;
+=09
+				if ( last && now < last + frequency ) {
+					clearTimeout( timer );
+=09
+					timer =3D setTimeout( function () {
+						last =3D undefined;
+						fn.apply( that, args );
+					}, frequency );
+				}
+				else {
+					last =3D now;
+					fn.apply( that, args );
+				}
+			};
+		},
+=09
+=09
+		/**
+		 * Escape a string such that it can be used in a regular expression
+		 *
+		 *  @param {string} val string to escape
+		 *  @returns {string} escaped string
+		 */
+		escapeRegex: function ( val ) {
+			return val.replace( _re_escape_regex, '\\$1' );
+		},
+=09
+		/**
+		 * Create a function that will write to a nested object or array
+		 * @param {*} source JSON notation string
+		 * @returns Write function
+		 */
+		set: function ( source ) {
+			if ( $.isPlainObject( source ) ) {
+				/* Unlike get, only the underscore (global) option is used for for
+				 * setting data since we don't know the type here. This is why an obje=
ct
+				 * option is not documented for `mData` (which is read/write), but it =
is
+				 * for `mRender` which is read only.
+				 */
+				return DataTable.util.set( source._ );
+			}
+			else if ( source =3D=3D=3D null ) {
+				// Nothing to do when the data source is null
+				return function () {};
+			}
+			else if ( typeof source =3D=3D=3D 'function' ) {
+				return function (data, val, meta) {
+					source( data, 'set', val, meta );
+				};
+			}
+			else if ( typeof source =3D=3D=3D 'string' && (source.indexOf('.') !=3D=
=3D -1 ||
+					  source.indexOf('[') !=3D=3D -1 || source.indexOf('(') !=3D=3D -1) )
+			{
+				// Like the get, we need to get data from a nested object
+				var setData =3D function (data, val, src) {
+					var a =3D _fnSplitObjNotation( src ), b;
+					var aLast =3D a[a.length-1];
+					var arrayNotation, funcNotation, o, innerSrc;
+=09=09
+					for ( var i=3D0, iLen=3Da.length-1 ; i<iLen ; i++ ) {
+						// Protect against prototype pollution
+						if (a[i] =3D=3D=3D '__proto__' || a[i] =3D=3D=3D 'constructor') {
+							throw new Error('Cannot set prototype values');
+						}
+=09=09
+						// Check if we are dealing with an array notation request
+						arrayNotation =3D a[i].match(__reArray);
+						funcNotation =3D a[i].match(__reFn);
+=09=09
+						if ( arrayNotation ) {
+							a[i] =3D a[i].replace(__reArray, '');
+							data[ a[i] ] =3D [];
+=09=09
+							// Get the remainder of the nested object to set so we can recurse
+							b =3D a.slice();
+							b.splice( 0, i+1 );
+							innerSrc =3D b.join('.');
+=09=09
+							// Traverse each entry in the array setting the properties requested
+							if ( Array.isArray( val ) ) {
+								for ( var j=3D0, jLen=3Dval.length ; j<jLen ; j++ ) {
+									o =3D {};
+									setData( o, val[j], innerSrc );
+									data[ a[i] ].push( o );
+								}
+							}
+							else {
+								// We've been asked to save data to an array, but it
+								// isn't array data to be saved. Best that can be done
+								// is to just save the value.
+								data[ a[i] ] =3D val;
+							}
+=09=09
+							// The inner call to setData has already traversed through the rema=
inder
+							// of the source and has set the data, thus we can exit here
+							return;
+						}
+						else if ( funcNotation ) {
+							// Function call
+							a[i] =3D a[i].replace(__reFn, '');
+							data =3D data[ a[i] ]( val );
+						}
+=09=09
+						// If the nested object doesn't currently exist - since we are
+						// trying to set the value - create it
+						if ( data[ a[i] ] =3D=3D=3D null || data[ a[i] ] =3D=3D=3D undefined=
 ) {
+							data[ a[i] ] =3D {};
+						}
+						data =3D data[ a[i] ];
+					}
+=09=09
+					// Last item in the input - i.e, the actual set
+					if ( aLast.match(__reFn ) ) {
+						// Function call
+						data =3D data[ aLast.replace(__reFn, '') ]( val );
+					}
+					else {
+						// If array notation is used, we just want to strip it and use the p=
roperty name
+						// and assign the value. If it isn't used, then we get the result we=
 want anyway
+						data[ aLast.replace(__reArray, '') ] =3D val;
+					}
+				};
+=09=09
+				return function (data, val) { // meta is also passed in, but not used
+					return setData( data, val, source );
+				};
+			}
+			else {
+				// Array or flat object mapping
+				return function (data, val) { // meta is also passed in, but not used
+					data[source] =3D val;
+				};
+			}
+		},
+=09
+		/**
+		 * Create a function that will read nested objects from arrays, based on=
 JSON notation
+		 * @param {*} source JSON notation string
+		 * @returns Value read
+		 */
+		get: function ( source ) {
+			if ( $.isPlainObject( source ) ) {
+				// Build an object of get functions, and wrap them in a single call
+				var o =3D {};
+				$.each( source, function (key, val) {
+					if ( val ) {
+						o[key] =3D DataTable.util.get( val );
+					}
+				} );
+=09=09
+				return function (data, type, row, meta) {
+					var t =3D o[type] || o._;
+					return t !=3D=3D undefined ?
+						t(data, type, row, meta) :
+						data;
+				};
+			}
+			else if ( source =3D=3D=3D null ) {
+				// Give an empty string for rendering / sorting etc
+				return function (data) { // type, row and meta also passed, but not us=
ed
+					return data;
+				};
+			}
+			else if ( typeof source =3D=3D=3D 'function' ) {
+				return function (data, type, row, meta) {
+					return source( data, type, row, meta );
+				};
+			}
+			else if ( typeof source =3D=3D=3D 'string' && (source.indexOf('.') !=3D=
=3D -1 ||
+					  source.indexOf('[') !=3D=3D -1 || source.indexOf('(') !=3D=3D -1) )
+			{
+				/* If there is a . in the source string then the data source is in a
+				 * nested object so we loop over the data for each level to get the ne=
xt
+				 * level down. On each loop we test for undefined, and if found immedi=
ately
+				 * return. This allows entire objects to be missing and sDefaultConten=
t to
+				 * be used if defined, rather than throwing an error
+				 */
+				var fetchData =3D function (data, type, src) {
+					var arrayNotation, funcNotation, out, innerSrc;
+=09=09
+					if ( src !=3D=3D "" ) {
+						var a =3D _fnSplitObjNotation( src );
+=09=09
+						for ( var i=3D0, iLen=3Da.length ; i<iLen ; i++ ) {
+							// Check if we are dealing with special notation
+							arrayNotation =3D a[i].match(__reArray);
+							funcNotation =3D a[i].match(__reFn);
+=09=09
+							if ( arrayNotation ) {
+								// Array notation
+								a[i] =3D a[i].replace(__reArray, '');
+=09=09
+								// Condition allows simply [] to be passed in
+								if ( a[i] !=3D=3D "" ) {
+									data =3D data[ a[i] ];
+								}
+								out =3D [];
+=09=09
+								// Get the remainder of the nested object to get
+								a.splice( 0, i+1 );
+								innerSrc =3D a.join('.');
+=09=09
+								// Traverse each entry in the array getting the properties request=
ed
+								if ( Array.isArray( data ) ) {
+									for ( var j=3D0, jLen=3Ddata.length ; j<jLen ; j++ ) {
+										out.push( fetchData( data[j], type, innerSrc ) );
+									}
+								}
+=09=09
+								// If a string is given in between the array notation indicators, =
that
+								// is used to join the strings together, otherwise an array is ret=
urned
+								var join =3D arrayNotation[0].substring(1, arrayNotation[0].length=
-1);
+								data =3D (join=3D=3D=3D"") ? out : out.join(join);
+=09=09
+								// The inner call to fetchData has already traversed through the r=
emainder
+								// of the source requested, so we exit from the loop
+								break;
+							}
+							else if ( funcNotation ) {
+								// Function call
+								a[i] =3D a[i].replace(__reFn, '');
+								data =3D data[ a[i] ]();
+								continue;
+							}
+=09=09
+							if ( data =3D=3D=3D null || data[ a[i] ] =3D=3D=3D undefined ) {
+								return undefined;
+							}
+=09
+							data =3D data[ a[i] ];
+						}
+					}
+=09=09
+					return data;
+				};
+=09=09
+				return function (data, type) { // row and meta also passed, but not us=
ed
+					return fetchData( data, type, source );
+				};
+			}
+			else {
+				// Array or flat object mapping
+				return function (data, type) { // row and meta also passed, but not us=
ed
+					return data[source];
+				};
+			}
+		}
+	};
+=09
+=09
+=09
+	/**
+	 * Create a mapping object that allows camel case parameters to be looked=
 up
+	 * for their Hungarian counterparts. The mapping is stored in a private
+	 * parameter called `_hungarianMap` which can be accessed on the source o=
bject.
+	 *  @param {object} o
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnHungarianMap ( o )
+	{
+		var
+			hungarian =3D 'a aa ai ao as b fn i m o s ',
+			match,
+			newKey,
+			map =3D {};
+=09
+		$.each( o, function (key, val) {
+			match =3D key.match(/^([^A-Z]+?)([A-Z])/);
+=09
+			if ( match && hungarian.indexOf(match[1]+' ') !=3D=3D -1 )
+			{
+				newKey =3D key.replace( match[0], match[2].toLowerCase() );
+				map[ newKey ] =3D key;
+=09
+				if ( match[1] =3D=3D=3D 'o' )
+				{
+					_fnHungarianMap( o[key] );
+				}
+			}
+		} );
+=09
+		o._hungarianMap =3D map;
+	}
+=09
+=09
+	/**
+	 * Convert from camel case parameters to Hungarian, based on a Hungarian =
map
+	 * created by _fnHungarianMap.
+	 *  @param {object} src The model object which holds all parameters that =
can be
+	 *    mapped.
+	 *  @param {object} user The object to convert from camel case to Hungari=
an.
+	 *  @param {boolean} force When set to `true`, properties which already h=
ave a
+	 *    Hungarian value in the `user` object will be overwritten. Otherwise=
 they
+	 *    won't be.
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnCamelToHungarian ( src, user, force )
+	{
+		if ( ! src._hungarianMap ) {
+			_fnHungarianMap( src );
+		}
+=09
+		var hungarianKey;
+=09
+		$.each( user, function (key, val) {
+			hungarianKey =3D src._hungarianMap[ key ];
+=09
+			if ( hungarianKey !=3D=3D undefined && (force || user[hungarianKey] =3D=
=3D=3D undefined) )
+			{
+				// For objects, we need to buzz down into the object to copy parameters
+				if ( hungarianKey.charAt(0) =3D=3D=3D 'o' )
+				{
+					// Copy the camelCase options over to the hungarian
+					if ( ! user[ hungarianKey ] ) {
+						user[ hungarianKey ] =3D {};
+					}
+					$.extend( true, user[hungarianKey], user[key] );
+=09
+					_fnCamelToHungarian( src[hungarianKey], user[hungarianKey], force );
+				}
+				else {
+					user[hungarianKey] =3D user[ key ];
+				}
+			}
+		} );
+	}
+=09
+=09
+	/**
+	 * Language compatibility - when certain options are given, and others ar=
en't, we
+	 * need to duplicate the values over, in order to provide backwards compa=
tibility
+	 * with older language files.
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnLanguageCompat( lang )
+	{
+		// Note the use of the Hungarian notation for the parameters in this met=
hod as
+		// this is called after the mapping of camelCase to Hungarian
+		var defaults =3D DataTable.defaults.oLanguage;
+=09
+		// Default mapping
+		var defaultDecimal =3D defaults.sDecimal;
+		if ( defaultDecimal ) {
+			_addNumericSort( defaultDecimal );
+		}
+=09
+		if ( lang ) {
+			var zeroRecords =3D lang.sZeroRecords;
+=09
+			// Backwards compatibility - if there is no sEmptyTable given, then use=
 the same as
+			// sZeroRecords - assuming that is given.
+			if ( ! lang.sEmptyTable && zeroRecords &&
+				defaults.sEmptyTable =3D=3D=3D "No data available in table" )
+			{
+				_fnMap( lang, lang, 'sZeroRecords', 'sEmptyTable' );
+			}
+=09
+			// Likewise with loading records
+			if ( ! lang.sLoadingRecords && zeroRecords &&
+				defaults.sLoadingRecords =3D=3D=3D "Loading..." )
+			{
+				_fnMap( lang, lang, 'sZeroRecords', 'sLoadingRecords' );
+			}
+=09
+			// Old parameter name of the thousands separator mapped onto the new
+			if ( lang.sInfoThousands ) {
+				lang.sThousands =3D lang.sInfoThousands;
+			}
+=09
+			var decimal =3D lang.sDecimal;
+			if ( decimal && defaultDecimal !=3D=3D decimal ) {
+				_addNumericSort( decimal );
+			}
+		}
+	}
+=09
+=09
+	/**
+	 * Map one parameter onto another
+	 *  @param {object} o Object to map
+	 *  @param {*} knew The new parameter name
+	 *  @param {*} old The old parameter name
+	 */
+	var _fnCompatMap =3D function ( o, knew, old ) {
+		if ( o[ knew ] !=3D=3D undefined ) {
+			o[ old ] =3D o[ knew ];
+		}
+	};
+=09
+=09
+	/**
+	 * Provide backwards compatibility for the main DT options. Note that the=
 new
+	 * options are mapped onto the old parameters, so this is an external int=
erface
+	 * change only.
+	 *  @param {object} init Object to map
+	 */
+	function _fnCompatOpts ( init )
+	{
+		_fnCompatMap( init, 'ordering',      'bSort' );
+		_fnCompatMap( init, 'orderMulti',    'bSortMulti' );
+		_fnCompatMap( init, 'orderClasses',  'bSortClasses' );
+		_fnCompatMap( init, 'orderCellsTop', 'bSortCellsTop' );
+		_fnCompatMap( init, 'order',         'aaSorting' );
+		_fnCompatMap( init, 'orderFixed',    'aaSortingFixed' );
+		_fnCompatMap( init, 'paging',        'bPaginate' );
+		_fnCompatMap( init, 'pagingType',    'sPaginationType' );
+		_fnCompatMap( init, 'pageLength',    'iDisplayLength' );
+		_fnCompatMap( init, 'searching',     'bFilter' );
+=09
+		// Boolean initialisation of x-scrolling
+		if ( typeof init.sScrollX =3D=3D=3D 'boolean' ) {
+			init.sScrollX =3D init.sScrollX ? '100%' : '';
+		}
+		if ( typeof init.scrollX =3D=3D=3D 'boolean' ) {
+			init.scrollX =3D init.scrollX ? '100%' : '';
+		}
+=09
+		// Column search objects are in an array, so it needs to be converted
+		// element by element
+		var searchCols =3D init.aoSearchCols;
+=09
+		if ( searchCols ) {
+			for ( var i=3D0, ien=3DsearchCols.length ; i<ien ; i++ ) {
+				if ( searchCols[i] ) {
+					_fnCamelToHungarian( DataTable.models.oSearch, searchCols[i] );
+				}
+			}
+		}
+	}
+=09
+=09
+	/**
+	 * Provide backwards compatibility for column options. Note that the new =
options
+	 * are mapped onto the old parameters, so this is an external interface c=
hange
+	 * only.
+	 *  @param {object} init Object to map
+	 */
+	function _fnCompatCols ( init )
+	{
+		_fnCompatMap( init, 'orderable',     'bSortable' );
+		_fnCompatMap( init, 'orderData',     'aDataSort' );
+		_fnCompatMap( init, 'orderSequence', 'asSorting' );
+		_fnCompatMap( init, 'orderDataType', 'sortDataType' );
+=09
+		// orderData can be given as an integer
+		var dataSort =3D init.aDataSort;
+		if ( typeof dataSort =3D=3D=3D 'number' && ! Array.isArray( dataSort ) )=
 {
+			init.aDataSort =3D [ dataSort ];
+		}
+	}
+=09
+=09
+	/**
+	 * Browser feature detection for capabilities, quirks
+	 *  @param {object} settings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnBrowserDetect( settings )
+	{
+		// We don't need to do this every time DataTables is constructed, the va=
lues
+		// calculated are specific to the browser and OS configuration which we
+		// don't expect to change between initialisations
+		if ( ! DataTable.__browser ) {
+			var browser =3D {};
+			DataTable.__browser =3D browser;
+=09
+			// Scrolling feature / quirks detection
+			var n =3D $('<div/>')
+				.css( {
+					position: 'fixed',
+					top: 0,
+					left: $(window).scrollLeft()*-1, // allow for scrolling
+					height: 1,
+					width: 1,
+					overflow: 'hidden'
+				} )
+				.append(
+					$('<div/>')
+						.css( {
+							position: 'absolute',
+							top: 1,
+							left: 1,
+							width: 100,
+							overflow: 'scroll'
+						} )
+						.append(
+							$('<div/>')
+								.css( {
+									width: '100%',
+									height: 10
+								} )
+						)
+				)
+				.appendTo( 'body' );
+=09
+			var outer =3D n.children();
+			var inner =3D outer.children();
+=09
+			// Numbers below, in order, are:
+			// inner.offsetWidth, inner.clientWidth, outer.offsetWidth, outer.clien=
tWidth
+			//
+			// IE6 XP:                           100 100 100  83
+			// IE7 Vista:                        100 100 100  83
+			// IE 8+ Windows:                     83  83 100  83
+			// Evergreen Windows:                 83  83 100  83
+			// Evergreen Mac with scrollbars:     85  85 100  85
+			// Evergreen Mac without scrollbars: 100 100 100 100
+=09
+			// Get scrollbar width
+			browser.barWidth =3D outer[0].offsetWidth - outer[0].clientWidth;
+=09
+			// IE6/7 will oversize a width 100% element inside a scrolling element,=
 to
+			// include the width of the scrollbar, while other browsers ensure the =
inner
+			// element is contained without forcing scrolling
+			browser.bScrollOversize =3D inner[0].offsetWidth =3D=3D=3D 100 && outer=
[0].clientWidth !=3D=3D 100;
+=09
+			// In rtl text layout, some browsers (most, but not all) will place the
+			// scrollbar on the left, rather than the right.
+			browser.bScrollbarLeft =3D Math.round( inner.offset().left ) !=3D=3D 1;
+=09
+			// IE8- don't provide height and width for getBoundingClientRect
+			browser.bBounding =3D n[0].getBoundingClientRect().width ? true : false;
+=09
+			n.remove();
+		}
+=09
+		$.extend( settings.oBrowser, DataTable.__browser );
+		settings.oScroll.iBarWidth =3D DataTable.__browser.barWidth;
+	}
+=09
+=09
+	/**
+	 * Array.prototype reduce[Right] method, used for browsers which don't su=
pport
+	 * JS 1.6. Done this way to reduce code size, since we iterate either way
+	 *  @param {object} settings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnReduce ( that, fn, init, start, end, inc )
+	{
+		var
+			i =3D start,
+			value,
+			isSet =3D false;
+=09
+		if ( init !=3D=3D undefined ) {
+			value =3D init;
+			isSet =3D true;
+		}
+=09
+		while ( i !=3D=3D end ) {
+			if ( ! that.hasOwnProperty(i) ) {
+				continue;
+			}
+=09
+			value =3D isSet ?
+				fn( value, that[i], i, that ) :
+				that[i];
+=09
+			isSet =3D true;
+			i +=3D inc;
+		}
+=09
+		return value;
+	}
+=09
+	/**
+	 * Add a column to the list used for the table with default values
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {node} nTh The th element for this column
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnAddColumn( oSettings, nTh )
+	{
+		// Add column to aoColumns array
+		var oDefaults =3D DataTable.defaults.column;
+		var iCol =3D oSettings.aoColumns.length;
+		var oCol =3D $.extend( {}, DataTable.models.oColumn, oDefaults, {
+			"nTh": nTh ? nTh : document.createElement('th'),
+			"sTitle":    oDefaults.sTitle    ? oDefaults.sTitle    : nTh ? nTh.inne=
rHTML : '',
+			"aDataSort": oDefaults.aDataSort ? oDefaults.aDataSort : [iCol],
+			"mData": oDefaults.mData ? oDefaults.mData : iCol,
+			idx: iCol
+		} );
+		oSettings.aoColumns.push( oCol );
+=09
+		// Add search object for column specific search. Note that the `searchCo=
ls[ iCol ]`
+		// passed into extend can be undefined. This allows the user to give a d=
efault
+		// with only some of the parameters defined, and also not give a default
+		var searchCols =3D oSettings.aoPreSearchCols;
+		searchCols[ iCol ] =3D $.extend( {}, DataTable.models.oSearch, searchCol=
s[ iCol ] );
+=09
+		// Use the default column options function to initialise classes etc
+		_fnColumnOptions( oSettings, iCol, $(nTh).data() );
+	}
+=09
+=09
+	/**
+	 * Apply options for a column
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {int} iCol column index to consider
+	 *  @param {object} oOptions object with sType, bVisible and bSearchable =
etc
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnColumnOptions( oSettings, iCol, oOptions )
+	{
+		var oCol =3D oSettings.aoColumns[ iCol ];
+		var oClasses =3D oSettings.oClasses;
+		var th =3D $(oCol.nTh);
+=09
+		// Try to get width information from the DOM. We can't get it from CSS
+		// as we'd need to parse the CSS stylesheet. `width` option can override
+		if ( ! oCol.sWidthOrig ) {
+			// Width attribute
+			oCol.sWidthOrig =3D th.attr('width') || null;
+=09
+			// Style attribute
+			var t =3D (th.attr('style') || '').match(/width:\s*(\d+[pxem%]+)/);
+			if ( t ) {
+				oCol.sWidthOrig =3D t[1];
+			}
+		}
+=09
+		/* User specified column options */
+		if ( oOptions !=3D=3D undefined && oOptions !=3D=3D null )
+		{
+			// Backwards compatibility
+			_fnCompatCols( oOptions );
+=09
+			// Map camel case parameters to their Hungarian counterparts
+			_fnCamelToHungarian( DataTable.defaults.column, oOptions, true );
+=09
+			/* Backwards compatibility for mDataProp */
+			if ( oOptions.mDataProp !=3D=3D undefined && !oOptions.mData )
+			{
+				oOptions.mData =3D oOptions.mDataProp;
+			}
+=09
+			if ( oOptions.sType )
+			{
+				oCol._sManualType =3D oOptions.sType;
+			}
+=09
+			// `class` is a reserved word in Javascript, so we need to provide
+			// the ability to use a valid name for the camel case input
+			if ( oOptions.className && ! oOptions.sClass )
+			{
+				oOptions.sClass =3D oOptions.className;
+			}
+			if ( oOptions.sClass ) {
+				th.addClass( oOptions.sClass );
+			}
+=09
+			$.extend( oCol, oOptions );
+			_fnMap( oCol, oOptions, "sWidth", "sWidthOrig" );
+=09
+			/* iDataSort to be applied (backwards compatibility), but aDataSort wil=
l take
+			 * priority if defined
+			 */
+			if ( oOptions.iDataSort !=3D=3D undefined )
+			{
+				oCol.aDataSort =3D [ oOptions.iDataSort ];
+			}
+			_fnMap( oCol, oOptions, "aDataSort" );
+		}
+=09
+		/* Cache the data get and set functions for speed */
+		var mDataSrc =3D oCol.mData;
+		var mData =3D _fnGetObjectDataFn( mDataSrc );
+		var mRender =3D oCol.mRender ? _fnGetObjectDataFn( oCol.mRender ) : null;
+=09
+		var attrTest =3D function( src ) {
+			return typeof src =3D=3D=3D 'string' && src.indexOf('@') !=3D=3D -1;
+		};
+		oCol._bAttrSrc =3D $.isPlainObject( mDataSrc ) && (
+			attrTest(mDataSrc.sort) || attrTest(mDataSrc.type) || attrTest(mDataSrc=
.filter)
+		);
+		oCol._setter =3D null;
+=09
+		oCol.fnGetData =3D function (rowData, type, meta) {
+			var innerData =3D mData( rowData, type, undefined, meta );
+=09
+			return mRender && type ?
+				mRender( innerData, type, rowData, meta ) :
+				innerData;
+		};
+		oCol.fnSetData =3D function ( rowData, val, meta ) {
+			return _fnSetObjectDataFn( mDataSrc )( rowData, val, meta );
+		};
+=09
+		// Indicate if DataTables should read DOM data as an object or array
+		// Used in _fnGetRowElements
+		if ( typeof mDataSrc !=3D=3D 'number' ) {
+			oSettings._rowReadObject =3D true;
+		}
+=09
+		/* Feature sorting overrides column specific when off */
+		if ( !oSettings.oFeatures.bSort )
+		{
+			oCol.bSortable =3D false;
+			th.addClass( oClasses.sSortableNone ); // Have to add class here as ord=
er event isn't called
+		}
+=09
+		/* Check that the class assignment is correct for sorting */
+		var bAsc =3D $.inArray('asc', oCol.asSorting) !=3D=3D -1;
+		var bDesc =3D $.inArray('desc', oCol.asSorting) !=3D=3D -1;
+		if ( !oCol.bSortable || (!bAsc && !bDesc) )
+		{
+			oCol.sSortingClass =3D oClasses.sSortableNone;
+			oCol.sSortingClassJUI =3D "";
+		}
+		else if ( bAsc && !bDesc )
+		{
+			oCol.sSortingClass =3D oClasses.sSortableAsc;
+			oCol.sSortingClassJUI =3D oClasses.sSortJUIAscAllowed;
+		}
+		else if ( !bAsc && bDesc )
+		{
+			oCol.sSortingClass =3D oClasses.sSortableDesc;
+			oCol.sSortingClassJUI =3D oClasses.sSortJUIDescAllowed;
+		}
+		else
+		{
+			oCol.sSortingClass =3D oClasses.sSortable;
+			oCol.sSortingClassJUI =3D oClasses.sSortJUI;
+		}
+	}
+=09
+=09
+	/**
+	 * Adjust the table column widths for new data. Note: you would probably =
want to
+	 * do a redraw after calling this function!
+	 *  @param {object} settings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnAdjustColumnSizing ( settings )
+	{
+		/* Not interested in doing column width calculation if auto-width is dis=
abled */
+		if ( settings.oFeatures.bAutoWidth !=3D=3D false )
+		{
+			var columns =3D settings.aoColumns;
+=09
+			_fnCalculateColumnWidths( settings );
+			for ( var i=3D0 , iLen=3Dcolumns.length ; i<iLen ; i++ )
+			{
+				columns[i].nTh.style.width =3D columns[i].sWidth;
+			}
+		}
+=09
+		var scroll =3D settings.oScroll;
+		if ( scroll.sY !=3D=3D '' || scroll.sX !=3D=3D '')
+		{
+			_fnScrollDraw( settings );
+		}
+=09
+		_fnCallbackFire( settings, null, 'column-sizing', [settings] );
+	}
+=09
+=09
+	/**
+	 * Convert the index of a visible column to the index in the data array (=
take account
+	 * of hidden columns)
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {int} iMatch Visible column index to lookup
+	 *  @returns {int} i the data index
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnVisibleToColumnIndex( oSettings, iMatch )
+	{
+		var aiVis =3D _fnGetColumns( oSettings, 'bVisible' );
+=09
+		return typeof aiVis[iMatch] =3D=3D=3D 'number' ?
+			aiVis[iMatch] :
+			null;
+	}
+=09
+=09
+	/**
+	 * Convert the index of an index in the data array and convert it to the =
visible
+	 *   column index (take account of hidden columns)
+	 *  @param {int} iMatch Column index to lookup
+	 *  @param {object} oSettings dataTables settings object
+	 *  @returns {int} i the data index
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnColumnIndexToVisible( oSettings, iMatch )
+	{
+		var aiVis =3D _fnGetColumns( oSettings, 'bVisible' );
+		var iPos =3D $.inArray( iMatch, aiVis );
+=09
+		return iPos !=3D=3D -1 ? iPos : null;
+	}
+=09
+=09
+	/**
+	 * Get the number of visible columns
+	 *  @param {object} oSettings dataTables settings object
+	 *  @returns {int} i the number of visible columns
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnVisbleColumns( oSettings )
+	{
+		var vis =3D 0;
+=09
+		// No reduce in IE8, use a loop for now
+		$.each( oSettings.aoColumns, function ( i, col ) {
+			if ( col.bVisible && $(col.nTh).css('display') !=3D=3D 'none' ) {
+				vis++;
+			}
+		} );
+=09
+		return vis;
+	}
+=09
+=09
+	/**
+	 * Get an array of column indexes that match a given property
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {string} sParam Parameter in aoColumns to look for - typically
+	 *    bVisible or bSearchable
+	 *  @returns {array} Array of indexes with matched properties
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnGetColumns( oSettings, sParam )
+	{
+		var a =3D [];
+=09
+		$.map( oSettings.aoColumns, function(val, i) {
+			if ( val[sParam] ) {
+				a.push( i );
+			}
+		} );
+=09
+		return a;
+	}
+=09
+=09
+	/**
+	 * Calculate the 'type' of a column
+	 *  @param {object} settings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnColumnTypes ( settings )
+	{
+		var columns =3D settings.aoColumns;
+		var data =3D settings.aoData;
+		var types =3D DataTable.ext.type.detect;
+		var i, ien, j, jen, k, ken;
+		var col, cell, detectedType, cache;
+=09
+		// For each column, spin over the=20
+		for ( i=3D0, ien=3Dcolumns.length ; i<ien ; i++ ) {
+			col =3D columns[i];
+			cache =3D [];
+=09
+			if ( ! col.sType && col._sManualType ) {
+				col.sType =3D col._sManualType;
+			}
+			else if ( ! col.sType ) {
+				for ( j=3D0, jen=3Dtypes.length ; j<jen ; j++ ) {
+					for ( k=3D0, ken=3Ddata.length ; k<ken ; k++ ) {
+						// Use a cache array so we only need to get the type data
+						// from the formatter once (when using multiple detectors)
+						if ( cache[k] =3D=3D=3D undefined ) {
+							cache[k] =3D _fnGetCellData( settings, k, i, 'type' );
+						}
+=09
+						detectedType =3D types[j]( cache[k], settings );
+=09
+						// If null, then this type can't apply to this column, so
+						// rather than testing all cells, break out. There is an
+						// exception for the last type which is `html`. We need to
+						// scan all rows since it is possible to mix string and HTML
+						// types
+						if ( ! detectedType && j !=3D=3D types.length-1 ) {
+							break;
+						}
+=09
+						// Only a single match is needed for html type since it is
+						// bottom of the pile and very similar to string - but it
+						// must not be empty
+						if ( detectedType =3D=3D=3D 'html' && ! _empty(cache[k]) ) {
+							break;
+						}
+					}
+=09
+					// Type is valid for all data points in the column - use this
+					// type
+					if ( detectedType ) {
+						col.sType =3D detectedType;
+						break;
+					}
+				}
+=09
+				// Fall back - if no type was detected, always use string
+				if ( ! col.sType ) {
+					col.sType =3D 'string';
+				}
+			}
+		}
+	}
+=09
+=09
+	/**
+	 * Take the column definitions and static columns arrays and calculate how
+	 * they relate to column indexes. The callback function will then apply t=
he
+	 * definition found for a column to a suitable configuration object.
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {array} aoColDefs The aoColumnDefs array that is to be applied
+	 *  @param {array} aoCols The aoColumns array that defines columns indivi=
dually
+	 *  @param {function} fn Callback function - takes two parameters, the ca=
lculated
+	 *    column index and the definition for that column.
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnApplyColumnDefs( oSettings, aoColDefs, aoCols, fn )
+	{
+		var i, iLen, j, jLen, k, kLen, def;
+		var columns =3D oSettings.aoColumns;
+=09
+		// Column definitions with aTargets
+		if ( aoColDefs )
+		{
+			/* Loop over the definitions array - loop in reverse so first instance =
has priority */
+			for ( i=3DaoColDefs.length-1 ; i>=3D0 ; i-- )
+			{
+				def =3D aoColDefs[i];
+=09
+				/* Each definition can target multiple columns, as it is an array */
+				var aTargets =3D def.targets !=3D=3D undefined ?
+					def.targets :
+					def.aTargets;
+=09
+				if ( ! Array.isArray( aTargets ) )
+				{
+					aTargets =3D [ aTargets ];
+				}
+=09
+				for ( j=3D0, jLen=3DaTargets.length ; j<jLen ; j++ )
+				{
+					if ( typeof aTargets[j] =3D=3D=3D 'number' && aTargets[j] >=3D 0 )
+					{
+						/* Add columns that we don't yet know about */
+						while( columns.length <=3D aTargets[j] )
+						{
+							_fnAddColumn( oSettings );
+						}
+=09
+						/* Integer, basic index */
+						fn( aTargets[j], def );
+					}
+					else if ( typeof aTargets[j] =3D=3D=3D 'number' && aTargets[j] < 0 )
+					{
+						/* Negative integer, right to left column counting */
+						fn( columns.length+aTargets[j], def );
+					}
+					else if ( typeof aTargets[j] =3D=3D=3D 'string' )
+					{
+						/* Class name matching on TH element */
+						for ( k=3D0, kLen=3Dcolumns.length ; k<kLen ; k++ )
+						{
+							if ( aTargets[j] =3D=3D "_all" ||
+							     $(columns[k].nTh).hasClass( aTargets[j] ) )
+							{
+								fn( k, def );
+							}
+						}
+					}
+				}
+			}
+		}
+=09
+		// Statically defined columns array
+		if ( aoCols )
+		{
+			for ( i=3D0, iLen=3DaoCols.length ; i<iLen ; i++ )
+			{
+				fn( i, aoCols[i] );
+			}
+		}
+	}
+=09
+	/**
+	 * Add a data array to the table, creating DOM node etc. This is the para=
llel to
+	 * _fnGatherData, but for adding rows from a Javascript source, rather th=
an a
+	 * DOM source.
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {array} aData data array to be added
+	 *  @param {node} [nTr] TR element to add to the table - optional. If not=
 given,
+	 *    DataTables will create a row automatically
+	 *  @param {array} [anTds] Array of TD|TH elements for the row - must be =
given
+	 *    if nTr is.
+	 *  @returns {int} >=3D0 if successful (index of new aoData entry), -1 if=
 failed
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnAddData ( oSettings, aDataIn, nTr, anTds )
+	{
+		/* Create the object for storing information about this new row */
+		var iRow =3D oSettings.aoData.length;
+		var oData =3D $.extend( true, {}, DataTable.models.oRow, {
+			src: nTr ? 'dom' : 'data',
+			idx: iRow
+		} );
+=09
+		oData._aData =3D aDataIn;
+		oSettings.aoData.push( oData );
+=09
+		/* Create the cells */
+		var nTd, sThisType;
+		var columns =3D oSettings.aoColumns;
+=09
+		// Invalidate the column types as the new data needs to be revalidated
+		for ( var i=3D0, iLen=3Dcolumns.length ; i<iLen ; i++ )
+		{
+			columns[i].sType =3D null;
+		}
+=09
+		/* Add to the display array */
+		oSettings.aiDisplayMaster.push( iRow );
+=09
+		var id =3D oSettings.rowIdFn( aDataIn );
+		if ( id !=3D=3D undefined ) {
+			oSettings.aIds[ id ] =3D oData;
+		}
+=09
+		/* Create the DOM information, or register it if already present */
+		if ( nTr || ! oSettings.oFeatures.bDeferRender )
+		{
+			_fnCreateTr( oSettings, iRow, nTr, anTds );
+		}
+=09
+		return iRow;
+	}
+=09
+=09
+	/**
+	 * Add one or more TR elements to the table. Generally we'd expect to
+	 * use this for reading data from a DOM sourced table, but it could be
+	 * used for an TR element. Note that if a TR is given, it is used (i.e.
+	 * it is not cloned).
+	 *  @param {object} settings dataTables settings object
+	 *  @param {array|node|jQuery} trs The TR element(s) to add to the table
+	 *  @returns {array} Array of indexes for the added rows
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnAddTr( settings, trs )
+	{
+		var row;
+=09
+		// Allow an individual node to be passed in
+		if ( ! (trs instanceof $) ) {
+			trs =3D $(trs);
+		}
+=09
+		return trs.map( function (i, el) {
+			row =3D _fnGetRowElements( settings, el );
+			return _fnAddData( settings, row.data, el, row.cells );
+		} );
+	}
+=09
+=09
+	/**
+	 * Take a TR element and convert it to an index in aoData
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {node} n the TR element to find
+	 *  @returns {int} index if the node is found, null if not
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnNodeToDataIndex( oSettings, n )
+	{
+		return (n._DT_RowIndex!=3D=3Dundefined) ? n._DT_RowIndex : null;
+	}
+=09
+=09
+	/**
+	 * Take a TD element and convert it into a column data index (not the vis=
ible index)
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {int} iRow The row number the TD/TH can be found in
+	 *  @param {node} n The TD/TH element to find
+	 *  @returns {int} index if the node is found, -1 if not
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnNodeToColumnIndex( oSettings, iRow, n )
+	{
+		return $.inArray( n, oSettings.aoData[ iRow ].anCells );
+	}
+=09
+=09
+	/**
+	 * Get the data for a given cell from the internal cache, taking into acc=
ount data mapping
+	 *  @param {object} settings dataTables settings object
+	 *  @param {int} rowIdx aoData row id
+	 *  @param {int} colIdx Column index
+	 *  @param {string} type data get type ('display', 'type' 'filter|search'=
 'sort|order')
+	 *  @returns {*} Cell data
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnGetCellData( settings, rowIdx, colIdx, type )
+	{
+		if (type =3D=3D=3D 'search') {
+			type =3D 'filter';
+		}
+		else if (type =3D=3D=3D 'order') {
+			type =3D 'sort';
+		}
+=09
+		var draw           =3D settings.iDraw;
+		var col            =3D settings.aoColumns[colIdx];
+		var rowData        =3D settings.aoData[rowIdx]._aData;
+		var defaultContent =3D col.sDefaultContent;
+		var cellData       =3D col.fnGetData( rowData, type, {
+			settings: settings,
+			row:      rowIdx,
+			col:      colIdx
+		} );
+=09
+		if ( cellData =3D=3D=3D undefined ) {
+			if ( settings.iDrawError !=3D draw && defaultContent =3D=3D=3D null ) {
+				_fnLog( settings, 0, "Requested unknown parameter "+
+					(typeof col.mData=3D=3D'function' ? '{function}' : "'"+col.mData+"'")+
+					" for row "+rowIdx+", column "+colIdx, 4 );
+				settings.iDrawError =3D draw;
+			}
+			return defaultContent;
+		}
+=09
+		// When the data source is null and a specific data type is requested (i=
.e.
+		// not the original data), we can use default column data
+		if ( (cellData =3D=3D=3D rowData || cellData =3D=3D=3D null) && defaultC=
ontent !=3D=3D null && type !=3D=3D undefined ) {
+			cellData =3D defaultContent;
+		}
+		else if ( typeof cellData =3D=3D=3D 'function' ) {
+			// If the data source is a function, then we run it and use the return,
+			// executing in the scope of the data object (for instances)
+			return cellData.call( rowData );
+		}
+=09
+		if ( cellData =3D=3D=3D null && type =3D=3D=3D 'display' ) {
+			return '';
+		}
+=09
+		if ( type =3D=3D=3D 'filter' ) {
+			var fomatters =3D DataTable.ext.type.search;
+=09
+			if ( fomatters[ col.sType ] ) {
+				cellData =3D fomatters[ col.sType ]( cellData );
+			}
+		}
+=09
+		return cellData;
+	}
+=09
+=09
+	/**
+	 * Set the value for a specific cell, into the internal data cache
+	 *  @param {object} settings dataTables settings object
+	 *  @param {int} rowIdx aoData row id
+	 *  @param {int} colIdx Column index
+	 *  @param {*} val Value to set
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnSetCellData( settings, rowIdx, colIdx, val )
+	{
+		var col     =3D settings.aoColumns[colIdx];
+		var rowData =3D settings.aoData[rowIdx]._aData;
+=09
+		col.fnSetData( rowData, val, {
+			settings: settings,
+			row:      rowIdx,
+			col:      colIdx
+		}  );
+	}
+=09
+=09
+	// Private variable that is used to match action syntax in the data prope=
rty object
+	var __reArray =3D /\[.*?\]$/;
+	var __reFn =3D /\(\)$/;
+=09
+	/**
+	 * Split string on periods, taking into account escaped periods
+	 * @param  {string} str String to split
+	 * @return {array} Split string
+	 */
+	function _fnSplitObjNotation( str )
+	{
+		return $.map( str.match(/(\\.|[^\.])+/g) || [''], function ( s ) {
+			return s.replace(/\\\./g, '.');
+		} );
+	}
+=09
+=09
+	/**
+	 * Return a function that can be used to get data from a source object, t=
aking
+	 * into account the ability to use nested objects as a source
+	 *  @param {string|int|function} mSource The data source for the object
+	 *  @returns {function} Data get function
+	 *  @memberof DataTable#oApi
+	 */
+	var _fnGetObjectDataFn =3D DataTable.util.get;
+=09
+=09
+	/**
+	 * Return a function that can be used to set data from a source object, t=
aking
+	 * into account the ability to use nested objects as a source
+	 *  @param {string|int|function} mSource The data source for the object
+	 *  @returns {function} Data set function
+	 *  @memberof DataTable#oApi
+	 */
+	var _fnSetObjectDataFn =3D DataTable.util.set;
+=09
+=09
+	/**
+	 * Return an array with the full table data
+	 *  @param {object} oSettings dataTables settings object
+	 *  @returns array {array} aData Master data array
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnGetDataMaster ( settings )
+	{
+		return _pluck( settings.aoData, '_aData' );
+	}
+=09
+=09
+	/**
+	 * Nuke the table
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnClearTable( settings )
+	{
+		settings.aoData.length =3D 0;
+		settings.aiDisplayMaster.length =3D 0;
+		settings.aiDisplay.length =3D 0;
+		settings.aIds =3D {};
+	}
+=09
+=09
+	 /**
+	 * Take an array of integers (index array) and remove a target integer (v=
alue - not
+	 * the key!)
+	 *  @param {array} a Index array to target
+	 *  @param {int} iTarget value to find
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnDeleteIndex( a, iTarget, splice )
+	{
+		var iTargetIndex =3D -1;
+=09
+		for ( var i=3D0, iLen=3Da.length ; i<iLen ; i++ )
+		{
+			if ( a[i] =3D=3D iTarget )
+			{
+				iTargetIndex =3D i;
+			}
+			else if ( a[i] > iTarget )
+			{
+				a[i]--;
+			}
+		}
+=09
+		if ( iTargetIndex !=3D -1 && splice =3D=3D=3D undefined )
+		{
+			a.splice( iTargetIndex, 1 );
+		}
+	}
+=09
+=09
+	/**
+	 * Mark cached data as invalid such that a re-read of the data will occur=
 when
+	 * the cached data is next requested. Also update from the data source ob=
ject.
+	 *
+	 * @param {object} settings DataTables settings object
+	 * @param {int}    rowIdx   Row index to invalidate
+	 * @param {string} [src]    Source to invalidate from: undefined, 'auto',=
 'dom'
+	 *     or 'data'
+	 * @param {int}    [colIdx] Column index to invalidate. If undefined the =
whole
+	 *     row will be invalidated
+	 * @memberof DataTable#oApi
+	 *
+	 * @todo For the modularisation of v1.11 this will need to become a callb=
ack, so
+	 *   the sort and filter methods can subscribe to it. That will required
+	 *   initialisation options for sorting, which is why it is not already b=
aked in
+	 */
+	function _fnInvalidate( settings, rowIdx, src, colIdx )
+	{
+		var row =3D settings.aoData[ rowIdx ];
+		var i, ien;
+		var cellWrite =3D function ( cell, col ) {
+			// This is very frustrating, but in IE if you just write directly
+			// to innerHTML, and elements that are overwritten are GC'ed,
+			// even if there is a reference to them elsewhere
+			while ( cell.childNodes.length ) {
+				cell.removeChild( cell.firstChild );
+			}
+=09
+			cell.innerHTML =3D _fnGetCellData( settings, rowIdx, col, 'display' );
+		};
+=09
+		// Are we reading last data from DOM or the data object?
+		if ( src =3D=3D=3D 'dom' || ((! src || src =3D=3D=3D 'auto') && row.src =
=3D=3D=3D 'dom') ) {
+			// Read the data from the DOM
+			row._aData =3D _fnGetRowElements(
+					settings, row, colIdx, colIdx =3D=3D=3D undefined ? undefined : row._=
aData
+				)
+				.data;
+		}
+		else {
+			// Reading from data object, update the DOM
+			var cells =3D row.anCells;
+=09
+			if ( cells ) {
+				if ( colIdx !=3D=3D undefined ) {
+					cellWrite( cells[colIdx], colIdx );
+				}
+				else {
+					for ( i=3D0, ien=3Dcells.length ; i<ien ; i++ ) {
+						cellWrite( cells[i], i );
+					}
+				}
+			}
+		}
+=09
+		// For both row and cell invalidation, the cached data for sorting and
+		// filtering is nulled out
+		row._aSortData =3D null;
+		row._aFilterData =3D null;
+=09
+		// Invalidate the type for a specific column (if given) or all columns s=
ince
+		// the data might have changed
+		var cols =3D settings.aoColumns;
+		if ( colIdx !=3D=3D undefined ) {
+			cols[ colIdx ].sType =3D null;
+		}
+		else {
+			for ( i=3D0, ien=3Dcols.length ; i<ien ; i++ ) {
+				cols[i].sType =3D null;
+			}
+=09
+			// Update DataTables special `DT_*` attributes for the row
+			_fnRowAttributes( settings, row );
+		}
+	}
+=09
+=09
+	/**
+	 * Build a data source object from an HTML row, reading the contents of t=
he
+	 * cells that are in the row.
+	 *
+	 * @param {object} settings DataTables settings object
+	 * @param {node|object} TR element from which to read data or existing row
+	 *   object from which to re-read the data from the cells
+	 * @param {int} [colIdx] Optional column index
+	 * @param {array|object} [d] Data source object. If `colIdx` is given the=
n this
+	 *   parameter should also be given and will be used to write the data in=
to.
+	 *   Only the column in question will be written
+	 * @returns {object} Object with two parameters: `data` the data read, in
+	 *   document order, and `cells` and array of nodes (they can be useful t=
o the
+	 *   caller, so rather than needing a second traversal to get them, just =
return
+	 *   them from here).
+	 * @memberof DataTable#oApi
+	 */
+	function _fnGetRowElements( settings, row, colIdx, d )
+	{
+		var
+			tds =3D [],
+			td =3D row.firstChild,
+			name, col, o, i=3D0, contents,
+			columns =3D settings.aoColumns,
+			objectRead =3D settings._rowReadObject;
+=09
+		// Allow the data object to be passed in, or construct
+		d =3D d !=3D=3D undefined ?
+			d :
+			objectRead ?
+				{} :
+				[];
+=09
+		var attr =3D function ( str, td  ) {
+			if ( typeof str =3D=3D=3D 'string' ) {
+				var idx =3D str.indexOf('@');
+=09
+				if ( idx !=3D=3D -1 ) {
+					var attr =3D str.substring( idx+1 );
+					var setter =3D _fnSetObjectDataFn( str );
+					setter( d, td.getAttribute( attr ) );
+				}
+			}
+		};
+=09
+		// Read data from a cell and store into the data object
+		var cellProcess =3D function ( cell ) {
+			if ( colIdx =3D=3D=3D undefined || colIdx =3D=3D=3D i ) {
+				col =3D columns[i];
+				contents =3D (cell.innerHTML).trim();
+=09
+				if ( col && col._bAttrSrc ) {
+					var setter =3D _fnSetObjectDataFn( col.mData._ );
+					setter( d, contents );
+=09
+					attr( col.mData.sort, cell );
+					attr( col.mData.type, cell );
+					attr( col.mData.filter, cell );
+				}
+				else {
+					// Depending on the `data` option for the columns the data can
+					// be read to either an object or an array.
+					if ( objectRead ) {
+						if ( ! col._setter ) {
+							// Cache the setter function
+							col._setter =3D _fnSetObjectDataFn( col.mData );
+						}
+						col._setter( d, contents );
+					}
+					else {
+						d[i] =3D contents;
+					}
+				}
+			}
+=09
+			i++;
+		};
+=09
+		if ( td ) {
+			// `tr` element was passed in
+			while ( td ) {
+				name =3D td.nodeName.toUpperCase();
+=09
+				if ( name =3D=3D "TD" || name =3D=3D "TH" ) {
+					cellProcess( td );
+					tds.push( td );
+				}
+=09
+				td =3D td.nextSibling;
+			}
+		}
+		else {
+			// Existing row object passed in
+			tds =3D row.anCells;
+=09
+			for ( var j=3D0, jen=3Dtds.length ; j<jen ; j++ ) {
+				cellProcess( tds[j] );
+			}
+		}
+=09
+		// Read the ID from the DOM if present
+		var rowNode =3D row.firstChild ? row : row.nTr;
+=09
+		if ( rowNode ) {
+			var id =3D rowNode.getAttribute( 'id' );
+=09
+			if ( id ) {
+				_fnSetObjectDataFn( settings.rowId )( d, id );
+			}
+		}
+=09
+		return {
+			data: d,
+			cells: tds
+		};
+	}
+	/**
+	 * Create a new TR element (and it's TD children) for a row
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {int} iRow Row to consider
+	 *  @param {node} [nTrIn] TR element to add to the table - optional. If n=
ot given,
+	 *    DataTables will create a row automatically
+	 *  @param {array} [anTds] Array of TD|TH elements for the row - must be =
given
+	 *    if nTr is.
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnCreateTr ( oSettings, iRow, nTrIn, anTds )
+	{
+		var
+			row =3D oSettings.aoData[iRow],
+			rowData =3D row._aData,
+			cells =3D [],
+			nTr, nTd, oCol,
+			i, iLen, create;
+=09
+		if ( row.nTr =3D=3D=3D null )
+		{
+			nTr =3D nTrIn || document.createElement('tr');
+=09
+			row.nTr =3D nTr;
+			row.anCells =3D cells;
+=09
+			/* Use a private property on the node to allow reserve mapping from the=
 node
+			 * to the aoData array for fast look up
+			 */
+			nTr._DT_RowIndex =3D iRow;
+=09
+			/* Special parameters can be given by the data source to be used on the=
 row */
+			_fnRowAttributes( oSettings, row );
+=09
+			/* Process each column */
+			for ( i=3D0, iLen=3DoSettings.aoColumns.length ; i<iLen ; i++ )
+			{
+				oCol =3D oSettings.aoColumns[i];
+				create =3D nTrIn ? false : true;
+=09
+				nTd =3D create ? document.createElement( oCol.sCellType ) : anTds[i];
+				nTd._DT_CellIndex =3D {
+					row: iRow,
+					column: i
+				};
+=09=09=09=09
+				cells.push( nTd );
+=09
+				// Need to create the HTML if new, or if a rendering function is defin=
ed
+				if ( create || ((oCol.mRender || oCol.mData !=3D=3D i) &&
+					 (!$.isPlainObject(oCol.mData) || oCol.mData._ !=3D=3D i+'.display')
+				)) {
+					nTd.innerHTML =3D _fnGetCellData( oSettings, iRow, i, 'display' );
+				}
+=09
+				/* Add user defined class */
+				if ( oCol.sClass )
+				{
+					nTd.className +=3D ' '+oCol.sClass;
+				}
+=09
+				// Visibility - add or remove as required
+				if ( oCol.bVisible && ! nTrIn )
+				{
+					nTr.appendChild( nTd );
+				}
+				else if ( ! oCol.bVisible && nTrIn )
+				{
+					nTd.parentNode.removeChild( nTd );
+				}
+=09
+				if ( oCol.fnCreatedCell )
+				{
+					oCol.fnCreatedCell.call( oSettings.oInstance,
+						nTd, _fnGetCellData( oSettings, iRow, i ), rowData, iRow, i
+					);
+				}
+			}
+=09
+			_fnCallbackFire( oSettings, 'aoRowCreatedCallback', null, [nTr, rowData=
, iRow, cells] );
+		}
+	}
+=09
+=09
+	/**
+	 * Add attributes to a row based on the special `DT_*` parameters in a da=
ta
+	 * source object.
+	 *  @param {object} settings DataTables settings object
+	 *  @param {object} DataTables row object for the row to be modified
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnRowAttributes( settings, row )
+	{
+		var tr =3D row.nTr;
+		var data =3D row._aData;
+=09
+		if ( tr ) {
+			var id =3D settings.rowIdFn( data );
+=09
+			if ( id ) {
+				tr.id =3D id;
+			}
+=09
+			if ( data.DT_RowClass ) {
+				// Remove any classes added by DT_RowClass before
+				var a =3D data.DT_RowClass.split(' ');
+				row.__rowc =3D row.__rowc ?
+					_unique( row.__rowc.concat( a ) ) :
+					a;
+=09
+				$(tr)
+					.removeClass( row.__rowc.join(' ') )
+					.addClass( data.DT_RowClass );
+			}
+=09
+			if ( data.DT_RowAttr ) {
+				$(tr).attr( data.DT_RowAttr );
+			}
+=09
+			if ( data.DT_RowData ) {
+				$(tr).data( data.DT_RowData );
+			}
+		}
+	}
+=09
+=09
+	/**
+	 * Create the HTML header for the table
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnBuildHead( oSettings )
+	{
+		var i, ien, cell, row, column;
+		var thead =3D oSettings.nTHead;
+		var tfoot =3D oSettings.nTFoot;
+		var createHeader =3D $('th, td', thead).length =3D=3D=3D 0;
+		var classes =3D oSettings.oClasses;
+		var columns =3D oSettings.aoColumns;
+=09
+		if ( createHeader ) {
+			row =3D $('<tr/>').appendTo( thead );
+		}
+=09
+		for ( i=3D0, ien=3Dcolumns.length ; i<ien ; i++ ) {
+			column =3D columns[i];
+			cell =3D $( column.nTh ).addClass( column.sClass );
+=09
+			if ( createHeader ) {
+				cell.appendTo( row );
+			}
+=09
+			// 1.11 move into sorting
+			if ( oSettings.oFeatures.bSort ) {
+				cell.addClass( column.sSortingClass );
+=09
+				if ( column.bSortable !=3D=3D false ) {
+					cell
+						.attr( 'tabindex', oSettings.iTabIndex )
+						.attr( 'aria-controls', oSettings.sTableId );
+=09
+					_fnSortAttachListener( oSettings, column.nTh, i );
+				}
+			}
+=09
+			if ( column.sTitle !=3D cell[0].innerHTML ) {
+				cell.html( column.sTitle );
+			}
+=09
+			_fnRenderer( oSettings, 'header' )(
+				oSettings, cell, column, classes
+			);
+		}
+=09
+		if ( createHeader ) {
+			_fnDetectHeader( oSettings.aoHeader, thead );
+		}
+=09
+		/* Deal with the footer - add classes if required */
+		$(thead).children('tr').children('th, td').addClass( classes.sHeaderTH );
+		$(tfoot).children('tr').children('th, td').addClass( classes.sFooterTH );
+=09
+		// Cache the footer cells. Note that we only take the cells from the fir=
st
+		// row in the footer. If there is more than one row the user wants to
+		// interact with, they need to use the table().foot() method. Note also =
this
+		// allows cells to be used for multiple columns using colspan
+		if ( tfoot !=3D=3D null ) {
+			var cells =3D oSettings.aoFooter[0];
+=09
+			for ( i=3D0, ien=3Dcells.length ; i<ien ; i++ ) {
+				column =3D columns[i];
+				column.nTf =3D cells[i].cell;
+=09
+				if ( column.sClass ) {
+					$(column.nTf).addClass( column.sClass );
+				}
+			}
+		}
+	}
+=09
+=09
+	/**
+	 * Draw the header (or footer) element based on the column visibility sta=
tes. The
+	 * methodology here is to use the layout array from _fnDetectHeader, modi=
fied for
+	 * the instantaneous column visibility, to construct the new layout. The =
grid is
+	 * traversed over cell at a time in a rows x columns grid fashion, althou=
gh each
+	 * cell insert can cover multiple elements in the grid - which is tracks =
using the
+	 * aApplied array. Cell inserts in the grid will only occur where there i=
sn't
+	 * already a cell in that position.
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param array {objects} aoSource Layout array from _fnDetectHeader
+	 *  @param {boolean} [bIncludeHidden=3Dfalse] If true then include the hi=
dden columns in the calc,
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnDrawHead( oSettings, aoSource, bIncludeHidden )
+	{
+		var i, iLen, j, jLen, k, kLen, n, nLocalTr;
+		var aoLocal =3D [];
+		var aApplied =3D [];
+		var iColumns =3D oSettings.aoColumns.length;
+		var iRowspan, iColspan;
+=09
+		if ( ! aoSource )
+		{
+			return;
+		}
+=09
+		if (  bIncludeHidden =3D=3D=3D undefined )
+		{
+			bIncludeHidden =3D false;
+		}
+=09
+		/* Make a copy of the master layout array, but without the visible colum=
ns in it */
+		for ( i=3D0, iLen=3DaoSource.length ; i<iLen ; i++ )
+		{
+			aoLocal[i] =3D aoSource[i].slice();
+			aoLocal[i].nTr =3D aoSource[i].nTr;
+=09
+			/* Remove any columns which are currently hidden */
+			for ( j=3DiColumns-1 ; j>=3D0 ; j-- )
+			{
+				if ( !oSettings.aoColumns[j].bVisible && !bIncludeHidden )
+				{
+					aoLocal[i].splice( j, 1 );
+				}
+			}
+=09
+			/* Prep the applied array - it needs an element for each row */
+			aApplied.push( [] );
+		}
+=09
+		for ( i=3D0, iLen=3DaoLocal.length ; i<iLen ; i++ )
+		{
+			nLocalTr =3D aoLocal[i].nTr;
+=09
+			/* All cells are going to be replaced, so empty out the row */
+			if ( nLocalTr )
+			{
+				while( (n =3D nLocalTr.firstChild) )
+				{
+					nLocalTr.removeChild( n );
+				}
+			}
+=09
+			for ( j=3D0, jLen=3DaoLocal[i].length ; j<jLen ; j++ )
+			{
+				iRowspan =3D 1;
+				iColspan =3D 1;
+=09
+				/* Check to see if there is already a cell (row/colspan) covering our =
target
+				 * insert point. If there is, then there is nothing to do.
+				 */
+				if ( aApplied[i][j] =3D=3D=3D undefined )
+				{
+					nLocalTr.appendChild( aoLocal[i][j].cell );
+					aApplied[i][j] =3D 1;
+=09
+					/* Expand the cell to cover as many rows as needed */
+					while ( aoLocal[i+iRowspan] !=3D=3D undefined &&
+					        aoLocal[i][j].cell =3D=3D aoLocal[i+iRowspan][j].cell )
+					{
+						aApplied[i+iRowspan][j] =3D 1;
+						iRowspan++;
+					}
+=09
+					/* Expand the cell to cover as many columns as needed */
+					while ( aoLocal[i][j+iColspan] !=3D=3D undefined &&
+					        aoLocal[i][j].cell =3D=3D aoLocal[i][j+iColspan].cell )
+					{
+						/* Must update the applied array over the rows for the columns */
+						for ( k=3D0 ; k<iRowspan ; k++ )
+						{
+							aApplied[i+k][j+iColspan] =3D 1;
+						}
+						iColspan++;
+					}
+=09
+					/* Do the actual expansion in the DOM */
+					$(aoLocal[i][j].cell)
+						.attr('rowspan', iRowspan)
+						.attr('colspan', iColspan);
+				}
+			}
+		}
+	}
+=09
+=09
+	/**
+	 * Insert the required TR nodes into the table for display
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param ajaxComplete true after ajax call to complete rendering
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnDraw( oSettings, ajaxComplete )
+	{
+		// Allow for state saving and a custom start position
+		_fnStart( oSettings );
+=09
+		/* Provide a pre-callback function which can be used to cancel the draw =
is false is returned */
+		var aPreDraw =3D _fnCallbackFire( oSettings, 'aoPreDrawCallback', 'preDr=
aw', [oSettings] );
+		if ( $.inArray( false, aPreDraw ) !=3D=3D -1 )
+		{
+			_fnProcessingDisplay( oSettings, false );
+			return;
+		}
+=09
+		var anRows =3D [];
+		var iRowCount =3D 0;
+		var asStripeClasses =3D oSettings.asStripeClasses;
+		var iStripes =3D asStripeClasses.length;
+		var oLang =3D oSettings.oLanguage;
+		var bServerSide =3D _fnDataSource( oSettings ) =3D=3D 'ssp';
+		var aiDisplay =3D oSettings.aiDisplay;
+		var iDisplayStart =3D oSettings._iDisplayStart;
+		var iDisplayEnd =3D oSettings.fnDisplayEnd();
+=09
+		oSettings.bDrawing =3D true;
+=09
+		/* Server-side processing draw intercept */
+		if ( oSettings.bDeferLoading )
+		{
+			oSettings.bDeferLoading =3D false;
+			oSettings.iDraw++;
+			_fnProcessingDisplay( oSettings, false );
+		}
+		else if ( !bServerSide )
+		{
+			oSettings.iDraw++;
+		}
+		else if ( !oSettings.bDestroying && !ajaxComplete)
+		{
+			_fnAjaxUpdate( oSettings );
+			return;
+		}
+=09
+		if ( aiDisplay.length !=3D=3D 0 )
+		{
+			var iStart =3D bServerSide ? 0 : iDisplayStart;
+			var iEnd =3D bServerSide ? oSettings.aoData.length : iDisplayEnd;
+=09
+			for ( var j=3DiStart ; j<iEnd ; j++ )
+			{
+				var iDataIndex =3D aiDisplay[j];
+				var aoData =3D oSettings.aoData[ iDataIndex ];
+				if ( aoData.nTr =3D=3D=3D null )
+				{
+					_fnCreateTr( oSettings, iDataIndex );
+				}
+=09
+				var nRow =3D aoData.nTr;
+=09
+				/* Remove the old striping classes and then add the new one */
+				if ( iStripes !=3D=3D 0 )
+				{
+					var sStripe =3D asStripeClasses[ iRowCount % iStripes ];
+					if ( aoData._sRowStripe !=3D sStripe )
+					{
+						$(nRow).removeClass( aoData._sRowStripe ).addClass( sStripe );
+						aoData._sRowStripe =3D sStripe;
+					}
+				}
+=09
+				// Row callback functions - might want to manipulate the row
+				// iRowCount and j are not currently documented. Are they at all
+				// useful?
+				_fnCallbackFire( oSettings, 'aoRowCallback', null,
+					[nRow, aoData._aData, iRowCount, j, iDataIndex] );
+=09
+				anRows.push( nRow );
+				iRowCount++;
+			}
+		}
+		else
+		{
+			/* Table is empty - create a row with an empty message in it */
+			var sZero =3D oLang.sZeroRecords;
+			if ( oSettings.iDraw =3D=3D 1 &&  _fnDataSource( oSettings ) =3D=3D 'aj=
ax' )
+			{
+				sZero =3D oLang.sLoadingRecords;
+			}
+			else if ( oLang.sEmptyTable && oSettings.fnRecordsTotal() =3D=3D=3D 0 )
+			{
+				sZero =3D oLang.sEmptyTable;
+			}
+=09
+			anRows[ 0 ] =3D $( '<tr/>', { 'class': iStripes ? asStripeClasses[0] : =
'' } )
+				.append( $('<td />', {
+					'valign':  'top',
+					'colSpan': _fnVisbleColumns( oSettings ),
+					'class':   oSettings.oClasses.sRowEmpty
+				} ).html( sZero ) )[0];
+		}
+=09
+		/* Header and footer callbacks */
+		_fnCallbackFire( oSettings, 'aoHeaderCallback', 'header', [ $(oSettings.=
nTHead).children('tr')[0],
+			_fnGetDataMaster( oSettings ), iDisplayStart, iDisplayEnd, aiDisplay ] =
);
+=09
+		_fnCallbackFire( oSettings, 'aoFooterCallback', 'footer', [ $(oSettings.=
nTFoot).children('tr')[0],
+			_fnGetDataMaster( oSettings ), iDisplayStart, iDisplayEnd, aiDisplay ] =
);
+=09
+		var body =3D $(oSettings.nTBody);
+=09
+		body.children().detach();
+		body.append( $(anRows) );
+=09
+		/* Call all required callback functions for the end of a draw */
+		_fnCallbackFire( oSettings, 'aoDrawCallback', 'draw', [oSettings] );
+=09
+		/* Draw is complete, sorting and filtering must be as well */
+		oSettings.bSorted =3D false;
+		oSettings.bFiltered =3D false;
+		oSettings.bDrawing =3D false;
+	}
+=09
+=09
+	/**
+	 * Redraw the table - taking account of the various features which are en=
abled
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {boolean} [holdPosition] Keep the current paging position. By =
default
+	 *    the paging is reset to the first page
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnReDraw( settings, holdPosition )
+	{
+		var
+			features =3D settings.oFeatures,
+			sort     =3D features.bSort,
+			filter   =3D features.bFilter;
+=09
+		if ( sort ) {
+			_fnSort( settings );
+		}
+=09
+		if ( filter ) {
+			_fnFilterComplete( settings, settings.oPreviousSearch );
+		}
+		else {
+			// No filtering, so we want to just use the display master
+			settings.aiDisplay =3D settings.aiDisplayMaster.slice();
+		}
+=09
+		if ( holdPosition !=3D=3D true ) {
+			settings._iDisplayStart =3D 0;
+		}
+=09
+		// Let any modules know about the draw hold position state (used by
+		// scrolling internally)
+		settings._drawHold =3D holdPosition;
+=09
+		_fnDraw( settings );
+=09
+		settings._drawHold =3D false;
+	}
+=09
+=09
+	/**
+	 * Add the options to the page HTML for the table
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnAddOptionsHtml ( oSettings )
+	{
+		var classes =3D oSettings.oClasses;
+		var table =3D $(oSettings.nTable);
+		var holding =3D $('<div/>').insertBefore( table ); // Holding element fo=
r speed
+		var features =3D oSettings.oFeatures;
+=09
+		// All DataTables are wrapped in a div
+		var insert =3D $('<div/>', {
+			id:      oSettings.sTableId+'_wrapper',
+			'class': classes.sWrapper + (oSettings.nTFoot ? '' : ' '+classes.sNoFoo=
ter)
+		} );
+=09
+		oSettings.nHolding =3D holding[0];
+		oSettings.nTableWrapper =3D insert[0];
+		oSettings.nTableReinsertBefore =3D oSettings.nTable.nextSibling;
+=09
+		/* Loop over the user set positioning and place the elements as needed */
+		var aDom =3D oSettings.sDom.split('');
+		var featureNode, cOption, nNewNode, cNext, sAttr, j;
+		for ( var i=3D0 ; i<aDom.length ; i++ )
+		{
+			featureNode =3D null;
+			cOption =3D aDom[i];
+=09
+			if ( cOption =3D=3D '<' )
+			{
+				/* New container div */
+				nNewNode =3D $('<div/>')[0];
+=09
+				/* Check to see if we should append an id and/or a class name to the c=
ontainer */
+				cNext =3D aDom[i+1];
+				if ( cNext =3D=3D "'" || cNext =3D=3D '"' )
+				{
+					sAttr =3D "";
+					j =3D 2;
+					while ( aDom[i+j] !=3D cNext )
+					{
+						sAttr +=3D aDom[i+j];
+						j++;
+					}
+=09
+					/* Replace jQuery UI constants @todo depreciated */
+					if ( sAttr =3D=3D "H" )
+					{
+						sAttr =3D classes.sJUIHeader;
+					}
+					else if ( sAttr =3D=3D "F" )
+					{
+						sAttr =3D classes.sJUIFooter;
+					}
+=09
+					/* The attribute can be in the format of "#id.class", "#id" or "class=
" This logic
+					 * breaks the string into parts and applies them as needed
+					 */
+					if ( sAttr.indexOf('.') !=3D -1 )
+					{
+						var aSplit =3D sAttr.split('.');
+						nNewNode.id =3D aSplit[0].substr(1, aSplit[0].length-1);
+						nNewNode.className =3D aSplit[1];
+					}
+					else if ( sAttr.charAt(0) =3D=3D "#" )
+					{
+						nNewNode.id =3D sAttr.substr(1, sAttr.length-1);
+					}
+					else
+					{
+						nNewNode.className =3D sAttr;
+					}
+=09
+					i +=3D j; /* Move along the position array */
+				}
+=09
+				insert.append( nNewNode );
+				insert =3D $(nNewNode);
+			}
+			else if ( cOption =3D=3D '>' )
+			{
+				/* End container div */
+				insert =3D insert.parent();
+			}
+			// @todo Move options into their own plugins?
+			else if ( cOption =3D=3D 'l' && features.bPaginate && features.bLengthC=
hange )
+			{
+				/* Length */
+				featureNode =3D _fnFeatureHtmlLength( oSettings );
+			}
+			else if ( cOption =3D=3D 'f' && features.bFilter )
+			{
+				/* Filter */
+				featureNode =3D _fnFeatureHtmlFilter( oSettings );
+			}
+			else if ( cOption =3D=3D 'r' && features.bProcessing )
+			{
+				/* pRocessing */
+				featureNode =3D _fnFeatureHtmlProcessing( oSettings );
+			}
+			else if ( cOption =3D=3D 't' )
+			{
+				/* Table */
+				featureNode =3D _fnFeatureHtmlTable( oSettings );
+			}
+			else if ( cOption =3D=3D  'i' && features.bInfo )
+			{
+				/* Info */
+				featureNode =3D _fnFeatureHtmlInfo( oSettings );
+			}
+			else if ( cOption =3D=3D 'p' && features.bPaginate )
+			{
+				/* Pagination */
+				featureNode =3D _fnFeatureHtmlPaginate( oSettings );
+			}
+			else if ( DataTable.ext.feature.length !=3D=3D 0 )
+			{
+				/* Plug-in features */
+				var aoFeatures =3D DataTable.ext.feature;
+				for ( var k=3D0, kLen=3DaoFeatures.length ; k<kLen ; k++ )
+				{
+					if ( cOption =3D=3D aoFeatures[k].cFeature )
+					{
+						featureNode =3D aoFeatures[k].fnInit( oSettings );
+						break;
+					}
+				}
+			}
+=09
+			/* Add to the 2D features array */
+			if ( featureNode )
+			{
+				var aanFeatures =3D oSettings.aanFeatures;
+=09
+				if ( ! aanFeatures[cOption] )
+				{
+					aanFeatures[cOption] =3D [];
+				}
+=09
+				aanFeatures[cOption].push( featureNode );
+				insert.append( featureNode );
+			}
+		}
+=09
+		/* Built our DOM structure - replace the holding div with what we want */
+		holding.replaceWith( insert );
+		oSettings.nHolding =3D null;
+	}
+=09
+=09
+	/**
+	 * Use the DOM source to create up an array of header cells. The idea her=
e is to
+	 * create a layout grid (array) of rows x columns, which contains a refer=
ence
+	 * to the cell that that point in the grid (regardless of col/rowspan), s=
uch that
+	 * any column / row could be removed and the new grid constructed
+	 *  @param array {object} aLayout Array to store the calculated layout in
+	 *  @param {node} nThead The header/footer element for the table
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnDetectHeader ( aLayout, nThead )
+	{
+		var nTrs =3D $(nThead).children('tr');
+		var nTr, nCell;
+		var i, k, l, iLen, jLen, iColShifted, iColumn, iColspan, iRowspan;
+		var bUnique;
+		var fnShiftCol =3D function ( a, i, j ) {
+			var k =3D a[i];
+	                while ( k[j] ) {
+				j++;
+			}
+			return j;
+		};
+=09
+		aLayout.splice( 0, aLayout.length );
+=09
+		/* We know how many rows there are in the layout - so prep it */
+		for ( i=3D0, iLen=3DnTrs.length ; i<iLen ; i++ )
+		{
+			aLayout.push( [] );
+		}
+=09
+		/* Calculate a layout array */
+		for ( i=3D0, iLen=3DnTrs.length ; i<iLen ; i++ )
+		{
+			nTr =3D nTrs[i];
+			iColumn =3D 0;
+=09
+			/* For every cell in the row... */
+			nCell =3D nTr.firstChild;
+			while ( nCell ) {
+				if ( nCell.nodeName.toUpperCase() =3D=3D "TD" ||
+				     nCell.nodeName.toUpperCase() =3D=3D "TH" )
+				{
+					/* Get the col and rowspan attributes from the DOM and sanitise them =
*/
+					iColspan =3D nCell.getAttribute('colspan') * 1;
+					iRowspan =3D nCell.getAttribute('rowspan') * 1;
+					iColspan =3D (!iColspan || iColspan=3D=3D=3D0 || iColspan=3D=3D=3D1) =
? 1 : iColspan;
+					iRowspan =3D (!iRowspan || iRowspan=3D=3D=3D0 || iRowspan=3D=3D=3D1) =
? 1 : iRowspan;
+=09
+					/* There might be colspan cells already in this row, so shift our tar=
get
+					 * accordingly
+					 */
+					iColShifted =3D fnShiftCol( aLayout, i, iColumn );
+=09
+					/* Cache calculation for unique columns */
+					bUnique =3D iColspan =3D=3D=3D 1 ? true : false;
+=09
+					/* If there is col / rowspan, copy the information into the layout gr=
id */
+					for ( l=3D0 ; l<iColspan ; l++ )
+					{
+						for ( k=3D0 ; k<iRowspan ; k++ )
+						{
+							aLayout[i+k][iColShifted+l] =3D {
+								"cell": nCell,
+								"unique": bUnique
+							};
+							aLayout[i+k].nTr =3D nTr;
+						}
+					}
+				}
+				nCell =3D nCell.nextSibling;
+			}
+		}
+	}
+=09
+=09
+	/**
+	 * Get an array of unique th elements, one for each column
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {node} nHeader automatically detect the layout from this node =
- optional
+	 *  @param {array} aLayout thead/tfoot layout from _fnDetectHeader - opti=
onal
+	 *  @returns array {node} aReturn list of unique th's
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnGetUniqueThs ( oSettings, nHeader, aLayout )
+	{
+		var aReturn =3D [];
+		if ( !aLayout )
+		{
+			aLayout =3D oSettings.aoHeader;
+			if ( nHeader )
+			{
+				aLayout =3D [];
+				_fnDetectHeader( aLayout, nHeader );
+			}
+		}
+=09
+		for ( var i=3D0, iLen=3DaLayout.length ; i<iLen ; i++ )
+		{
+			for ( var j=3D0, jLen=3DaLayout[i].length ; j<jLen ; j++ )
+			{
+				if ( aLayout[i][j].unique &&
+					 (!aReturn[j] || !oSettings.bSortCellsTop) )
+				{
+					aReturn[j] =3D aLayout[i][j].cell;
+				}
+			}
+		}
+=09
+		return aReturn;
+	}
+=09
+	/**
+	 * Set the start position for draw
+	 *  @param {object} oSettings dataTables settings object
+	 */
+	function _fnStart( oSettings )
+	{
+		var bServerSide =3D _fnDataSource( oSettings ) =3D=3D 'ssp';
+		var iInitDisplayStart =3D oSettings.iInitDisplayStart;
+=09
+		// Check and see if we have an initial draw position from state saving
+		if ( iInitDisplayStart !=3D=3D undefined && iInitDisplayStart !=3D=3D -1=
 )
+		{
+			oSettings._iDisplayStart =3D bServerSide ?
+				iInitDisplayStart :
+				iInitDisplayStart >=3D oSettings.fnRecordsDisplay() ?
+					0 :
+					iInitDisplayStart;
+=09
+			oSettings.iInitDisplayStart =3D -1;
+		}
+	}
+=09
+	/**
+	 * Create an Ajax call based on the table's settings, taking into account=
 that
+	 * parameters can have multiple forms, and backwards compatibility.
+	 *
+	 * @param {object} oSettings dataTables settings object
+	 * @param {array} data Data to send to the server, required by
+	 *     DataTables - may be augmented by developer callbacks
+	 * @param {function} fn Callback function to run when data is obtained
+	 */
+	function _fnBuildAjax( oSettings, data, fn )
+	{
+		// Compatibility with 1.9-, allow fnServerData and event to manipulate
+		_fnCallbackFire( oSettings, 'aoServerParams', 'serverParams', [data] );
+=09
+		// Convert to object based for 1.10+ if using the old array scheme which=
 can
+		// come from server-side processing or serverParams
+		if ( data && Array.isArray(data) ) {
+			var tmp =3D {};
+			var rbracket =3D /(.*?)\[\]$/;
+=09
+			$.each( data, function (key, val) {
+				var match =3D val.name.match(rbracket);
+=09
+				if ( match ) {
+					// Support for arrays
+					var name =3D match[0];
+=09
+					if ( ! tmp[ name ] ) {
+						tmp[ name ] =3D [];
+					}
+					tmp[ name ].push( val.value );
+				}
+				else {
+					tmp[val.name] =3D val.value;
+				}
+			} );
+			data =3D tmp;
+		}
+=09
+		var ajaxData;
+		var ajax =3D oSettings.ajax;
+		var instance =3D oSettings.oInstance;
+		var callback =3D function ( json ) {
+			var status =3D oSettings.jqXHR
+				? oSettings.jqXHR.status
+				: null;
+=09
+			if ( json =3D=3D=3D null || (typeof status =3D=3D=3D 'number' && status=
 =3D=3D 204 ) ) {
+				json =3D {};
+				_fnAjaxDataSrc( oSettings, json, [] );
+			}
+=09
+			var error =3D json.error || json.sError;
+			if ( error ) {
+				_fnLog( oSettings, 0, error );
+			}
+=09
+			oSettings.json =3D json;
+=09
+			_fnCallbackFire( oSettings, null, 'xhr', [oSettings, json, oSettings.jq=
XHR] );
+			fn( json );
+		};
+=09
+		if ( $.isPlainObject( ajax ) && ajax.data )
+		{
+			ajaxData =3D ajax.data;
+=09
+			var newData =3D typeof ajaxData =3D=3D=3D 'function' ?
+				ajaxData( data, oSettings ) :  // fn can manipulate data or return
+				ajaxData;                      // an object object or array to merge
+=09
+			// If the function returned something, use that alone
+			data =3D typeof ajaxData =3D=3D=3D 'function' && newData ?
+				newData :
+				$.extend( true, data, newData );
+=09
+			// Remove the data property as we've resolved it already and don't want
+			// jQuery to do it again (it is restored at the end of the function)
+			delete ajax.data;
+		}
+=09
+		var baseAjax =3D {
+			"data": data,
+			"success": callback,
+			"dataType": "json",
+			"cache": false,
+			"type": oSettings.sServerMethod,
+			"error": function (xhr, error, thrown) {
+				var ret =3D _fnCallbackFire( oSettings, null, 'xhr', [oSettings, null,=
 oSettings.jqXHR] );
+=09
+				if ( $.inArray( true, ret ) =3D=3D=3D -1 ) {
+					if ( error =3D=3D "parsererror" ) {
+						_fnLog( oSettings, 0, 'Invalid JSON response', 1 );
+					}
+					else if ( xhr.readyState =3D=3D=3D 4 ) {
+						_fnLog( oSettings, 0, 'Ajax error', 7 );
+					}
+				}
+=09
+				_fnProcessingDisplay( oSettings, false );
+			}
+		};
+=09
+		// Store the data submitted for the API
+		oSettings.oAjaxData =3D data;
+=09
+		// Allow plug-ins and external processes to modify the data
+		_fnCallbackFire( oSettings, null, 'preXhr', [oSettings, data] );
+=09
+		if ( oSettings.fnServerData )
+		{
+			// DataTables 1.9- compatibility
+			oSettings.fnServerData.call( instance,
+				oSettings.sAjaxSource,
+				$.map( data, function (val, key) { // Need to convert back to 1.9 trad=
 format
+					return { name: key, value: val };
+				} ),
+				callback,
+				oSettings
+			);
+		}
+		else if ( oSettings.sAjaxSource || typeof ajax =3D=3D=3D 'string' )
+		{
+			// DataTables 1.9- compatibility
+			oSettings.jqXHR =3D $.ajax( $.extend( baseAjax, {
+				url: ajax || oSettings.sAjaxSource
+			} ) );
+		}
+		else if ( typeof ajax =3D=3D=3D 'function' )
+		{
+			// Is a function - let the caller define what needs to be done
+			oSettings.jqXHR =3D ajax.call( instance, data, callback, oSettings );
+		}
+		else
+		{
+			// Object to extend the base settings
+			oSettings.jqXHR =3D $.ajax( $.extend( baseAjax, ajax ) );
+=09
+			// Restore for next time around
+			ajax.data =3D ajaxData;
+		}
+	}
+=09
+=09
+	/**
+	 * Update the table using an Ajax call
+	 *  @param {object} settings dataTables settings object
+	 *  @returns {boolean} Block the table drawing or not
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnAjaxUpdate( settings )
+	{
+		settings.iDraw++;
+		_fnProcessingDisplay( settings, true );
+=09
+		_fnBuildAjax(
+			settings,
+			_fnAjaxParameters( settings ),
+			function(json) {
+				_fnAjaxUpdateDraw( settings, json );
+			}
+		);
+	}
+=09
+=09
+	/**
+	 * Build up the parameters in an object needed for a server-side processi=
ng
+	 * request. Note that this is basically done twice, is different ways - a=
 modern
+	 * method which is used by default in DataTables 1.10 which uses objects =
and
+	 * arrays, or the 1.9- method with is name / value pairs. 1.9 method is u=
sed if
+	 * the sAjaxSource option is used in the initialisation, or the legacyAjax
+	 * option is set.
+	 *  @param {object} oSettings dataTables settings object
+	 *  @returns {bool} block the table drawing or not
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnAjaxParameters( settings )
+	{
+		var
+			columns =3D settings.aoColumns,
+			columnCount =3D columns.length,
+			features =3D settings.oFeatures,
+			preSearch =3D settings.oPreviousSearch,
+			preColSearch =3D settings.aoPreSearchCols,
+			i, data =3D [], dataProp, column, columnSearch,
+			sort =3D _fnSortFlatten( settings ),
+			displayStart =3D settings._iDisplayStart,
+			displayLength =3D features.bPaginate !=3D=3D false ?
+				settings._iDisplayLength :
+				-1;
+=09
+		var param =3D function ( name, value ) {
+			data.push( { 'name': name, 'value': value } );
+		};
+=09
+		// DataTables 1.9- compatible method
+		param( 'sEcho',          settings.iDraw );
+		param( 'iColumns',       columnCount );
+		param( 'sColumns',       _pluck( columns, 'sName' ).join(',') );
+		param( 'iDisplayStart',  displayStart );
+		param( 'iDisplayLength', displayLength );
+=09
+		// DataTables 1.10+ method
+		var d =3D {
+			draw:    settings.iDraw,
+			columns: [],
+			order:   [],
+			start:   displayStart,
+			length:  displayLength,
+			search:  {
+				value: preSearch.sSearch,
+				regex: preSearch.bRegex
+			}
+		};
+=09
+		for ( i=3D0 ; i<columnCount ; i++ ) {
+			column =3D columns[i];
+			columnSearch =3D preColSearch[i];
+			dataProp =3D typeof column.mData=3D=3D"function" ? 'function' : column.=
mData ;
+=09
+			d.columns.push( {
+				data:       dataProp,
+				name:       column.sName,
+				searchable: column.bSearchable,
+				orderable:  column.bSortable,
+				search:     {
+					value: columnSearch.sSearch,
+					regex: columnSearch.bRegex
+				}
+			} );
+=09
+			param( "mDataProp_"+i, dataProp );
+=09
+			if ( features.bFilter ) {
+				param( 'sSearch_'+i,     columnSearch.sSearch );
+				param( 'bRegex_'+i,      columnSearch.bRegex );
+				param( 'bSearchable_'+i, column.bSearchable );
+			}
+=09
+			if ( features.bSort ) {
+				param( 'bSortable_'+i, column.bSortable );
+			}
+		}
+=09
+		if ( features.bFilter ) {
+			param( 'sSearch', preSearch.sSearch );
+			param( 'bRegex', preSearch.bRegex );
+		}
+=09
+		if ( features.bSort ) {
+			$.each( sort, function ( i, val ) {
+				d.order.push( { column: val.col, dir: val.dir } );
+=09
+				param( 'iSortCol_'+i, val.col );
+				param( 'sSortDir_'+i, val.dir );
+			} );
+=09
+			param( 'iSortingCols', sort.length );
+		}
+=09
+		// If the legacy.ajax parameter is null, then we automatically decide wh=
ich
+		// form to use, based on sAjaxSource
+		var legacy =3D DataTable.ext.legacy.ajax;
+		if ( legacy =3D=3D=3D null ) {
+			return settings.sAjaxSource ? data : d;
+		}
+=09
+		// Otherwise, if legacy has been specified then we use that to decide on=
 the
+		// form
+		return legacy ? data : d;
+	}
+=09
+=09
+	/**
+	 * Data the data from the server (nuking the old) and redraw the table
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {object} json json data return from the server.
+	 *  @param {string} json.sEcho Tracking flag for DataTables to match requ=
ests
+	 *  @param {int} json.iTotalRecords Number of records in the data set, no=
t accounting for filtering
+	 *  @param {int} json.iTotalDisplayRecords Number of records in the data =
set, accounting for filtering
+	 *  @param {array} json.aaData The data to display on this page
+	 *  @param {string} [json.sColumns] Column ordering (sName, comma separat=
ed)
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnAjaxUpdateDraw ( settings, json )
+	{
+		// v1.10 uses camelCase variables, while 1.9 uses Hungarian notation.
+		// Support both
+		var compat =3D function ( old, modern ) {
+			return json[old] !=3D=3D undefined ? json[old] : json[modern];
+		};
+=09
+		var data =3D _fnAjaxDataSrc( settings, json );
+		var draw            =3D compat( 'sEcho',                'draw' );
+		var recordsTotal    =3D compat( 'iTotalRecords',        'recordsTotal' );
+		var recordsFiltered =3D compat( 'iTotalDisplayRecords', 'recordsFiltered=
' );
+=09
+		if ( draw !=3D=3D undefined ) {
+			// Protect against out of sequence returns
+			if ( draw*1 < settings.iDraw ) {
+				return;
+			}
+			settings.iDraw =3D draw * 1;
+		}
+=09
+		// No data in returned object, so rather than an array, we show an empty=
 table
+		if ( ! data ) {
+			data =3D [];
+		}
+=09
+		_fnClearTable( settings );
+		settings._iRecordsTotal   =3D parseInt(recordsTotal, 10);
+		settings._iRecordsDisplay =3D parseInt(recordsFiltered, 10);
+=09
+		for ( var i=3D0, ien=3Ddata.length ; i<ien ; i++ ) {
+			_fnAddData( settings, data[i] );
+		}
+		settings.aiDisplay =3D settings.aiDisplayMaster.slice();
+=09
+		_fnDraw( settings, true );
+=09
+		if ( ! settings._bInitComplete ) {
+			_fnInitComplete( settings, json );
+		}
+=09
+		_fnProcessingDisplay( settings, false );
+	}
+=09
+=09
+	/**
+	 * Get the data from the JSON data source to use for drawing a table. Usi=
ng
+	 * `_fnGetObjectDataFn` allows the data to be sourced from a property of =
the
+	 * source object, or from a processing function.
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param  {object} json Data source object / array from the server
+	 *  @return {array} Array of data to use
+	 */
+	 function _fnAjaxDataSrc ( oSettings, json, write )
+	 {
+		var dataSrc =3D $.isPlainObject( oSettings.ajax ) && oSettings.ajax.data=
Src !=3D=3D undefined ?
+			oSettings.ajax.dataSrc :
+			oSettings.sAjaxDataProp; // Compatibility with 1.9-.
+=09
+		if ( ! write ) {
+			if ( dataSrc =3D=3D=3D 'data' ) {
+				// If the default, then we still want to support the old style, and sa=
fely ignore
+				// it if possible
+				return json.aaData || json[dataSrc];
+			}
+=09
+			return dataSrc !=3D=3D "" ?
+				_fnGetObjectDataFn( dataSrc )( json ) :
+				json;
+		}
+=09
+		// set
+		_fnSetObjectDataFn( dataSrc )( json, write );
+	}
+=09
+	/**
+	 * Generate the node required for filtering text
+	 *  @returns {node} Filter control element
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFeatureHtmlFilter ( settings )
+	{
+		var classes =3D settings.oClasses;
+		var tableId =3D settings.sTableId;
+		var language =3D settings.oLanguage;
+		var previousSearch =3D settings.oPreviousSearch;
+		var features =3D settings.aanFeatures;
+		var input =3D '<input type=3D"search" class=3D"'+classes.sFilterInput+'"=
/>';
+=09
+		var str =3D language.sSearch;
+		str =3D str.match(/_INPUT_/) ?
+			str.replace('_INPUT_', input) :
+			str+input;
+=09
+		var filter =3D $('<div/>', {
+				'id': ! features.f ? tableId+'_filter' : null,
+				'class': classes.sFilter
+			} )
+			.append( $('<label/>' ).append( str ) );
+=09
+		var searchFn =3D function(event) {
+			/* Update all other filter input elements for the new display */
+			var n =3D features.f;
+			var val =3D !this.value ? "" : this.value; // mental IE8 fix :-(
+			if(previousSearch.return && event.key !=3D=3D "Enter") {
+				return;
+			}
+			/* Now do the filter */
+			if ( val !=3D previousSearch.sSearch ) {
+				_fnFilterComplete( settings, {
+					"sSearch": val,
+					"bRegex": previousSearch.bRegex,
+					"bSmart": previousSearch.bSmart ,
+					"bCaseInsensitive": previousSearch.bCaseInsensitive,
+					"return": previousSearch.return
+				} );
+=09
+				// Need to redraw, without resorting
+				settings._iDisplayStart =3D 0;
+				_fnDraw( settings );
+			}
+		};
+=09
+		var searchDelay =3D settings.searchDelay !=3D=3D null ?
+			settings.searchDelay :
+			_fnDataSource( settings ) =3D=3D=3D 'ssp' ?
+				400 :
+				0;
+=09
+		var jqFilter =3D $('input', filter)
+			.val( previousSearch.sSearch )
+			.attr( 'placeholder', language.sSearchPlaceholder )
+			.on(
+				'keyup.DT search.DT input.DT paste.DT cut.DT',
+				searchDelay ?
+					_fnThrottle( searchFn, searchDelay ) :
+					searchFn
+			)
+			.on( 'mouseup', function(e) {
+				// Edge fix! Edge 17 does not trigger anything other than mouse events=
 when clicking
+				// on the clear icon (Edge bug 17584515). This is safe in other browse=
rs as `searchFn`
+				// checks the value to see if it has changed. In other browsers it won=
't have.
+				setTimeout( function () {
+					searchFn.call(jqFilter[0], e);
+				}, 10);
+			} )
+			.on( 'keypress.DT', function(e) {
+				/* Prevent form submission */
+				if ( e.keyCode =3D=3D 13 ) {
+					return false;
+				}
+			} )
+			.attr('aria-controls', tableId);
+=09
+		// Update the input elements whenever the table is filtered
+		$(settings.nTable).on( 'search.dt.DT', function ( ev, s ) {
+			if ( settings =3D=3D=3D s ) {
+				// IE9 throws an 'unknown error' if document.activeElement is used
+				// inside an iframe or frame...
+				try {
+					if ( jqFilter[0] !=3D=3D document.activeElement ) {
+						jqFilter.val( previousSearch.sSearch );
+					}
+				}
+				catch ( e ) {}
+			}
+		} );
+=09
+		return filter[0];
+	}
+=09
+=09
+	/**
+	 * Filter the table using both the global filter and column based filteri=
ng
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {object} oSearch search information
+	 *  @param {int} [iForce] force a research of the master array (1) or not=
 (undefined or 0)
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFilterComplete ( oSettings, oInput, iForce )
+	{
+		var oPrevSearch =3D oSettings.oPreviousSearch;
+		var aoPrevSearch =3D oSettings.aoPreSearchCols;
+		var fnSaveFilter =3D function ( oFilter ) {
+			/* Save the filtering values */
+			oPrevSearch.sSearch =3D oFilter.sSearch;
+			oPrevSearch.bRegex =3D oFilter.bRegex;
+			oPrevSearch.bSmart =3D oFilter.bSmart;
+			oPrevSearch.bCaseInsensitive =3D oFilter.bCaseInsensitive;
+			oPrevSearch.return =3D oFilter.return;
+		};
+		var fnRegex =3D function ( o ) {
+			// Backwards compatibility with the bEscapeRegex option
+			return o.bEscapeRegex !=3D=3D undefined ? !o.bEscapeRegex : o.bRegex;
+		};
+=09
+		// Resolve any column types that are unknown due to addition or invalida=
tion
+		// @todo As per sort - can this be moved into an event handler?
+		_fnColumnTypes( oSettings );
+=09
+		/* In server-side processing all filtering is done by the server, so no =
point hanging around here */
+		if ( _fnDataSource( oSettings ) !=3D 'ssp' )
+		{
+			/* Global filter */
+			_fnFilter( oSettings, oInput.sSearch, iForce, fnRegex(oInput), oInput.b=
Smart, oInput.bCaseInsensitive, oInput.return );
+			fnSaveFilter( oInput );
+=09
+			/* Now do the individual column filter */
+			for ( var i=3D0 ; i<aoPrevSearch.length ; i++ )
+			{
+				_fnFilterColumn( oSettings, aoPrevSearch[i].sSearch, i, fnRegex(aoPrev=
Search[i]),
+					aoPrevSearch[i].bSmart, aoPrevSearch[i].bCaseInsensitive );
+			}
+=09
+			/* Custom filtering */
+			_fnFilterCustom( oSettings );
+		}
+		else
+		{
+			fnSaveFilter( oInput );
+		}
+=09
+		/* Tell the draw function we have been filtering */
+		oSettings.bFiltered =3D true;
+		_fnCallbackFire( oSettings, null, 'search', [oSettings] );
+	}
+=09
+=09
+	/**
+	 * Apply custom filtering functions
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFilterCustom( settings )
+	{
+		var filters =3D DataTable.ext.search;
+		var displayRows =3D settings.aiDisplay;
+		var row, rowIdx;
+=09
+		for ( var i=3D0, ien=3Dfilters.length ; i<ien ; i++ ) {
+			var rows =3D [];
+=09
+			// Loop over each row and see if it should be included
+			for ( var j=3D0, jen=3DdisplayRows.length ; j<jen ; j++ ) {
+				rowIdx =3D displayRows[ j ];
+				row =3D settings.aoData[ rowIdx ];
+=09
+				if ( filters[i]( settings, row._aFilterData, rowIdx, row._aData, j ) )=
 {
+					rows.push( rowIdx );
+				}
+			}
+=09
+			// So the array reference doesn't break set the results into the
+			// existing array
+			displayRows.length =3D 0;
+			$.merge( displayRows, rows );
+		}
+	}
+=09
+=09
+	/**
+	 * Filter the table on a per-column basis
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {string} sInput string to filter on
+	 *  @param {int} iColumn column to filter
+	 *  @param {bool} bRegex treat search string as a regular expression or n=
ot
+	 *  @param {bool} bSmart use smart filtering or not
+	 *  @param {bool} bCaseInsensitive Do case insensitive matching or not
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFilterColumn ( settings, searchStr, colIdx, regex, smart, cas=
eInsensitive )
+	{
+		if ( searchStr =3D=3D=3D '' ) {
+			return;
+		}
+=09
+		var data;
+		var out =3D [];
+		var display =3D settings.aiDisplay;
+		var rpSearch =3D _fnFilterCreateSearch( searchStr, regex, smart, caseIns=
ensitive );
+=09
+		for ( var i=3D0 ; i<display.length ; i++ ) {
+			data =3D settings.aoData[ display[i] ]._aFilterData[ colIdx ];
+=09
+			if ( rpSearch.test( data ) ) {
+				out.push( display[i] );
+			}
+		}
+=09
+		settings.aiDisplay =3D out;
+	}
+=09
+=09
+	/**
+	 * Filter the data table based on user input and draw the table
+	 *  @param {object} settings dataTables settings object
+	 *  @param {string} input string to filter on
+	 *  @param {int} force optional - force a research of the master array (1=
) or not (undefined or 0)
+	 *  @param {bool} regex treat as a regular expression or not
+	 *  @param {bool} smart perform smart filtering or not
+	 *  @param {bool} caseInsensitive Do case insensitive matching or not
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFilter( settings, input, force, regex, smart, caseInsensitive=
 )
+	{
+		var rpSearch =3D _fnFilterCreateSearch( input, regex, smart, caseInsensi=
tive );
+		var prevSearch =3D settings.oPreviousSearch.sSearch;
+		var displayMaster =3D settings.aiDisplayMaster;
+		var display, invalidated, i;
+		var filtered =3D [];
+=09
+		// Need to take account of custom filtering functions - always filter
+		if ( DataTable.ext.search.length !=3D=3D 0 ) {
+			force =3D true;
+		}
+=09
+		// Check if any of the rows were invalidated
+		invalidated =3D _fnFilterData( settings );
+=09
+		// If the input is blank - we just want the full data set
+		if ( input.length <=3D 0 ) {
+			settings.aiDisplay =3D displayMaster.slice();
+		}
+		else {
+			// New search - start from the master array
+			if ( invalidated ||
+				 force ||
+				 regex ||
+				 prevSearch.length > input.length ||
+				 input.indexOf(prevSearch) !=3D=3D 0 ||
+				 settings.bSorted // On resort, the display master needs to be
+				                  // re-filtered since indexes will have changed
+			) {
+				settings.aiDisplay =3D displayMaster.slice();
+			}
+=09
+			// Search the display array
+			display =3D settings.aiDisplay;
+=09
+			for ( i=3D0 ; i<display.length ; i++ ) {
+				if ( rpSearch.test( settings.aoData[ display[i] ]._sFilterRow ) ) {
+					filtered.push( display[i] );
+				}
+			}
+=09
+			settings.aiDisplay =3D filtered;
+		}
+	}
+=09
+=09
+	/**
+	 * Build a regular expression object suitable for searching a table
+	 *  @param {string} sSearch string to search for
+	 *  @param {bool} bRegex treat as a regular expression or not
+	 *  @param {bool} bSmart perform smart filtering or not
+	 *  @param {bool} bCaseInsensitive Do case insensitive matching or not
+	 *  @returns {RegExp} constructed object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFilterCreateSearch( search, regex, smart, caseInsensitive )
+	{
+		search =3D regex ?
+			search :
+			_fnEscapeRegex( search );
+=09=09
+		if ( smart ) {
+			/* For smart filtering we want to allow the search to work regardless of
+			 * word order. We also want double quoted text to be preserved, so word
+			 * order is important - a la google. So this is what we want to
+			 * generate:
+			 *=20
+			 * ^(?=3D.*?\bone\b)(?=3D.*?\btwo three\b)(?=3D.*?\bfour\b).*$
+			 */
+			var a =3D $.map( search.match( /"[^"]+"|[^ ]+/g ) || [''], function ( w=
ord ) {
+				if ( word.charAt(0) =3D=3D=3D '"' ) {
+					var m =3D word.match( /^"(.*)"$/ );
+					word =3D m ? m[1] : word;
+				}
+=09
+				return word.replace('"', '');
+			} );
+=09
+			search =3D '^(?=3D.*?'+a.join( ')(?=3D.*?' )+').*$';
+		}
+=09
+		return new RegExp( search, caseInsensitive ? 'i' : '' );
+	}
+=09
+=09
+	/**
+	 * Escape a string such that it can be used in a regular expression
+	 *  @param {string} sVal string to escape
+	 *  @returns {string} escaped string
+	 *  @memberof DataTable#oApi
+	 */
+	var _fnEscapeRegex =3D DataTable.util.escapeRegex;
+=09
+	var __filter_div =3D $('<div>')[0];
+	var __filter_div_textContent =3D __filter_div.textContent !=3D=3D undefin=
ed;
+=09
+	// Update the filtering data for each row if needed (by invalidation or f=
irst run)
+	function _fnFilterData ( settings )
+	{
+		var columns =3D settings.aoColumns;
+		var column;
+		var i, j, ien, jen, filterData, cellData, row;
+		var wasInvalidated =3D false;
+=09
+		for ( i=3D0, ien=3Dsettings.aoData.length ; i<ien ; i++ ) {
+			row =3D settings.aoData[i];
+=09
+			if ( ! row._aFilterData ) {
+				filterData =3D [];
+=09
+				for ( j=3D0, jen=3Dcolumns.length ; j<jen ; j++ ) {
+					column =3D columns[j];
+=09
+					if ( column.bSearchable ) {
+						cellData =3D _fnGetCellData( settings, i, j, 'filter' );
+=09
+						// Search in DataTables 1.10 is string based. In 1.11 this
+						// should be altered to also allow strict type checking.
+						if ( cellData =3D=3D=3D null ) {
+							cellData =3D '';
+						}
+=09
+						if ( typeof cellData !=3D=3D 'string' && cellData.toString ) {
+							cellData =3D cellData.toString();
+						}
+					}
+					else {
+						cellData =3D '';
+					}
+=09
+					// If it looks like there is an HTML entity in the string,
+					// attempt to decode it so sorting works as expected. Note that
+					// we could use a single line of jQuery to do this, but the DOM
+					// method used here is much faster http://jsperf.com/html-decode
+					if ( cellData.indexOf && cellData.indexOf('&') !=3D=3D -1 ) {
+						__filter_div.innerHTML =3D cellData;
+						cellData =3D __filter_div_textContent ?
+							__filter_div.textContent :
+							__filter_div.innerText;
+					}
+=09
+					if ( cellData.replace ) {
+						cellData =3D cellData.replace(/[\r\n\u2028]/g, '');
+					}
+=09
+					filterData.push( cellData );
+				}
+=09
+				row._aFilterData =3D filterData;
+				row._sFilterRow =3D filterData.join('  ');
+				wasInvalidated =3D true;
+			}
+		}
+=09
+		return wasInvalidated;
+	}
+=09
+=09
+	/**
+	 * Convert from the internal Hungarian notation to camelCase for external
+	 * interaction
+	 *  @param {object} obj Object to convert
+	 *  @returns {object} Inverted object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnSearchToCamel ( obj )
+	{
+		return {
+			search:          obj.sSearch,
+			smart:           obj.bSmart,
+			regex:           obj.bRegex,
+			caseInsensitive: obj.bCaseInsensitive
+		};
+	}
+=09
+=09
+=09
+	/**
+	 * Convert from camelCase notation to the internal Hungarian. We could us=
e the
+	 * Hungarian convert function here, but this is cleaner
+	 *  @param {object} obj Object to convert
+	 *  @returns {object} Inverted object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnSearchToHung ( obj )
+	{
+		return {
+			sSearch:          obj.search,
+			bSmart:           obj.smart,
+			bRegex:           obj.regex,
+			bCaseInsensitive: obj.caseInsensitive
+		};
+	}
+=09
+	/**
+	 * Generate the node required for the info display
+	 *  @param {object} oSettings dataTables settings object
+	 *  @returns {node} Information element
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFeatureHtmlInfo ( settings )
+	{
+		var
+			tid =3D settings.sTableId,
+			nodes =3D settings.aanFeatures.i,
+			n =3D $('<div/>', {
+				'class': settings.oClasses.sInfo,
+				'id': ! nodes ? tid+'_info' : null
+			} );
+=09
+		if ( ! nodes ) {
+			// Update display on each draw
+			settings.aoDrawCallback.push( {
+				"fn": _fnUpdateInfo,
+				"sName": "information"
+			} );
+=09
+			n
+				.attr( 'role', 'status' )
+				.attr( 'aria-live', 'polite' );
+=09
+			// Table is described by our info div
+			$(settings.nTable).attr( 'aria-describedby', tid+'_info' );
+		}
+=09
+		return n[0];
+	}
+=09
+=09
+	/**
+	 * Update the information elements in the display
+	 *  @param {object} settings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnUpdateInfo ( settings )
+	{
+		/* Show information about the table */
+		var nodes =3D settings.aanFeatures.i;
+		if ( nodes.length =3D=3D=3D 0 ) {
+			return;
+		}
+=09
+		var
+			lang  =3D settings.oLanguage,
+			start =3D settings._iDisplayStart+1,
+			end   =3D settings.fnDisplayEnd(),
+			max   =3D settings.fnRecordsTotal(),
+			total =3D settings.fnRecordsDisplay(),
+			out   =3D total ?
+				lang.sInfo :
+				lang.sInfoEmpty;
+=09
+		if ( total !=3D=3D max ) {
+			/* Record set after filtering */
+			out +=3D ' ' + lang.sInfoFiltered;
+		}
+=09
+		// Convert the macros
+		out +=3D lang.sInfoPostFix;
+		out =3D _fnInfoMacros( settings, out );
+=09
+		var callback =3D lang.fnInfoCallback;
+		if ( callback !=3D=3D null ) {
+			out =3D callback.call( settings.oInstance,
+				settings, start, end, max, total, out
+			);
+		}
+=09
+		$(nodes).html( out );
+	}
+=09
+=09
+	function _fnInfoMacros ( settings, str )
+	{
+		// When infinite scrolling, we are always starting at 1. _iDisplayStart =
is used only
+		// internally
+		var
+			formatter  =3D settings.fnFormatNumber,
+			start      =3D settings._iDisplayStart+1,
+			len        =3D settings._iDisplayLength,
+			vis        =3D settings.fnRecordsDisplay(),
+			all        =3D len =3D=3D=3D -1;
+=09
+		return str.
+			replace(/_START_/g, formatter.call( settings, start ) ).
+			replace(/_END_/g,   formatter.call( settings, settings.fnDisplayEnd() )=
 ).
+			replace(/_MAX_/g,   formatter.call( settings, settings.fnRecordsTotal()=
 ) ).
+			replace(/_TOTAL_/g, formatter.call( settings, vis ) ).
+			replace(/_PAGE_/g,  formatter.call( settings, all ? 1 : Math.ceil( star=
t / len ) ) ).
+			replace(/_PAGES_/g, formatter.call( settings, all ? 1 : Math.ceil( vis =
/ len ) ) );
+	}
+=09
+=09
+=09
+	/**
+	 * Draw the table for the first time, adding all required features
+	 *  @param {object} settings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnInitialise ( settings )
+	{
+		var i, iLen, iAjaxStart=3Dsettings.iInitDisplayStart;
+		var columns =3D settings.aoColumns, column;
+		var features =3D settings.oFeatures;
+		var deferLoading =3D settings.bDeferLoading; // value modified by the dr=
aw
+=09
+		/* Ensure that the table data is fully initialised */
+		if ( ! settings.bInitialised ) {
+			setTimeout( function(){ _fnInitialise( settings ); }, 200 );
+			return;
+		}
+=09
+		/* Show the display HTML options */
+		_fnAddOptionsHtml( settings );
+=09
+		/* Build and draw the header / footer for the table */
+		_fnBuildHead( settings );
+		_fnDrawHead( settings, settings.aoHeader );
+		_fnDrawHead( settings, settings.aoFooter );
+=09
+		/* Okay to show that something is going on now */
+		_fnProcessingDisplay( settings, true );
+=09
+		/* Calculate sizes for columns */
+		if ( features.bAutoWidth ) {
+			_fnCalculateColumnWidths( settings );
+		}
+=09
+		for ( i=3D0, iLen=3Dcolumns.length ; i<iLen ; i++ ) {
+			column =3D columns[i];
+=09
+			if ( column.sWidth ) {
+				column.nTh.style.width =3D _fnStringToCss( column.sWidth );
+			}
+		}
+=09
+		_fnCallbackFire( settings, null, 'preInit', [settings] );
+=09
+		// If there is default sorting required - let's do it. The sort function
+		// will do the drawing for us. Otherwise we draw the table regardless of=
 the
+		// Ajax source - this allows the table to look initialised for Ajax sour=
cing
+		// data (show 'loading' message possibly)
+		_fnReDraw( settings );
+=09
+		// Server-side processing init complete is done by _fnAjaxUpdateDraw
+		var dataSrc =3D _fnDataSource( settings );
+		if ( dataSrc !=3D 'ssp' || deferLoading ) {
+			// if there is an ajax source load the data
+			if ( dataSrc =3D=3D 'ajax' ) {
+				_fnBuildAjax( settings, [], function(json) {
+					var aData =3D _fnAjaxDataSrc( settings, json );
+=09
+					// Got the data - add it to the table
+					for ( i=3D0 ; i<aData.length ; i++ ) {
+						_fnAddData( settings, aData[i] );
+					}
+=09
+					// Reset the init display for cookie saving. We've already done
+					// a filter, and therefore cleared it before. So we need to make
+					// it appear 'fresh'
+					settings.iInitDisplayStart =3D iAjaxStart;
+=09
+					_fnReDraw( settings );
+=09
+					_fnProcessingDisplay( settings, false );
+					_fnInitComplete( settings, json );
+				}, settings );
+			}
+			else {
+				_fnProcessingDisplay( settings, false );
+				_fnInitComplete( settings );
+			}
+		}
+	}
+=09
+=09
+	/**
+	 * Draw the table for the first time, adding all required features
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {object} [json] JSON from the server that completed the table,=
 if using Ajax source
+	 *    with client-side processing (optional)
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnInitComplete ( settings, json )
+	{
+		settings._bInitComplete =3D true;
+=09
+		// When data was added after the initialisation (data or Ajax) we need to
+		// calculate the column sizing
+		if ( json || settings.oInit.aaData ) {
+			_fnAdjustColumnSizing( settings );
+		}
+=09
+		_fnCallbackFire( settings, null, 'plugin-init', [settings, json] );
+		_fnCallbackFire( settings, 'aoInitComplete', 'init', [settings, json] );
+	}
+=09
+=09
+	function _fnLengthChange ( settings, val )
+	{
+		var len =3D parseInt( val, 10 );
+		settings._iDisplayLength =3D len;
+=09
+		_fnLengthOverflow( settings );
+=09
+		// Fire length change event
+		_fnCallbackFire( settings, null, 'length', [settings, len] );
+	}
+=09
+=09
+	/**
+	 * Generate the node required for user display length changing
+	 *  @param {object} settings dataTables settings object
+	 *  @returns {node} Display length feature node
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFeatureHtmlLength ( settings )
+	{
+		var
+			classes  =3D settings.oClasses,
+			tableId  =3D settings.sTableId,
+			menu     =3D settings.aLengthMenu,
+			d2       =3D Array.isArray( menu[0] ),
+			lengths  =3D d2 ? menu[0] : menu,
+			language =3D d2 ? menu[1] : menu;
+=09
+		var select =3D $('<select/>', {
+			'name':          tableId+'_length',
+			'aria-controls': tableId,
+			'class':         classes.sLengthSelect
+		} );
+=09
+		for ( var i=3D0, ien=3Dlengths.length ; i<ien ; i++ ) {
+			select[0][ i ] =3D new Option(
+				typeof language[i] =3D=3D=3D 'number' ?
+					settings.fnFormatNumber( language[i] ) :
+					language[i],
+				lengths[i]
+			);
+		}
+=09
+		var div =3D $('<div><label/></div>').addClass( classes.sLength );
+		if ( ! settings.aanFeatures.l ) {
+			div[0].id =3D tableId+'_length';
+		}
+=09
+		div.children().append(
+			settings.oLanguage.sLengthMenu.replace( '_MENU_', select[0].outerHTML )
+		);
+=09
+		// Can't use `select` variable as user might provide their own and the
+		// reference is broken by the use of outerHTML
+		$('select', div)
+			.val( settings._iDisplayLength )
+			.on( 'change.DT', function(e) {
+				_fnLengthChange( settings, $(this).val() );
+				_fnDraw( settings );
+			} );
+=09
+		// Update node value whenever anything changes the table's length
+		$(settings.nTable).on( 'length.dt.DT', function (e, s, len) {
+			if ( settings =3D=3D=3D s ) {
+				$('select', div).val( len );
+			}
+		} );
+=09
+		return div[0];
+	}
+=09
+=09
+=09
+	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * =
* * * * * * * * * *
+	 * Note that most of the paging logic is done in
+	 * DataTable.ext.pager
+	 */
+=09
+	/**
+	 * Generate the node required for default pagination
+	 *  @param {object} oSettings dataTables settings object
+	 *  @returns {node} Pagination feature node
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFeatureHtmlPaginate ( settings )
+	{
+		var
+			type   =3D settings.sPaginationType,
+			plugin =3D DataTable.ext.pager[ type ],
+			modern =3D typeof plugin =3D=3D=3D 'function',
+			redraw =3D function( settings ) {
+				_fnDraw( settings );
+			},
+			node =3D $('<div/>').addClass( settings.oClasses.sPaging + type )[0],
+			features =3D settings.aanFeatures;
+=09
+		if ( ! modern ) {
+			plugin.fnInit( settings, node, redraw );
+		}
+=09
+		/* Add a draw callback for the pagination on first instance, to update t=
he paging display */
+		if ( ! features.p )
+		{
+			node.id =3D settings.sTableId+'_paginate';
+=09
+			settings.aoDrawCallback.push( {
+				"fn": function( settings ) {
+					if ( modern ) {
+						var
+							start      =3D settings._iDisplayStart,
+							len        =3D settings._iDisplayLength,
+							visRecords =3D settings.fnRecordsDisplay(),
+							all        =3D len =3D=3D=3D -1,
+							page =3D all ? 0 : Math.ceil( start / len ),
+							pages =3D all ? 1 : Math.ceil( visRecords / len ),
+							buttons =3D plugin(page, pages),
+							i, ien;
+=09
+						for ( i=3D0, ien=3Dfeatures.p.length ; i<ien ; i++ ) {
+							_fnRenderer( settings, 'pageButton' )(
+								settings, features.p[i], i, buttons, page, pages
+							);
+						}
+					}
+					else {
+						plugin.fnUpdate( settings, redraw );
+					}
+				},
+				"sName": "pagination"
+			} );
+		}
+=09
+		return node;
+	}
+=09
+=09
+	/**
+	 * Alter the display settings to change the page
+	 *  @param {object} settings DataTables settings object
+	 *  @param {string|int} action Paging action to take: "first", "previous",
+	 *    "next" or "last" or page number to jump to (integer)
+	 *  @param [bool] redraw Automatically draw the update or not
+	 *  @returns {bool} true page has changed, false - no change
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnPageChange ( settings, action, redraw )
+	{
+		var
+			start     =3D settings._iDisplayStart,
+			len       =3D settings._iDisplayLength,
+			records   =3D settings.fnRecordsDisplay();
+=09
+		if ( records =3D=3D=3D 0 || len =3D=3D=3D -1 )
+		{
+			start =3D 0;
+		}
+		else if ( typeof action =3D=3D=3D "number" )
+		{
+			start =3D action * len;
+=09
+			if ( start > records )
+			{
+				start =3D 0;
+			}
+		}
+		else if ( action =3D=3D "first" )
+		{
+			start =3D 0;
+		}
+		else if ( action =3D=3D "previous" )
+		{
+			start =3D len >=3D 0 ?
+				start - len :
+				0;
+=09
+			if ( start < 0 )
+			{
+			  start =3D 0;
+			}
+		}
+		else if ( action =3D=3D "next" )
+		{
+			if ( start + len < records )
+			{
+				start +=3D len;
+			}
+		}
+		else if ( action =3D=3D "last" )
+		{
+			start =3D Math.floor( (records-1) / len) * len;
+		}
+		else
+		{
+			_fnLog( settings, 0, "Unknown paging action: "+action, 5 );
+		}
+=09
+		var changed =3D settings._iDisplayStart !=3D=3D start;
+		settings._iDisplayStart =3D start;
+=09
+		if ( changed ) {
+			_fnCallbackFire( settings, null, 'page', [settings] );
+=09
+			if ( redraw ) {
+				_fnDraw( settings );
+			}
+		}
+=09
+		return changed;
+	}
+=09
+=09
+=09
+	/**
+	 * Generate the node required for the processing node
+	 *  @param {object} settings dataTables settings object
+	 *  @returns {node} Processing element
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFeatureHtmlProcessing ( settings )
+	{
+		return $('<div/>', {
+				'id': ! settings.aanFeatures.r ? settings.sTableId+'_processing' : nul=
l,
+				'class': settings.oClasses.sProcessing
+			} )
+			.html( settings.oLanguage.sProcessing )
+			.insertBefore( settings.nTable )[0];
+	}
+=09
+=09
+	/**
+	 * Display or hide the processing indicator
+	 *  @param {object} settings dataTables settings object
+	 *  @param {bool} show Show the processing indicator (true) or not (false)
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnProcessingDisplay ( settings, show )
+	{
+		if ( settings.oFeatures.bProcessing ) {
+			$(settings.aanFeatures.r).css( 'display', show ? 'block' : 'none' );
+		}
+=09
+		_fnCallbackFire( settings, null, 'processing', [settings, show] );
+	}
+=09
+	/**
+	 * Add any control elements for the table - specifically scrolling
+	 *  @param {object} settings dataTables settings object
+	 *  @returns {node} Node to add to the DOM
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnFeatureHtmlTable ( settings )
+	{
+		var table =3D $(settings.nTable);
+=09
+		// Scrolling from here on in
+		var scroll =3D settings.oScroll;
+=09
+		if ( scroll.sX =3D=3D=3D '' && scroll.sY =3D=3D=3D '' ) {
+			return settings.nTable;
+		}
+=09
+		var scrollX =3D scroll.sX;
+		var scrollY =3D scroll.sY;
+		var classes =3D settings.oClasses;
+		var caption =3D table.children('caption');
+		var captionSide =3D caption.length ? caption[0]._captionSide : null;
+		var headerClone =3D $( table[0].cloneNode(false) );
+		var footerClone =3D $( table[0].cloneNode(false) );
+		var footer =3D table.children('tfoot');
+		var _div =3D '<div/>';
+		var size =3D function ( s ) {
+			return !s ? null : _fnStringToCss( s );
+		};
+=09
+		if ( ! footer.length ) {
+			footer =3D null;
+		}
+=09
+		/*
+		 * The HTML structure that we want to generate in this function is:
+		 *  div - scroller
+		 *    div - scroll head
+		 *      div - scroll head inner
+		 *        table - scroll head table
+		 *          thead - thead
+		 *    div - scroll body
+		 *      table - table (master table)
+		 *        thead - thead clone for sizing
+		 *        tbody - tbody
+		 *    div - scroll foot
+		 *      div - scroll foot inner
+		 *        table - scroll foot table
+		 *          tfoot - tfoot
+		 */
+		var scroller =3D $( _div, { 'class': classes.sScrollWrapper } )
+			.append(
+				$(_div, { 'class': classes.sScrollHead } )
+					.css( {
+						overflow: 'hidden',
+						position: 'relative',
+						border: 0,
+						width: scrollX ? size(scrollX) : '100%'
+					} )
+					.append(
+						$(_div, { 'class': classes.sScrollHeadInner } )
+							.css( {
+								'box-sizing': 'content-box',
+								width: scroll.sXInner || '100%'
+							} )
+							.append(
+								headerClone
+									.removeAttr('id')
+									.css( 'margin-left', 0 )
+									.append( captionSide =3D=3D=3D 'top' ? caption : null )
+									.append(
+										table.children('thead')
+									)
+							)
+					)
+			)
+			.append(
+				$(_div, { 'class': classes.sScrollBody } )
+					.css( {
+						position: 'relative',
+						overflow: 'auto',
+						width: size( scrollX )
+					} )
+					.append( table )
+			);
+=09
+		if ( footer ) {
+			scroller.append(
+				$(_div, { 'class': classes.sScrollFoot } )
+					.css( {
+						overflow: 'hidden',
+						border: 0,
+						width: scrollX ? size(scrollX) : '100%'
+					} )
+					.append(
+						$(_div, { 'class': classes.sScrollFootInner } )
+							.append(
+								footerClone
+									.removeAttr('id')
+									.css( 'margin-left', 0 )
+									.append( captionSide =3D=3D=3D 'bottom' ? caption : null )
+									.append(
+										table.children('tfoot')
+									)
+							)
+					)
+			);
+		}
+=09
+		var children =3D scroller.children();
+		var scrollHead =3D children[0];
+		var scrollBody =3D children[1];
+		var scrollFoot =3D footer ? children[2] : null;
+=09
+		// When the body is scrolled, then we also want to scroll the headers
+		if ( scrollX ) {
+			$(scrollBody).on( 'scroll.DT', function (e) {
+				var scrollLeft =3D this.scrollLeft;
+=09
+				scrollHead.scrollLeft =3D scrollLeft;
+=09
+				if ( footer ) {
+					scrollFoot.scrollLeft =3D scrollLeft;
+				}
+			} );
+		}
+=09
+		$(scrollBody).css('max-height', scrollY);
+		if (! scroll.bCollapse) {
+			$(scrollBody).css('height', scrollY);
+		}
+=09
+		settings.nScrollHead =3D scrollHead;
+		settings.nScrollBody =3D scrollBody;
+		settings.nScrollFoot =3D scrollFoot;
+=09
+		// On redraw - align columns
+		settings.aoDrawCallback.push( {
+			"fn": _fnScrollDraw,
+			"sName": "scrolling"
+		} );
+=09
+		return scroller[0];
+	}
+=09
+=09
+=09
+	/**
+	 * Update the header, footer and body tables for resizing - i.e. column
+	 * alignment.
+	 *
+	 * Welcome to the most horrible function DataTables. The process that this
+	 * function follows is basically:
+	 *   1. Re-create the table inside the scrolling div
+	 *   2. Take live measurements from the DOM
+	 *   3. Apply the measurements to align the columns
+	 *   4. Clean up
+	 *
+	 *  @param {object} settings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnScrollDraw ( settings )
+	{
+		// Given that this is such a monster function, a lot of variables are use
+		// to try and keep the minimised size as small as possible
+		var
+			scroll         =3D settings.oScroll,
+			scrollX        =3D scroll.sX,
+			scrollXInner   =3D scroll.sXInner,
+			scrollY        =3D scroll.sY,
+			barWidth       =3D scroll.iBarWidth,
+			divHeader      =3D $(settings.nScrollHead),
+			divHeaderStyle =3D divHeader[0].style,
+			divHeaderInner =3D divHeader.children('div'),
+			divHeaderInnerStyle =3D divHeaderInner[0].style,
+			divHeaderTable =3D divHeaderInner.children('table'),
+			divBodyEl      =3D settings.nScrollBody,
+			divBody        =3D $(divBodyEl),
+			divBodyStyle   =3D divBodyEl.style,
+			divFooter      =3D $(settings.nScrollFoot),
+			divFooterInner =3D divFooter.children('div'),
+			divFooterTable =3D divFooterInner.children('table'),
+			header         =3D $(settings.nTHead),
+			table          =3D $(settings.nTable),
+			tableEl        =3D table[0],
+			tableStyle     =3D tableEl.style,
+			footer         =3D settings.nTFoot ? $(settings.nTFoot) : null,
+			browser        =3D settings.oBrowser,
+			ie67           =3D browser.bScrollOversize,
+			dtHeaderCells  =3D _pluck( settings.aoColumns, 'nTh' ),
+			headerTrgEls, footerTrgEls,
+			headerSrcEls, footerSrcEls,
+			headerCopy, footerCopy,
+			headerWidths=3D[], footerWidths=3D[],
+			headerContent=3D[], footerContent=3D[],
+			idx, correction, sanityWidth,
+			zeroOut =3D function(nSizer) {
+				var style =3D nSizer.style;
+				style.paddingTop =3D "0";
+				style.paddingBottom =3D "0";
+				style.borderTopWidth =3D "0";
+				style.borderBottomWidth =3D "0";
+				style.height =3D 0;
+			};
+=09
+		// If the scrollbar visibility has changed from the last draw, we need to
+		// adjust the column sizes as the table width will have changed to accou=
nt
+		// for the scrollbar
+		var scrollBarVis =3D divBodyEl.scrollHeight > divBodyEl.clientHeight;
+=09=09
+		if ( settings.scrollBarVis !=3D=3D scrollBarVis && settings.scrollBarVis=
 !=3D=3D undefined ) {
+			settings.scrollBarVis =3D scrollBarVis;
+			_fnAdjustColumnSizing( settings );
+			return; // adjust column sizing will call this function again
+		}
+		else {
+			settings.scrollBarVis =3D scrollBarVis;
+		}
+=09
+		/*
+		 * 1. Re-create the table inside the scrolling div
+		 */
+=09
+		// Remove the old minimised thead and tfoot elements in the inner table
+		table.children('thead, tfoot').remove();
+=09
+		if ( footer ) {
+			footerCopy =3D footer.clone().prependTo( table );
+			footerTrgEls =3D footer.find('tr'); // the original tfoot is in its own=
 table and must be sized
+			footerSrcEls =3D footerCopy.find('tr');
+		}
+=09
+		// Clone the current header and footer elements and then place it into t=
he inner table
+		headerCopy =3D header.clone().prependTo( table );
+		headerTrgEls =3D header.find('tr'); // original header is in its own tab=
le
+		headerSrcEls =3D headerCopy.find('tr');
+		headerCopy.find('th, td').removeAttr('tabindex');
+=09
+=09
+		/*
+		 * 2. Take live measurements from the DOM - do not alter the DOM itself!
+		 */
+=09
+		// Remove old sizing and apply the calculated column widths
+		// Get the unique column headers in the newly created (cloned) header. W=
e want to apply the
+		// calculated sizes to this header
+		if ( ! scrollX )
+		{
+			divBodyStyle.width =3D '100%';
+			divHeader[0].style.width =3D '100%';
+		}
+=09
+		$.each( _fnGetUniqueThs( settings, headerCopy ), function ( i, el ) {
+			idx =3D _fnVisibleToColumnIndex( settings, i );
+			el.style.width =3D settings.aoColumns[idx].sWidth;
+		} );
+=09
+		if ( footer ) {
+			_fnApplyToChildren( function(n) {
+				n.style.width =3D "";
+			}, footerSrcEls );
+		}
+=09
+		// Size the table as a whole
+		sanityWidth =3D table.outerWidth();
+		if ( scrollX =3D=3D=3D "" ) {
+			// No x scrolling
+			tableStyle.width =3D "100%";
+=09
+			// IE7 will make the width of the table when 100% include the scrollbar
+			// - which is shouldn't. When there is a scrollbar we need to take this
+			// into account.
+			if ( ie67 && (table.find('tbody').height() > divBodyEl.offsetHeight ||
+				divBody.css('overflow-y') =3D=3D "scroll")
+			) {
+				tableStyle.width =3D _fnStringToCss( table.outerWidth() - barWidth);
+			}
+=09
+			// Recalculate the sanity width
+			sanityWidth =3D table.outerWidth();
+		}
+		else if ( scrollXInner !=3D=3D "" ) {
+			// legacy x scroll inner has been given - use it
+			tableStyle.width =3D _fnStringToCss(scrollXInner);
+=09
+			// Recalculate the sanity width
+			sanityWidth =3D table.outerWidth();
+		}
+=09
+		// Hidden header should have zero height, so remove padding and borders.=
 Then
+		// set the width based on the real headers
+=09
+		// Apply all styles in one pass
+		_fnApplyToChildren( zeroOut, headerSrcEls );
+=09
+		// Read all widths in next pass
+		_fnApplyToChildren( function(nSizer) {
+			var style =3D window.getComputedStyle ?
+				window.getComputedStyle(nSizer).width :
+				_fnStringToCss( $(nSizer).width() );
+=09
+			headerContent.push( nSizer.innerHTML );
+			headerWidths.push( style );
+		}, headerSrcEls );
+=09
+		// Apply all widths in final pass
+		_fnApplyToChildren( function(nToSize, i) {
+			nToSize.style.width =3D headerWidths[i];
+		}, headerTrgEls );
+=09
+		$(headerSrcEls).css('height', 0);
+=09
+		/* Same again with the footer if we have one */
+		if ( footer )
+		{
+			_fnApplyToChildren( zeroOut, footerSrcEls );
+=09
+			_fnApplyToChildren( function(nSizer) {
+				footerContent.push( nSizer.innerHTML );
+				footerWidths.push( _fnStringToCss( $(nSizer).css('width') ) );
+			}, footerSrcEls );
+=09
+			_fnApplyToChildren( function(nToSize, i) {
+				nToSize.style.width =3D footerWidths[i];
+			}, footerTrgEls );
+=09
+			$(footerSrcEls).height(0);
+		}
+=09
+=09
+		/*
+		 * 3. Apply the measurements
+		 */
+=09
+		// "Hide" the header and footer that we used for the sizing. We need to =
keep
+		// the content of the cell so that the width applied to the header and b=
ody
+		// both match, but we want to hide it completely. We want to also fix th=
eir
+		// width to what they currently are
+		_fnApplyToChildren( function(nSizer, i) {
+			nSizer.innerHTML =3D '<div class=3D"dataTables_sizing">'+headerContent[=
i]+'</div>';
+			nSizer.childNodes[0].style.height =3D "0";
+			nSizer.childNodes[0].style.overflow =3D "hidden";
+			nSizer.style.width =3D headerWidths[i];
+		}, headerSrcEls );
+=09
+		if ( footer )
+		{
+			_fnApplyToChildren( function(nSizer, i) {
+				nSizer.innerHTML =3D '<div class=3D"dataTables_sizing">'+footerContent=
[i]+'</div>';
+				nSizer.childNodes[0].style.height =3D "0";
+				nSizer.childNodes[0].style.overflow =3D "hidden";
+				nSizer.style.width =3D footerWidths[i];
+			}, footerSrcEls );
+		}
+=09
+		// Sanity check that the table is of a sensible width. If not then we ar=
e going to get
+		// misalignment - try to prevent this by not allowing the table to shrin=
k below its min width
+		if ( Math.round(table.outerWidth()) < Math.round(sanityWidth) )
+		{
+			// The min width depends upon if we have a vertical scrollbar visible o=
r not */
+			correction =3D ((divBodyEl.scrollHeight > divBodyEl.offsetHeight ||
+				divBody.css('overflow-y') =3D=3D "scroll")) ?
+					sanityWidth+barWidth :
+					sanityWidth;
+=09
+			// IE6/7 are a law unto themselves...
+			if ( ie67 && (divBodyEl.scrollHeight >
+				divBodyEl.offsetHeight || divBody.css('overflow-y') =3D=3D "scroll")
+			) {
+				tableStyle.width =3D _fnStringToCss( correction-barWidth );
+			}
+=09
+			// And give the user a warning that we've stopped the table getting too=
 small
+			if ( scrollX =3D=3D=3D "" || scrollXInner !=3D=3D "" ) {
+				_fnLog( settings, 1, 'Possible column misalignment', 6 );
+			}
+		}
+		else
+		{
+			correction =3D '100%';
+		}
+=09
+		// Apply to the container elements
+		divBodyStyle.width =3D _fnStringToCss( correction );
+		divHeaderStyle.width =3D _fnStringToCss( correction );
+=09
+		if ( footer ) {
+			settings.nScrollFoot.style.width =3D _fnStringToCss( correction );
+		}
+=09
+=09
+		/*
+		 * 4. Clean up
+		 */
+		if ( ! scrollY ) {
+			/* IE7< puts a vertical scrollbar in place (when it shouldn't be) due t=
o subtracting
+			 * the scrollbar height from the visible display, rather than adding it=
 on. We need to
+			 * set the height in order to sort this. Don't want to do it in any oth=
er browsers.
+			 */
+			if ( ie67 ) {
+				divBodyStyle.height =3D _fnStringToCss( tableEl.offsetHeight+barWidth =
);
+			}
+		}
+=09
+		/* Finally set the width's of the header and footer tables */
+		var iOuterWidth =3D table.outerWidth();
+		divHeaderTable[0].style.width =3D _fnStringToCss( iOuterWidth );
+		divHeaderInnerStyle.width =3D _fnStringToCss( iOuterWidth );
+=09
+		// Figure out if there are scrollbar present - if so then we need a the =
header and footer to
+		// provide a bit more space to allow "overflow" scrolling (i.e. past the=
 scrollbar)
+		var bScrolling =3D table.height() > divBodyEl.clientHeight || divBody.cs=
s('overflow-y') =3D=3D "scroll";
+		var padding =3D 'padding' + (browser.bScrollbarLeft ? 'Left' : 'Right' );
+		divHeaderInnerStyle[ padding ] =3D bScrolling ? barWidth+"px" : "0px";
+=09
+		if ( footer ) {
+			divFooterTable[0].style.width =3D _fnStringToCss( iOuterWidth );
+			divFooterInner[0].style.width =3D _fnStringToCss( iOuterWidth );
+			divFooterInner[0].style[padding] =3D bScrolling ? barWidth+"px" : "0px";
+		}
+=09
+		// Correct DOM ordering for colgroup - comes before the thead
+		table.children('colgroup').insertBefore( table.children('thead') );
+=09
+		/* Adjust the position of the header in case we loose the y-scrollbar */
+		divBody.trigger('scroll');
+=09
+		// If sorting or filtering has occurred, jump the scrolling back to the =
top
+		// only if we aren't holding the position
+		if ( (settings.bSorted || settings.bFiltered) && ! settings._drawHold ) {
+			divBodyEl.scrollTop =3D 0;
+		}
+	}
+=09
+=09
+=09
+	/**
+	 * Apply a given function to the display child nodes of an element array =
(typically
+	 * TD children of TR rows
+	 *  @param {function} fn Method to apply to the objects
+	 *  @param array {nodes} an1 List of elements to look through for display=
 children
+	 *  @param array {nodes} an2 Another list (identical structure to the fir=
st) - optional
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnApplyToChildren( fn, an1, an2 )
+	{
+		var index=3D0, i=3D0, iLen=3Dan1.length;
+		var nNode1, nNode2;
+=09
+		while ( i < iLen ) {
+			nNode1 =3D an1[i].firstChild;
+			nNode2 =3D an2 ? an2[i].firstChild : null;
+=09
+			while ( nNode1 ) {
+				if ( nNode1.nodeType =3D=3D=3D 1 ) {
+					if ( an2 ) {
+						fn( nNode1, nNode2, index );
+					}
+					else {
+						fn( nNode1, index );
+					}
+=09
+					index++;
+				}
+=09
+				nNode1 =3D nNode1.nextSibling;
+				nNode2 =3D an2 ? nNode2.nextSibling : null;
+			}
+=09
+			i++;
+		}
+	}
+=09
+=09
+=09
+	var __re_html_remove =3D /<.*?>/g;
+=09
+=09
+	/**
+	 * Calculate the width of columns for the table
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnCalculateColumnWidths ( oSettings )
+	{
+		var
+			table =3D oSettings.nTable,
+			columns =3D oSettings.aoColumns,
+			scroll =3D oSettings.oScroll,
+			scrollY =3D scroll.sY,
+			scrollX =3D scroll.sX,
+			scrollXInner =3D scroll.sXInner,
+			columnCount =3D columns.length,
+			visibleColumns =3D _fnGetColumns( oSettings, 'bVisible' ),
+			headerCells =3D $('th', oSettings.nTHead),
+			tableWidthAttr =3D table.getAttribute('width'), // from DOM element
+			tableContainer =3D table.parentNode,
+			userInputs =3D false,
+			i, column, columnIdx, width, outerWidth,
+			browser =3D oSettings.oBrowser,
+			ie67 =3D browser.bScrollOversize;
+=09
+		var styleWidth =3D table.style.width;
+		if ( styleWidth && styleWidth.indexOf('%') !=3D=3D -1 ) {
+			tableWidthAttr =3D styleWidth;
+		}
+=09
+		/* Convert any user input sizes into pixel sizes */
+		for ( i=3D0 ; i<visibleColumns.length ; i++ ) {
+			column =3D columns[ visibleColumns[i] ];
+=09
+			if ( column.sWidth !=3D=3D null ) {
+				column.sWidth =3D _fnConvertToWidth( column.sWidthOrig, tableContainer=
 );
+=09
+				userInputs =3D true;
+			}
+		}
+=09
+		/* If the number of columns in the DOM equals the number that we have to
+		 * process in DataTables, then we can use the offsets that are created by
+		 * the web- browser. No custom sizes can be set in order for this to hap=
pen,
+		 * nor scrolling used
+		 */
+		if ( ie67 || ! userInputs && ! scrollX && ! scrollY &&
+		     columnCount =3D=3D _fnVisbleColumns( oSettings ) &&
+		     columnCount =3D=3D headerCells.length
+		) {
+			for ( i=3D0 ; i<columnCount ; i++ ) {
+				var colIdx =3D _fnVisibleToColumnIndex( oSettings, i );
+=09
+				if ( colIdx !=3D=3D null ) {
+					columns[ colIdx ].sWidth =3D _fnStringToCss( headerCells.eq(i).width(=
) );
+				}
+			}
+		}
+		else
+		{
+			// Otherwise construct a single row, worst case, table with the widest
+			// node in the data, assign any user defined widths, then insert it into
+			// the DOM and allow the browser to do all the hard work of calculating
+			// table widths
+			var tmpTable =3D $(table).clone() // don't use cloneNode - IE8 will rem=
ove events on the main table
+				.css( 'visibility', 'hidden' )
+				.removeAttr( 'id' );
+=09
+			// Clean up the table body
+			tmpTable.find('tbody tr').remove();
+			var tr =3D $('<tr/>').appendTo( tmpTable.find('tbody') );
+=09
+			// Clone the table header and footer - we can't use the header / footer
+			// from the cloned table, since if scrolling is active, the table's
+			// real header and footer are contained in different table tags
+			tmpTable.find('thead, tfoot').remove();
+			tmpTable
+				.append( $(oSettings.nTHead).clone() )
+				.append( $(oSettings.nTFoot).clone() );
+=09
+			// Remove any assigned widths from the footer (from scrolling)
+			tmpTable.find('tfoot th, tfoot td').css('width', '');
+=09
+			// Apply custom sizing to the cloned header
+			headerCells =3D _fnGetUniqueThs( oSettings, tmpTable.find('thead')[0] );
+=09
+			for ( i=3D0 ; i<visibleColumns.length ; i++ ) {
+				column =3D columns[ visibleColumns[i] ];
+=09
+				headerCells[i].style.width =3D column.sWidthOrig !=3D=3D null && colum=
n.sWidthOrig !=3D=3D '' ?
+					_fnStringToCss( column.sWidthOrig ) :
+					'';
+=09
+				// For scrollX we need to force the column width otherwise the
+				// browser will collapse it. If this width is smaller than the
+				// width the column requires, then it will have no effect
+				if ( column.sWidthOrig && scrollX ) {
+					$( headerCells[i] ).append( $('<div/>').css( {
+						width: column.sWidthOrig,
+						margin: 0,
+						padding: 0,
+						border: 0,
+						height: 1
+					} ) );
+				}
+			}
+=09
+			// Find the widest cell for each column and put it into the table
+			if ( oSettings.aoData.length ) {
+				for ( i=3D0 ; i<visibleColumns.length ; i++ ) {
+					columnIdx =3D visibleColumns[i];
+					column =3D columns[ columnIdx ];
+=09
+					$( _fnGetWidestNode( oSettings, columnIdx ) )
+						.clone( false )
+						.append( column.sContentPadding )
+						.appendTo( tr );
+				}
+			}
+=09
+			// Tidy the temporary table - remove name attributes so there aren't
+			// duplicated in the dom (radio elements for example)
+			$('[name]', tmpTable).removeAttr('name');
+=09
+			// Table has been built, attach to the document so we can work with it.
+			// A holding element is used, positioned at the top of the container
+			// with minimal height, so it has no effect on if the container scrolls
+			// or not. Otherwise it might trigger scrolling when it actually isn't
+			// needed
+			var holder =3D $('<div/>').css( scrollX || scrollY ?
+					{
+						position: 'absolute',
+						top: 0,
+						left: 0,
+						height: 1,
+						right: 0,
+						overflow: 'hidden'
+					} :
+					{}
+				)
+				.append( tmpTable )
+				.appendTo( tableContainer );
+=09
+			// When scrolling (X or Y) we want to set the width of the table as=20
+			// appropriate. However, when not scrolling leave the table width as it
+			// is. This results in slightly different, but I think correct behaviour
+			if ( scrollX && scrollXInner ) {
+				tmpTable.width( scrollXInner );
+			}
+			else if ( scrollX ) {
+				tmpTable.css( 'width', 'auto' );
+				tmpTable.removeAttr('width');
+=09
+				// If there is no width attribute or style, then allow the table to
+				// collapse
+				if ( tmpTable.width() < tableContainer.clientWidth && tableWidthAttr )=
 {
+					tmpTable.width( tableContainer.clientWidth );
+				}
+			}
+			else if ( scrollY ) {
+				tmpTable.width( tableContainer.clientWidth );
+			}
+			else if ( tableWidthAttr ) {
+				tmpTable.width( tableWidthAttr );
+			}
+=09
+			// Get the width of each column in the constructed table - we need to
+			// know the inner width (so it can be assigned to the other table's
+			// cells) and the outer width so we can calculate the full width of the
+			// table. This is safe since DataTables requires a unique cell for each
+			// column, but if ever a header can span multiple columns, this will
+			// need to be modified.
+			var total =3D 0;
+			for ( i=3D0 ; i<visibleColumns.length ; i++ ) {
+				var cell =3D $(headerCells[i]);
+				var border =3D cell.outerWidth() - cell.width();
+=09
+				// Use getBounding... where possible (not IE8-) because it can give
+				// sub-pixel accuracy, which we then want to round up!
+				var bounding =3D browser.bBounding ?
+					Math.ceil( headerCells[i].getBoundingClientRect().width ) :
+					cell.outerWidth();
+=09
+				// Total is tracked to remove any sub-pixel errors as the outerWidth
+				// of the table might not equal the total given here (IE!).
+				total +=3D bounding;
+=09
+				// Width for each column to use
+				columns[ visibleColumns[i] ].sWidth =3D _fnStringToCss( bounding - bor=
der );
+			}
+=09
+			table.style.width =3D _fnStringToCss( total );
+=09
+			// Finished with the table - ditch it
+			holder.remove();
+		}
+=09
+		// If there is a width attr, we want to attach an event listener which
+		// allows the table sizing to automatically adjust when the window is
+		// resized. Use the width attr rather than CSS, since we can't know if t=
he
+		// CSS is a relative value or absolute - DOM read is always px.
+		if ( tableWidthAttr ) {
+			table.style.width =3D _fnStringToCss( tableWidthAttr );
+		}
+=09
+		if ( (tableWidthAttr || scrollX) && ! oSettings._reszEvt ) {
+			var bindResize =3D function () {
+				$(window).on('resize.DT-'+oSettings.sInstance, _fnThrottle( function (=
) {
+					_fnAdjustColumnSizing( oSettings );
+				} ) );
+			};
+=09
+			// IE6/7 will crash if we bind a resize event handler on page load.
+			// To be removed in 1.11 which drops IE6/7 support
+			if ( ie67 ) {
+				setTimeout( bindResize, 1000 );
+			}
+			else {
+				bindResize();
+			}
+=09
+			oSettings._reszEvt =3D true;
+		}
+	}
+=09
+=09
+	/**
+	 * Throttle the calls to a function. Arguments and context are maintained=
 for
+	 * the throttled function
+	 *  @param {function} fn Function to be called
+	 *  @param {int} [freq=3D200] call frequency in mS
+	 *  @returns {function} wrapped function
+	 *  @memberof DataTable#oApi
+	 */
+	var _fnThrottle =3D DataTable.util.throttle;
+=09
+=09
+	/**
+	 * Convert a CSS unit width to pixels (e.g. 2em)
+	 *  @param {string} width width to be converted
+	 *  @param {node} parent parent to get the with for (required for relativ=
e widths) - optional
+	 *  @returns {int} width in pixels
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnConvertToWidth ( width, parent )
+	{
+		if ( ! width ) {
+			return 0;
+		}
+=09
+		var n =3D $('<div/>')
+			.css( 'width', _fnStringToCss( width ) )
+			.appendTo( parent || document.body );
+=09
+		var val =3D n[0].offsetWidth;
+		n.remove();
+=09
+		return val;
+	}
+=09
+=09
+	/**
+	 * Get the widest node
+	 *  @param {object} settings dataTables settings object
+	 *  @param {int} colIdx column of interest
+	 *  @returns {node} widest table node
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnGetWidestNode( settings, colIdx )
+	{
+		var idx =3D _fnGetMaxLenString( settings, colIdx );
+		if ( idx < 0 ) {
+			return null;
+		}
+=09
+		var data =3D settings.aoData[ idx ];
+		return ! data.nTr ? // Might not have been created when deferred renderi=
ng
+			$('<td/>').html( _fnGetCellData( settings, idx, colIdx, 'display' ) )[0=
] :
+			data.anCells[ colIdx ];
+	}
+=09
+=09
+	/**
+	 * Get the maximum strlen for each data column
+	 *  @param {object} settings dataTables settings object
+	 *  @param {int} colIdx column of interest
+	 *  @returns {string} max string length for each column
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnGetMaxLenString( settings, colIdx )
+	{
+		var s, max=3D-1, maxIdx =3D -1;
+=09
+		for ( var i=3D0, ien=3Dsettings.aoData.length ; i<ien ; i++ ) {
+			s =3D _fnGetCellData( settings, i, colIdx, 'display' )+'';
+			s =3D s.replace( __re_html_remove, '' );
+			s =3D s.replace( /&nbsp;/g, ' ' );
+=09
+			if ( s.length > max ) {
+				max =3D s.length;
+				maxIdx =3D i;
+			}
+		}
+=09
+		return maxIdx;
+	}
+=09
+=09
+	/**
+	 * Append a CSS unit (only if required) to a string
+	 *  @param {string} value to css-ify
+	 *  @returns {string} value with css unit
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnStringToCss( s )
+	{
+		if ( s =3D=3D=3D null ) {
+			return '0px';
+		}
+=09
+		if ( typeof s =3D=3D 'number' ) {
+			return s < 0 ?
+				'0px' :
+				s+'px';
+		}
+=09
+		// Check it has a unit character already
+		return s.match(/\d$/) ?
+			s+'px' :
+			s;
+	}
+=09
+=09
+=09
+	function _fnSortFlatten ( settings )
+	{
+		var
+			i, iLen, k, kLen,
+			aSort =3D [],
+			aiOrig =3D [],
+			aoColumns =3D settings.aoColumns,
+			aDataSort, iCol, sType, srcCol,
+			fixed =3D settings.aaSortingFixed,
+			fixedObj =3D $.isPlainObject( fixed ),
+			nestedSort =3D [],
+			add =3D function ( a ) {
+				if ( a.length && ! Array.isArray( a[0] ) ) {
+					// 1D array
+					nestedSort.push( a );
+				}
+				else {
+					// 2D array
+					$.merge( nestedSort, a );
+				}
+			};
+=09
+		// Build the sort array, with pre-fix and post-fix options if they have =
been
+		// specified
+		if ( Array.isArray( fixed ) ) {
+			add( fixed );
+		}
+=09
+		if ( fixedObj && fixed.pre ) {
+			add( fixed.pre );
+		}
+=09
+		add( settings.aaSorting );
+=09
+		if (fixedObj && fixed.post ) {
+			add( fixed.post );
+		}
+=09
+		for ( i=3D0 ; i<nestedSort.length ; i++ )
+		{
+			srcCol =3D nestedSort[i][0];
+			aDataSort =3D aoColumns[ srcCol ].aDataSort;
+=09
+			for ( k=3D0, kLen=3DaDataSort.length ; k<kLen ; k++ )
+			{
+				iCol =3D aDataSort[k];
+				sType =3D aoColumns[ iCol ].sType || 'string';
+=09
+				if ( nestedSort[i]._idx =3D=3D=3D undefined ) {
+					nestedSort[i]._idx =3D $.inArray( nestedSort[i][1], aoColumns[iCol].a=
sSorting );
+				}
+=09
+				aSort.push( {
+					src:       srcCol,
+					col:       iCol,
+					dir:       nestedSort[i][1],
+					index:     nestedSort[i]._idx,
+					type:      sType,
+					formatter: DataTable.ext.type.order[ sType+"-pre" ]
+				} );
+			}
+		}
+=09
+		return aSort;
+	}
+=09
+	/**
+	 * Change the order of the table
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 *  @todo This really needs split up!
+	 */
+	function _fnSort ( oSettings )
+	{
+		var
+			i, ien, iLen, j, jLen, k, kLen,
+			sDataType, nTh,
+			aiOrig =3D [],
+			oExtSort =3D DataTable.ext.type.order,
+			aoData =3D oSettings.aoData,
+			aoColumns =3D oSettings.aoColumns,
+			aDataSort, data, iCol, sType, oSort,
+			formatters =3D 0,
+			sortCol,
+			displayMaster =3D oSettings.aiDisplayMaster,
+			aSort;
+=09
+		// Resolve any column types that are unknown due to addition or invalida=
tion
+		// @todo Can this be moved into a 'data-ready' handler which is called w=
hen
+		//   data is going to be used in the table?
+		_fnColumnTypes( oSettings );
+=09
+		aSort =3D _fnSortFlatten( oSettings );
+=09
+		for ( i=3D0, ien=3DaSort.length ; i<ien ; i++ ) {
+			sortCol =3D aSort[i];
+=09
+			// Track if we can use the fast sort algorithm
+			if ( sortCol.formatter ) {
+				formatters++;
+			}
+=09
+			// Load the data needed for the sort, for each cell
+			_fnSortData( oSettings, sortCol.col );
+		}
+=09
+		/* No sorting required if server-side or no sorting array */
+		if ( _fnDataSource( oSettings ) !=3D 'ssp' && aSort.length !=3D=3D 0 )
+		{
+			// Create a value - key array of the current row positions such that we=
 can use their
+			// current position during the sort, if values match, in order to perfo=
rm stable sorting
+			for ( i=3D0, iLen=3DdisplayMaster.length ; i<iLen ; i++ ) {
+				aiOrig[ displayMaster[i] ] =3D i;
+			}
+=09
+			/* Do the sort - here we want multi-column sorting based on a given dat=
a source (column)
+			 * and sorting function (from oSort) in a certain direction. It's reaso=
nably complex to
+			 * follow on it's own, but this is what we want (example two column sor=
ting):
+			 *  fnLocalSorting =3D function(a,b){
+			 *    var iTest;
+			 *    iTest =3D oSort['string-asc']('data11', 'data12');
+			 *      if (iTest !=3D=3D 0)
+			 *        return iTest;
+			 *    iTest =3D oSort['numeric-desc']('data21', 'data22');
+			 *    if (iTest !=3D=3D 0)
+			 *      return iTest;
+			 *    return oSort['numeric-asc']( aiOrig[a], aiOrig[b] );
+			 *  }
+			 * Basically we have a test for each sorting column, if the data in tha=
t column is equal,
+			 * test the next column. If all columns match, then we use a numeric so=
rt on the row
+			 * positions in the original data array to provide a stable sort.
+			 *
+			 * Note - I know it seems excessive to have two sorting methods, but th=
e first is around
+			 * 15% faster, so the second is only maintained for backwards compatibi=
lity with sorting
+			 * methods which do not have a pre-sort formatting function.
+			 */
+			if ( formatters =3D=3D=3D aSort.length ) {
+				// All sort types have formatting functions
+				displayMaster.sort( function ( a, b ) {
+					var
+						x, y, k, test, sort,
+						len=3DaSort.length,
+						dataA =3D aoData[a]._aSortData,
+						dataB =3D aoData[b]._aSortData;
+=09
+					for ( k=3D0 ; k<len ; k++ ) {
+						sort =3D aSort[k];
+=09
+						x =3D dataA[ sort.col ];
+						y =3D dataB[ sort.col ];
+=09
+						test =3D x<y ? -1 : x>y ? 1 : 0;
+						if ( test !=3D=3D 0 ) {
+							return sort.dir =3D=3D=3D 'asc' ? test : -test;
+						}
+					}
+=09
+					x =3D aiOrig[a];
+					y =3D aiOrig[b];
+					return x<y ? -1 : x>y ? 1 : 0;
+				} );
+			}
+			else {
+				// Depreciated - remove in 1.11 (providing a plug-in option)
+				// Not all sort types have formatting methods, so we have to call thei=
r sorting
+				// methods.
+				displayMaster.sort( function ( a, b ) {
+					var
+						x, y, k, l, test, sort, fn,
+						len=3DaSort.length,
+						dataA =3D aoData[a]._aSortData,
+						dataB =3D aoData[b]._aSortData;
+=09
+					for ( k=3D0 ; k<len ; k++ ) {
+						sort =3D aSort[k];
+=09
+						x =3D dataA[ sort.col ];
+						y =3D dataB[ sort.col ];
+=09
+						fn =3D oExtSort[ sort.type+"-"+sort.dir ] || oExtSort[ "string-"+sor=
t.dir ];
+						test =3D fn( x, y );
+						if ( test !=3D=3D 0 ) {
+							return test;
+						}
+					}
+=09
+					x =3D aiOrig[a];
+					y =3D aiOrig[b];
+					return x<y ? -1 : x>y ? 1 : 0;
+				} );
+			}
+		}
+=09
+		/* Tell the draw function that we have sorted the data */
+		oSettings.bSorted =3D true;
+	}
+=09
+=09
+	function _fnSortAria ( settings )
+	{
+		var label;
+		var nextSort;
+		var columns =3D settings.aoColumns;
+		var aSort =3D _fnSortFlatten( settings );
+		var oAria =3D settings.oLanguage.oAria;
+=09
+		// ARIA attributes - need to loop all columns, to update all (removing o=
ld
+		// attributes as needed)
+		for ( var i=3D0, iLen=3Dcolumns.length ; i<iLen ; i++ )
+		{
+			var col =3D columns[i];
+			var asSorting =3D col.asSorting;
+			var sTitle =3D col.ariaTitle || col.sTitle.replace( /<.*?>/g, "" );
+			var th =3D col.nTh;
+=09
+			// IE7 is throwing an error when setting these properties with jQuery's
+			// attr() and removeAttr() methods...
+			th.removeAttribute('aria-sort');
+=09
+			/* In ARIA only the first sorting column can be marked as sorting - no =
multi-sort option */
+			if ( col.bSortable ) {
+				if ( aSort.length > 0 && aSort[0].col =3D=3D i ) {
+					th.setAttribute('aria-sort', aSort[0].dir=3D=3D"asc" ? "ascending" : =
"descending" );
+					nextSort =3D asSorting[ aSort[0].index+1 ] || asSorting[0];
+				}
+				else {
+					nextSort =3D asSorting[0];
+				}
+=09
+				label =3D sTitle + ( nextSort =3D=3D=3D "asc" ?
+					oAria.sSortAscending :
+					oAria.sSortDescending
+				);
+			}
+			else {
+				label =3D sTitle;
+			}
+=09
+			th.setAttribute('aria-label', label);
+		}
+	}
+=09
+=09
+	/**
+	 * Function to run on user sort request
+	 *  @param {object} settings dataTables settings object
+	 *  @param {node} attachTo node to attach the handler to
+	 *  @param {int} colIdx column sorting index
+	 *  @param {boolean} [append=3Dfalse] Append the requested sort to the ex=
isting
+	 *    sort if true (i.e. multi-column sort)
+	 *  @param {function} [callback] callback function
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnSortListener ( settings, colIdx, append, callback )
+	{
+		var col =3D settings.aoColumns[ colIdx ];
+		var sorting =3D settings.aaSorting;
+		var asSorting =3D col.asSorting;
+		var nextSortIdx;
+		var next =3D function ( a, overflow ) {
+			var idx =3D a._idx;
+			if ( idx =3D=3D=3D undefined ) {
+				idx =3D $.inArray( a[1], asSorting );
+			}
+=09
+			return idx+1 < asSorting.length ?
+				idx+1 :
+				overflow ?
+					null :
+					0;
+		};
+=09
+		// Convert to 2D array if needed
+		if ( typeof sorting[0] =3D=3D=3D 'number' ) {
+			sorting =3D settings.aaSorting =3D [ sorting ];
+		}
+=09
+		// If appending the sort then we are multi-column sorting
+		if ( append && settings.oFeatures.bSortMulti ) {
+			// Are we already doing some kind of sort on this column?
+			var sortIdx =3D $.inArray( colIdx, _pluck(sorting, '0') );
+=09
+			if ( sortIdx !=3D=3D -1 ) {
+				// Yes, modify the sort
+				nextSortIdx =3D next( sorting[sortIdx], true );
+=09
+				if ( nextSortIdx =3D=3D=3D null && sorting.length =3D=3D=3D 1 ) {
+					nextSortIdx =3D 0; // can't remove sorting completely
+				}
+=09
+				if ( nextSortIdx =3D=3D=3D null ) {
+					sorting.splice( sortIdx, 1 );
+				}
+				else {
+					sorting[sortIdx][1] =3D asSorting[ nextSortIdx ];
+					sorting[sortIdx]._idx =3D nextSortIdx;
+				}
+			}
+			else {
+				// No sort on this column yet
+				sorting.push( [ colIdx, asSorting[0], 0 ] );
+				sorting[sorting.length-1]._idx =3D 0;
+			}
+		}
+		else if ( sorting.length && sorting[0][0] =3D=3D colIdx ) {
+			// Single column - already sorting on this column, modify the sort
+			nextSortIdx =3D next( sorting[0] );
+=09
+			sorting.length =3D 1;
+			sorting[0][1] =3D asSorting[ nextSortIdx ];
+			sorting[0]._idx =3D nextSortIdx;
+		}
+		else {
+			// Single column - sort only on this column
+			sorting.length =3D 0;
+			sorting.push( [ colIdx, asSorting[0] ] );
+			sorting[0]._idx =3D 0;
+		}
+=09
+		// Run the sort by calling a full redraw
+		_fnReDraw( settings );
+=09
+		// callback used for async user interaction
+		if ( typeof callback =3D=3D 'function' ) {
+			callback( settings );
+		}
+	}
+=09
+=09
+	/**
+	 * Attach a sort handler (click) to a node
+	 *  @param {object} settings dataTables settings object
+	 *  @param {node} attachTo node to attach the handler to
+	 *  @param {int} colIdx column sorting index
+	 *  @param {function} [callback] callback function
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnSortAttachListener ( settings, attachTo, colIdx, callback )
+	{
+		var col =3D settings.aoColumns[ colIdx ];
+=09
+		_fnBindAction( attachTo, {}, function (e) {
+			/* If the column is not sortable - don't to anything */
+			if ( col.bSortable =3D=3D=3D false ) {
+				return;
+			}
+=09
+			// If processing is enabled use a timeout to allow the processing
+			// display to be shown - otherwise to it synchronously
+			if ( settings.oFeatures.bProcessing ) {
+				_fnProcessingDisplay( settings, true );
+=09
+				setTimeout( function() {
+					_fnSortListener( settings, colIdx, e.shiftKey, callback );
+=09
+					// In server-side processing, the draw callback will remove the
+					// processing display
+					if ( _fnDataSource( settings ) !=3D=3D 'ssp' ) {
+						_fnProcessingDisplay( settings, false );
+					}
+				}, 0 );
+			}
+			else {
+				_fnSortListener( settings, colIdx, e.shiftKey, callback );
+			}
+		} );
+	}
+=09
+=09
+	/**
+	 * Set the sorting classes on table's body, Note: it is safe to call this=
 function
+	 * when bSort and bSortClasses are false
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnSortingClasses( settings )
+	{
+		var oldSort =3D settings.aLastSort;
+		var sortClass =3D settings.oClasses.sSortColumn;
+		var sort =3D _fnSortFlatten( settings );
+		var features =3D settings.oFeatures;
+		var i, ien, colIdx;
+=09
+		if ( features.bSort && features.bSortClasses ) {
+			// Remove old sorting classes
+			for ( i=3D0, ien=3DoldSort.length ; i<ien ; i++ ) {
+				colIdx =3D oldSort[i].src;
+=09
+				// Remove column sorting
+				$( _pluck( settings.aoData, 'anCells', colIdx ) )
+					.removeClass( sortClass + (i<2 ? i+1 : 3) );
+			}
+=09
+			// Add new column sorting
+			for ( i=3D0, ien=3Dsort.length ; i<ien ; i++ ) {
+				colIdx =3D sort[i].src;
+=09
+				$( _pluck( settings.aoData, 'anCells', colIdx ) )
+					.addClass( sortClass + (i<2 ? i+1 : 3) );
+			}
+		}
+=09
+		settings.aLastSort =3D sort;
+	}
+=09
+=09
+	// Get the data to sort a column, be it from cache, fresh (populating the
+	// cache), or from a sort formatter
+	function _fnSortData( settings, idx )
+	{
+		// Custom sorting function - provided by the sort data type
+		var column =3D settings.aoColumns[ idx ];
+		var customSort =3D DataTable.ext.order[ column.sSortDataType ];
+		var customData;
+=09
+		if ( customSort ) {
+			customData =3D customSort.call( settings.oInstance, settings, idx,
+				_fnColumnIndexToVisible( settings, idx )
+			);
+		}
+=09
+		// Use / populate cache
+		var row, cellData;
+		var formatter =3D DataTable.ext.type.order[ column.sType+"-pre" ];
+=09
+		for ( var i=3D0, ien=3Dsettings.aoData.length ; i<ien ; i++ ) {
+			row =3D settings.aoData[i];
+=09
+			if ( ! row._aSortData ) {
+				row._aSortData =3D [];
+			}
+=09
+			if ( ! row._aSortData[idx] || customSort ) {
+				cellData =3D customSort ?
+					customData[i] : // If there was a custom sort function, use data from=
 there
+					_fnGetCellData( settings, i, idx, 'sort' );
+=09
+				row._aSortData[ idx ] =3D formatter ?
+					formatter( cellData ) :
+					cellData;
+			}
+		}
+	}
+=09
+=09
+=09
+	/**
+	 * Save the state of a table
+	 *  @param {object} oSettings dataTables settings object
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnSaveState ( settings )
+	{
+		if (settings._bLoadingState) {
+			return;
+		}
+=09
+		/* Store the interesting variables */
+		var state =3D {
+			time:    +new Date(),
+			start:   settings._iDisplayStart,
+			length:  settings._iDisplayLength,
+			order:   $.extend( true, [], settings.aaSorting ),
+			search:  _fnSearchToCamel( settings.oPreviousSearch ),
+			columns: $.map( settings.aoColumns, function ( col, i ) {
+				return {
+					visible: col.bVisible,
+					search: _fnSearchToCamel( settings.aoPreSearchCols[i] )
+				};
+			} )
+		};
+=09
+		settings.oSavedState =3D state;
+		_fnCallbackFire( settings, "aoStateSaveParams", 'stateSaveParams', [sett=
ings, state] );
+=09=09
+		if ( settings.oFeatures.bStateSave && !settings.bDestroying )
+		{
+			settings.fnStateSaveCallback.call( settings.oInstance, settings, state =
);
+		}=09
+	}
+=09
+=09
+	/**
+	 * Attempt to load a saved table state
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {object} oInit DataTables init object so we can override setti=
ngs
+	 *  @param {function} callback Callback to execute when the state has bee=
n loaded
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnLoadState ( settings, oInit, callback )
+	{
+		if ( ! settings.oFeatures.bStateSave ) {
+			callback();
+			return;
+		}
+=09
+		var loaded =3D function(state) {
+			_fnImplementState(settings, state, callback);
+		}
+=09
+		var state =3D settings.fnStateLoadCallback.call( settings.oInstance, set=
tings, loaded );
+=09
+		if ( state !=3D=3D undefined ) {
+			_fnImplementState( settings, state, callback );
+		}
+		// otherwise, wait for the loaded callback to be executed
+=09
+		return true;
+	}
+=09
+	function _fnImplementState ( settings, s, callback) {
+		var i, ien;
+		var columns =3D settings.aoColumns;
+		settings._bLoadingState =3D true;
+=09
+		// When StateRestore was introduced the state could now be implemented a=
t any time
+		// Not just initialisation. To do this an api instance is required in so=
me places
+		var api =3D settings._bInitComplete ? new DataTable.Api(settings) : null;
+=09
+		if ( ! s || ! s.time ) {
+			settings._bLoadingState =3D false;
+			callback();
+			return;
+		}
+=09
+		// Allow custom and plug-in manipulation functions to alter the saved da=
ta set and
+		// cancelling of loading by returning false
+		var abStateLoad =3D _fnCallbackFire( settings, 'aoStateLoadParams', 'sta=
teLoadParams', [settings, s] );
+		if ( $.inArray( false, abStateLoad ) !=3D=3D -1 ) {
+			settings._bLoadingState =3D false;
+			callback();
+			return;
+		}
+=09
+		// Reject old data
+		var duration =3D settings.iStateDuration;
+		if ( duration > 0 && s.time < +new Date() - (duration*1000) ) {
+			settings._bLoadingState =3D false;
+			callback();
+			return;
+		}
+=09
+		// Number of columns have changed - all bets are off, no restore of sett=
ings
+		if ( s.columns && columns.length !=3D=3D s.columns.length ) {
+			settings._bLoadingState =3D false;
+			callback();
+			return;
+		}
+=09
+		// Store the saved state so it might be accessed at any time
+		settings.oLoadedState =3D $.extend( true, {}, s );
+=09
+		// Restore key features - todo - for 1.11 this needs to be done by
+		// subscribed events
+		if ( s.start !=3D=3D undefined ) {
+			if(api =3D=3D=3D null) {
+				settings._iDisplayStart    =3D s.start;
+				settings.iInitDisplayStart =3D s.start;
+			}
+			else {
+				_fnPageChange(settings, s.start/s.length);
+=09
+			}
+		}
+		if ( s.length !=3D=3D undefined ) {
+			settings._iDisplayLength   =3D s.length;
+		}
+=09
+		// Order
+		if ( s.order !=3D=3D undefined ) {
+			settings.aaSorting =3D [];
+			$.each( s.order, function ( i, col ) {
+				settings.aaSorting.push( col[0] >=3D columns.length ?
+					[ 0, col[1] ] :
+					col
+				);
+			} );
+		}
+=09
+		// Search
+		if ( s.search !=3D=3D undefined ) {
+			$.extend( settings.oPreviousSearch, _fnSearchToHung( s.search ) );
+		}
+=09
+		// Columns
+		if ( s.columns ) {
+			for ( i=3D0, ien=3Ds.columns.length ; i<ien ; i++ ) {
+				var col =3D s.columns[i];
+=09
+				// Visibility
+				if ( col.visible !=3D=3D undefined ) {
+					// If the api is defined, the table has been initialised so we need t=
o use it rather than internal settings
+					if (api) {
+						// Don't redraw the columns on every iteration of this loop, we will=
 do this at the end instead
+						api.column(i).visible(col.visible, false);
+					}
+					else {
+						columns[i].bVisible =3D col.visible;
+					}
+				}
+=09
+				// Search
+				if ( col.search !=3D=3D undefined ) {
+					$.extend( settings.aoPreSearchCols[i], _fnSearchToHung( col.search ) =
);
+				}
+			}
+=09=09=09
+			// If the api is defined then we need to adjust the columns once the vi=
sibility has been changed
+			if (api) {
+				api.columns.adjust();
+			}
+		}
+=09
+		settings._bLoadingState =3D false;
+		_fnCallbackFire( settings, 'aoStateLoaded', 'stateLoaded', [settings, s]=
 );
+		callback();
+	};
+=09
+=09
+	/**
+	 * Return the settings object for a particular table
+	 *  @param {node} table table we are using as a dataTable
+	 *  @returns {object} Settings object - or null if not found
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnSettingsFromNode ( table )
+	{
+		var settings =3D DataTable.settings;
+		var idx =3D $.inArray( table, _pluck( settings, 'nTable' ) );
+=09
+		return idx !=3D=3D -1 ?
+			settings[ idx ] :
+			null;
+	}
+=09
+=09
+	/**
+	 * Log an error message
+	 *  @param {object} settings dataTables settings object
+	 *  @param {int} level log error messages, or display them to the user
+	 *  @param {string} msg error message
+	 *  @param {int} tn Technical note id to get more information about the e=
rror.
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnLog( settings, level, msg, tn )
+	{
+		msg =3D 'DataTables warning: '+
+			(settings ? 'table id=3D'+settings.sTableId+' - ' : '')+msg;
+=09
+		if ( tn ) {
+			msg +=3D '. For more information about this error, please see '+
+			'http://datatables.net/tn/'+tn;
+		}
+=09
+		if ( ! level  ) {
+			// Backwards compatibility pre 1.10
+			var ext =3D DataTable.ext;
+			var type =3D ext.sErrMode || ext.errMode;
+=09
+			if ( settings ) {
+				_fnCallbackFire( settings, null, 'error', [ settings, tn, msg ] );
+			}
+=09
+			if ( type =3D=3D 'alert' ) {
+				alert( msg );
+			}
+			else if ( type =3D=3D 'throw' ) {
+				throw new Error(msg);
+			}
+			else if ( typeof type =3D=3D 'function' ) {
+				type( settings, tn, msg );
+			}
+		}
+		else if ( window.console && console.log ) {
+			console.log( msg );
+		}
+	}
+=09
+=09
+	/**
+	 * See if a property is defined on one object, if so assign it to the oth=
er object
+	 *  @param {object} ret target object
+	 *  @param {object} src source object
+	 *  @param {string} name property
+	 *  @param {string} [mappedName] name to map too - optional, name used if=
 not given
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnMap( ret, src, name, mappedName )
+	{
+		if ( Array.isArray( name ) ) {
+			$.each( name, function (i, val) {
+				if ( Array.isArray( val ) ) {
+					_fnMap( ret, src, val[0], val[1] );
+				}
+				else {
+					_fnMap( ret, src, val );
+				}
+			} );
+=09
+			return;
+		}
+=09
+		if ( mappedName =3D=3D=3D undefined ) {
+			mappedName =3D name;
+		}
+=09
+		if ( src[name] !=3D=3D undefined ) {
+			ret[mappedName] =3D src[name];
+		}
+	}
+=09
+=09
+	/**
+	 * Extend objects - very similar to jQuery.extend, but deep copy objects,=
 and
+	 * shallow copy arrays. The reason we need to do this, is that we don't w=
ant to
+	 * deep copy array init values (such as aaSorting) since the dev wouldn't=
 be
+	 * able to override them, but we do want to deep copy arrays.
+	 *  @param {object} out Object to extend
+	 *  @param {object} extender Object from which the properties will be app=
lied to
+	 *      out
+	 *  @param {boolean} breakRefs If true, then arrays will be sliced to tak=
e an
+	 *      independent copy with the exception of the `data` or `aaData` par=
ameters
+	 *      if they are present. This is so you can pass in a collection to
+	 *      DataTables and have that used as your data source without breakin=
g the
+	 *      references
+	 *  @returns {object} out Reference, just for convenience - out =3D=3D=3D=
 the return.
+	 *  @memberof DataTable#oApi
+	 *  @todo This doesn't take account of arrays inside the deep copied obje=
cts.
+	 */
+	function _fnExtend( out, extender, breakRefs )
+	{
+		var val;
+=09
+		for ( var prop in extender ) {
+			if ( extender.hasOwnProperty(prop) ) {
+				val =3D extender[prop];
+=09
+				if ( $.isPlainObject( val ) ) {
+					if ( ! $.isPlainObject( out[prop] ) ) {
+						out[prop] =3D {};
+					}
+					$.extend( true, out[prop], val );
+				}
+				else if ( breakRefs && prop !=3D=3D 'data' && prop !=3D=3D 'aaData' &&=
 Array.isArray(val) ) {
+					out[prop] =3D val.slice();
+				}
+				else {
+					out[prop] =3D val;
+				}
+			}
+		}
+=09
+		return out;
+	}
+=09
+=09
+	/**
+	 * Bind an event handers to allow a click or return key to activate the c=
allback.
+	 * This is good for accessibility since a return on the keyboard will hav=
e the
+	 * same effect as a click, if the element has focus.
+	 *  @param {element} n Element to bind the action to
+	 *  @param {object} oData Data object to pass to the triggered function
+	 *  @param {function} fn Callback function for when the event is triggered
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnBindAction( n, oData, fn )
+	{
+		$(n)
+			.on( 'click.DT', oData, function (e) {
+					$(n).trigger('blur'); // Remove focus outline for mouse users
+					fn(e);
+				} )
+			.on( 'keypress.DT', oData, function (e){
+					if ( e.which =3D=3D=3D 13 ) {
+						e.preventDefault();
+						fn(e);
+					}
+				} )
+			.on( 'selectstart.DT', function () {
+					/* Take the brutal approach to cancelling text selection */
+					return false;
+				} );
+	}
+=09
+=09
+	/**
+	 * Register a callback function. Easily allows a callback function to be =
added to
+	 * an array store of callback functions that can then all be called toget=
her.
+	 *  @param {object} oSettings dataTables settings object
+	 *  @param {string} sStore Name of the array storage for the callbacks in=
 oSettings
+	 *  @param {function} fn Function to be called back
+	 *  @param {string} sName Identifying name for the callback (i.e. a label)
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnCallbackReg( oSettings, sStore, fn, sName )
+	{
+		if ( fn )
+		{
+			oSettings[sStore].push( {
+				"fn": fn,
+				"sName": sName
+			} );
+		}
+	}
+=09
+=09
+	/**
+	 * Fire callback functions and trigger events. Note that the loop over the
+	 * callback array store is done backwards! Further note that you do not w=
ant to
+	 * fire off triggers in time sensitive applications (for example cell cre=
ation)
+	 * as its slow.
+	 *  @param {object} settings dataTables settings object
+	 *  @param {string} callbackArr Name of the array storage for the callbac=
ks in
+	 *      oSettings
+	 *  @param {string} eventName Name of the jQuery custom event to trigger.=
 If
+	 *      null no trigger is fired
+	 *  @param {array} args Array of arguments to pass to the callback functi=
on /
+	 *      trigger
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnCallbackFire( settings, callbackArr, eventName, args )
+	{
+		var ret =3D [];
+=09
+		if ( callbackArr ) {
+			ret =3D $.map( settings[callbackArr].slice().reverse(), function (val, =
i) {
+				return val.fn.apply( settings.oInstance, args );
+			} );
+		}
+=09
+		if ( eventName !=3D=3D null ) {
+			var e =3D $.Event( eventName+'.dt' );
+=09
+			$(settings.nTable).trigger( e, args );
+=09
+			ret.push( e.result );
+		}
+=09
+		return ret;
+	}
+=09
+=09
+	function _fnLengthOverflow ( settings )
+	{
+		var
+			start =3D settings._iDisplayStart,
+			end =3D settings.fnDisplayEnd(),
+			len =3D settings._iDisplayLength;
+=09
+		/* If we have space to show extra rows (backing up from the end point - =
then do so */
+		if ( start >=3D end )
+		{
+			start =3D end - len;
+		}
+=09
+		// Keep the start record on the current page
+		start -=3D (start % len);
+=09
+		if ( len =3D=3D=3D -1 || start < 0 )
+		{
+			start =3D 0;
+		}
+=09
+		settings._iDisplayStart =3D start;
+	}
+=09
+=09
+	function _fnRenderer( settings, type )
+	{
+		var renderer =3D settings.renderer;
+		var host =3D DataTable.ext.renderer[type];
+=09
+		if ( $.isPlainObject( renderer ) && renderer[type] ) {
+			// Specific renderer for this type. If available use it, otherwise use
+			// the default.
+			return host[renderer[type]] || host._;
+		}
+		else if ( typeof renderer =3D=3D=3D 'string' ) {
+			// Common renderer - if there is one available for this type use it,
+			// otherwise use the default
+			return host[renderer] || host._;
+		}
+=09
+		// Use the default
+		return host._;
+	}
+=09
+=09
+	/**
+	 * Detect the data source being used for the table. Used to simplify the =
code
+	 * a little (ajax) and to make it compress a little smaller.
+	 *
+	 *  @param {object} settings dataTables settings object
+	 *  @returns {string} Data source
+	 *  @memberof DataTable#oApi
+	 */
+	function _fnDataSource ( settings )
+	{
+		if ( settings.oFeatures.bServerSide ) {
+			return 'ssp';
+		}
+		else if ( settings.ajax || settings.sAjaxSource ) {
+			return 'ajax';
+		}
+		return 'dom';
+	}
+=09
+=09
+=09
+=09
+	/**
+	 * Computed structure of the DataTables API, defined by the options passe=
d to
+	 * `DataTable.Api.register()` when building the API.
+	 *
+	 * The structure is built in order to speed creation and extension of the=
 Api
+	 * objects since the extensions are effectively pre-parsed.
+	 *
+	 * The array is an array of objects with the following structure, where t=
his
+	 * base array represents the Api prototype base:
+	 *
+	 *     [
+	 *       {
+	 *         name:      'data'                -- string   - Property name
+	 *         val:       function () {},       -- function - Api method (or =
undefined if just an object
+	 *         methodExt: [ ... ],              -- array    - Array of Api ob=
ject definitions to extend the method result
+	 *         propExt:   [ ... ]               -- array    - Array of Api ob=
ject definitions to extend the property
+	 *       },
+	 *       {
+	 *         name:     'row'
+	 *         val:       {},
+	 *         methodExt: [ ... ],
+	 *         propExt:   [
+	 *           {
+	 *             name:      'data'
+	 *             val:       function () {},
+	 *             methodExt: [ ... ],
+	 *             propExt:   [ ... ]
+	 *           },
+	 *           ...
+	 *         ]
+	 *       }
+	 *     ]
+	 *
+	 * @type {Array}
+	 * @ignore
+	 */
+	var __apiStruct =3D [];
+=09
+=09
+	/**
+	 * `Array.prototype` reference.
+	 *
+	 * @type object
+	 * @ignore
+	 */
+	var __arrayProto =3D Array.prototype;
+=09
+=09
+	/**
+	 * Abstraction for `context` parameter of the `Api` constructor to allow =
it to
+	 * take several different forms for ease of use.
+	 *
+	 * Each of the input parameter types will be converted to a DataTables se=
ttings
+	 * object where possible.
+	 *
+	 * @param  {string|node|jQuery|object} mixed DataTable identifier. Can be=
 one
+	 *   of:
+	 *
+	 *   * `string` - jQuery selector. Any DataTables' matching the given sel=
ector
+	 *     with be found and used.
+	 *   * `node` - `TABLE` node which has already been formed into a DataTab=
le.
+	 *   * `jQuery` - A jQuery object of `TABLE` nodes.
+	 *   * `object` - DataTables settings object
+	 *   * `DataTables.Api` - API instance
+	 * @return {array|null} Matching DataTables settings objects. `null` or
+	 *   `undefined` is returned if no matching DataTable is found.
+	 * @ignore
+	 */
+	var _toSettings =3D function ( mixed )
+	{
+		var idx, jq;
+		var settings =3D DataTable.settings;
+		var tables =3D $.map( settings, function (el, i) {
+			return el.nTable;
+		} );
+=09
+		if ( ! mixed ) {
+			return [];
+		}
+		else if ( mixed.nTable && mixed.oApi ) {
+			// DataTables settings object
+			return [ mixed ];
+		}
+		else if ( mixed.nodeName && mixed.nodeName.toLowerCase() =3D=3D=3D 'tabl=
e' ) {
+			// Table node
+			idx =3D $.inArray( mixed, tables );
+			return idx !=3D=3D -1 ? [ settings[idx] ] : null;
+		}
+		else if ( mixed && typeof mixed.settings =3D=3D=3D 'function' ) {
+			return mixed.settings().toArray();
+		}
+		else if ( typeof mixed =3D=3D=3D 'string' ) {
+			// jQuery selector
+			jq =3D $(mixed);
+		}
+		else if ( mixed instanceof $ ) {
+			// jQuery object (also DataTables instance)
+			jq =3D mixed;
+		}
+=09
+		if ( jq ) {
+			return jq.map( function(i) {
+				idx =3D $.inArray( this, tables );
+				return idx !=3D=3D -1 ? settings[idx] : null;
+			} ).toArray();
+		}
+	};
+=09
+=09
+	/**
+	 * DataTables API class - used to control and interface with  one or more
+	 * DataTables enhanced tables.
+	 *
+	 * The API class is heavily based on jQuery, presenting a chainable inter=
face
+	 * that you can use to interact with tables. Each instance of the API cla=
ss has
+	 * a "context" - i.e. the tables that it will operate on. This could be a=
 single
+	 * table, all tables on a page or a sub-set thereof.
+	 *
+	 * Additionally the API is designed to allow you to easily work with the =
data in
+	 * the tables, retrieving and manipulating it as required. This is done by
+	 * presenting the API class as an array like interface. The contents of t=
he
+	 * array depend upon the actions requested by each method (for example
+	 * `rows().nodes()` will return an array of nodes, while `rows().data()` =
will
+	 * return an array of objects or arrays depending upon your table's
+	 * configuration). The API object has a number of array like methods (`pu=
sh`,
+	 * `pop`, `reverse` etc) as well as additional helper methods (`each`, `p=
luck`,
+	 * `unique` etc) to assist your working with the data held in a table.
+	 *
+	 * Most methods (those which return an Api instance) are chainable, which=
 means
+	 * the return from a method call also has all of the methods available th=
at the
+	 * top level object had. For example, these two calls are equivalent:
+	 *
+	 *     // Not chained
+	 *     api.row.add( {...} );
+	 *     api.draw();
+	 *
+	 *     // Chained
+	 *     api.row.add( {...} ).draw();
+	 *
+	 * @class DataTable.Api
+	 * @param {array|object|string|jQuery} context DataTable identifier. This=
 is
+	 *   used to define which DataTables enhanced tables this API will operat=
e on.
+	 *   Can be one of:
+	 *
+	 *   * `string` - jQuery selector. Any DataTables' matching the given sel=
ector
+	 *     with be found and used.
+	 *   * `node` - `TABLE` node which has already been formed into a DataTab=
le.
+	 *   * `jQuery` - A jQuery object of `TABLE` nodes.
+	 *   * `object` - DataTables settings object
+	 * @param {array} [data] Data to initialise the Api instance with.
+	 *
+	 * @example
+	 *   // Direct initialisation during DataTables construction
+	 *   var api =3D $('#example').DataTable();
+	 *
+	 * @example
+	 *   // Initialisation using a DataTables jQuery object
+	 *   var api =3D $('#example').dataTable().api();
+	 *
+	 * @example
+	 *   // Initialisation as a constructor
+	 *   var api =3D new $.fn.DataTable.Api( 'table.dataTable' );
+	 */
+	_Api =3D function ( context, data )
+	{
+		if ( ! (this instanceof _Api) ) {
+			return new _Api( context, data );
+		}
+=09
+		var settings =3D [];
+		var ctxSettings =3D function ( o ) {
+			var a =3D _toSettings( o );
+			if ( a ) {
+				settings.push.apply( settings, a );
+			}
+		};
+=09
+		if ( Array.isArray( context ) ) {
+			for ( var i=3D0, ien=3Dcontext.length ; i<ien ; i++ ) {
+				ctxSettings( context[i] );
+			}
+		}
+		else {
+			ctxSettings( context );
+		}
+=09
+		// Remove duplicates
+		this.context =3D _unique( settings );
+=09
+		// Initial data
+		if ( data ) {
+			$.merge( this, data );
+		}
+=09
+		// selector
+		this.selector =3D {
+			rows: null,
+			cols: null,
+			opts: null
+		};
+=09
+		_Api.extend( this, this, __apiStruct );
+	};
+=09
+	DataTable.Api =3D _Api;
+=09
+	// Don't destroy the existing prototype, just extend it. Required for jQu=
ery 2's
+	// isPlainObject.
+	$.extend( _Api.prototype, {
+		any: function ()
+		{
+			return this.count() !=3D=3D 0;
+		},
+=09
+=09
+		concat:  __arrayProto.concat,
+=09
+=09
+		context: [], // array of table settings objects
+=09
+=09
+		count: function ()
+		{
+			return this.flatten().length;
+		},
+=09
+=09
+		each: function ( fn )
+		{
+			for ( var i=3D0, ien=3Dthis.length ; i<ien; i++ ) {
+				fn.call( this, this[i], i, this );
+			}
+=09
+			return this;
+		},
+=09
+=09
+		eq: function ( idx )
+		{
+			var ctx =3D this.context;
+=09
+			return ctx.length > idx ?
+				new _Api( ctx[idx], this[idx] ) :
+				null;
+		},
+=09
+=09
+		filter: function ( fn )
+		{
+			var a =3D [];
+=09
+			if ( __arrayProto.filter ) {
+				a =3D __arrayProto.filter.call( this, fn, this );
+			}
+			else {
+				// Compatibility for browsers without EMCA-252-5 (JS 1.6)
+				for ( var i=3D0, ien=3Dthis.length ; i<ien ; i++ ) {
+					if ( fn.call( this, this[i], i, this ) ) {
+						a.push( this[i] );
+					}
+				}
+			}
+=09
+			return new _Api( this.context, a );
+		},
+=09
+=09
+		flatten: function ()
+		{
+			var a =3D [];
+			return new _Api( this.context, a.concat.apply( a, this.toArray() ) );
+		},
+=09
+=09
+		join:    __arrayProto.join,
+=09
+=09
+		indexOf: __arrayProto.indexOf || function (obj, start)
+		{
+			for ( var i=3D(start || 0), ien=3Dthis.length ; i<ien ; i++ ) {
+				if ( this[i] =3D=3D=3D obj ) {
+					return i;
+				}
+			}
+			return -1;
+		},
+=09
+		iterator: function ( flatten, type, fn, alwaysNew ) {
+			var
+				a =3D [], ret,
+				i, ien, j, jen,
+				context =3D this.context,
+				rows, items, item,
+				selector =3D this.selector;
+=09
+			// Argument shifting
+			if ( typeof flatten =3D=3D=3D 'string' ) {
+				alwaysNew =3D fn;
+				fn =3D type;
+				type =3D flatten;
+				flatten =3D false;
+			}
+=09
+			for ( i=3D0, ien=3Dcontext.length ; i<ien ; i++ ) {
+				var apiInst =3D new _Api( context[i] );
+=09
+				if ( type =3D=3D=3D 'table' ) {
+					ret =3D fn.call( apiInst, context[i], i );
+=09
+					if ( ret !=3D=3D undefined ) {
+						a.push( ret );
+					}
+				}
+				else if ( type =3D=3D=3D 'columns' || type =3D=3D=3D 'rows' ) {
+					// this has same length as context - one entry for each table
+					ret =3D fn.call( apiInst, context[i], this[i], i );
+=09
+					if ( ret !=3D=3D undefined ) {
+						a.push( ret );
+					}
+				}
+				else if ( type =3D=3D=3D 'column' || type =3D=3D=3D 'column-rows' || t=
ype =3D=3D=3D 'row' || type =3D=3D=3D 'cell' ) {
+					// columns and rows share the same structure.
+					// 'this' is an array of column indexes for each context
+					items =3D this[i];
+=09
+					if ( type =3D=3D=3D 'column-rows' ) {
+						rows =3D _selector_row_indexes( context[i], selector.opts );
+					}
+=09
+					for ( j=3D0, jen=3Ditems.length ; j<jen ; j++ ) {
+						item =3D items[j];
+=09
+						if ( type =3D=3D=3D 'cell' ) {
+							ret =3D fn.call( apiInst, context[i], item.row, item.column, i, j );
+						}
+						else {
+							ret =3D fn.call( apiInst, context[i], item, i, j, rows );
+						}
+=09
+						if ( ret !=3D=3D undefined ) {
+							a.push( ret );
+						}
+					}
+				}
+			}
+=09
+			if ( a.length || alwaysNew ) {
+				var api =3D new _Api( context, flatten ? a.concat.apply( [], a ) : a );
+				var apiSelector =3D api.selector;
+				apiSelector.rows =3D selector.rows;
+				apiSelector.cols =3D selector.cols;
+				apiSelector.opts =3D selector.opts;
+				return api;
+			}
+			return this;
+		},
+=09
+=09
+		lastIndexOf: __arrayProto.lastIndexOf || function (obj, start)
+		{
+			// Bit cheeky...
+			return this.indexOf.apply( this.toArray.reverse(), arguments );
+		},
+=09
+=09
+		length:  0,
+=09
+=09
+		map: function ( fn )
+		{
+			var a =3D [];
+=09
+			if ( __arrayProto.map ) {
+				a =3D __arrayProto.map.call( this, fn, this );
+			}
+			else {
+				// Compatibility for browsers without EMCA-252-5 (JS 1.6)
+				for ( var i=3D0, ien=3Dthis.length ; i<ien ; i++ ) {
+					a.push( fn.call( this, this[i], i ) );
+				}
+			}
+=09
+			return new _Api( this.context, a );
+		},
+=09
+=09
+		pluck: function ( prop )
+		{
+			return this.map( function ( el ) {
+				return el[ prop ];
+			} );
+		},
+=09
+		pop:     __arrayProto.pop,
+=09
+=09
+		push:    __arrayProto.push,
+=09
+=09
+		// Does not return an API instance
+		reduce: __arrayProto.reduce || function ( fn, init )
+		{
+			return _fnReduce( this, fn, init, 0, this.length, 1 );
+		},
+=09
+=09
+		reduceRight: __arrayProto.reduceRight || function ( fn, init )
+		{
+			return _fnReduce( this, fn, init, this.length-1, -1, -1 );
+		},
+=09
+=09
+		reverse: __arrayProto.reverse,
+=09
+=09
+		// Object with rows, columns and opts
+		selector: null,
+=09
+=09
+		shift:   __arrayProto.shift,
+=09
+=09
+		slice: function () {
+			return new _Api( this.context, this );
+		},
+=09
+=09
+		sort:    __arrayProto.sort, // ? name - order?
+=09
+=09
+		splice:  __arrayProto.splice,
+=09
+=09
+		toArray: function ()
+		{
+			return __arrayProto.slice.call( this );
+		},
+=09
+=09
+		to$: function ()
+		{
+			return $( this );
+		},
+=09
+=09
+		toJQuery: function ()
+		{
+			return $( this );
+		},
+=09
+=09
+		unique: function ()
+		{
+			return new _Api( this.context, _unique(this) );
+		},
+=09
+=09
+		unshift: __arrayProto.unshift
+	} );
+=09
+=09
+	_Api.extend =3D function ( scope, obj, ext )
+	{
+		// Only extend API instances and static properties of the API
+		if ( ! ext.length || ! obj || ( ! (obj instanceof _Api) && ! obj.__dt_wr=
apper ) ) {
+			return;
+		}
+=09
+		var
+			i, ien,
+			struct,
+			methodScoping =3D function ( scope, fn, struc ) {
+				return function () {
+					var ret =3D fn.apply( scope, arguments );
+=09
+					// Method extension
+					_Api.extend( ret, ret, struc.methodExt );
+					return ret;
+				};
+			};
+=09
+		for ( i=3D0, ien=3Dext.length ; i<ien ; i++ ) {
+			struct =3D ext[i];
+=09
+			// Value
+			obj[ struct.name ] =3D struct.type =3D=3D=3D 'function' ?
+				methodScoping( scope, struct.val, struct ) :
+				struct.type =3D=3D=3D 'object' ?
+					{} :
+					struct.val;
+=09
+			obj[ struct.name ].__dt_wrapper =3D true;
+=09
+			// Property extension
+			_Api.extend( scope, obj[ struct.name ], struct.propExt );
+		}
+	};
+=09
+=09
+	// @todo - Is there need for an augment function?
+	// _Api.augment =3D function ( inst, name )
+	// {
+	// 	// Find src object in the structure from the name
+	// 	var parts =3D name.split('.');
+=09
+	// 	_Api.extend( inst, obj );
+	// };
+=09
+=09
+	//     [
+	//       {
+	//         name:      'data'                -- string   - Property name
+	//         val:       function () {},       -- function - Api method (or =
undefined if just an object
+	//         methodExt: [ ... ],              -- array    - Array of Api ob=
ject definitions to extend the method result
+	//         propExt:   [ ... ]               -- array    - Array of Api ob=
ject definitions to extend the property
+	//       },
+	//       {
+	//         name:     'row'
+	//         val:       {},
+	//         methodExt: [ ... ],
+	//         propExt:   [
+	//           {
+	//             name:      'data'
+	//             val:       function () {},
+	//             methodExt: [ ... ],
+	//             propExt:   [ ... ]
+	//           },
+	//           ...
+	//         ]
+	//       }
+	//     ]
+=09
+	_Api.register =3D _api_register =3D function ( name, val )
+	{
+		if ( Array.isArray( name ) ) {
+			for ( var j=3D0, jen=3Dname.length ; j<jen ; j++ ) {
+				_Api.register( name[j], val );
+			}
+			return;
+		}
+=09
+		var
+			i, ien,
+			heir =3D name.split('.'),
+			struct =3D __apiStruct,
+			key, method;
+=09
+		var find =3D function ( src, name ) {
+			for ( var i=3D0, ien=3Dsrc.length ; i<ien ; i++ ) {
+				if ( src[i].name =3D=3D=3D name ) {
+					return src[i];
+				}
+			}
+			return null;
+		};
+=09
+		for ( i=3D0, ien=3Dheir.length ; i<ien ; i++ ) {
+			method =3D heir[i].indexOf('()') !=3D=3D -1;
+			key =3D method ?
+				heir[i].replace('()', '') :
+				heir[i];
+=09
+			var src =3D find( struct, key );
+			if ( ! src ) {
+				src =3D {
+					name:      key,
+					val:       {},
+					methodExt: [],
+					propExt:   [],
+					type:      'object'
+				};
+				struct.push( src );
+			}
+=09
+			if ( i =3D=3D=3D ien-1 ) {
+				src.val =3D val;
+				src.type =3D typeof val =3D=3D=3D 'function' ?
+					'function' :
+					$.isPlainObject( val ) ?
+						'object' :
+						'other';
+			}
+			else {
+				struct =3D method ?
+					src.methodExt :
+					src.propExt;
+			}
+		}
+	};
+=09
+	_Api.registerPlural =3D _api_registerPlural =3D function ( pluralName, si=
ngularName, val ) {
+		_Api.register( pluralName, val );
+=09
+		_Api.register( singularName, function () {
+			var ret =3D val.apply( this, arguments );
+=09
+			if ( ret =3D=3D=3D this ) {
+				// Returned item is the API instance that was passed in, return it
+				return this;
+			}
+			else if ( ret instanceof _Api ) {
+				// New API instance returned, want the value from the first item
+				// in the returned array for the singular result.
+				return ret.length ?
+					Array.isArray( ret[0] ) ?
+						new _Api( ret.context, ret[0] ) : // Array results are 'enhanced'
+						ret[0] :
+					undefined;
+			}
+=09
+			// Non-API return - just fire it back
+			return ret;
+		} );
+	};
+=09
+=09
+	/**
+	 * Selector for HTML tables. Apply the given selector to the give array of
+	 * DataTables settings objects.
+	 *
+	 * @param {string|integer} [selector] jQuery selector string or integer
+	 * @param  {array} Array of DataTables settings objects to be filtered
+	 * @return {array}
+	 * @ignore
+	 */
+	var __table_selector =3D function ( selector, a )
+	{
+		if ( Array.isArray(selector) ) {
+			return $.map( selector, function (item) {
+				return __table_selector(item, a);
+			} );
+		}
+=09
+		// Integer is used to pick out a table by index
+		if ( typeof selector =3D=3D=3D 'number' ) {
+			return [ a[ selector ] ];
+		}
+=09
+		// Perform a jQuery selector on the table nodes
+		var nodes =3D $.map( a, function (el, i) {
+			return el.nTable;
+		} );
+=09
+		return $(nodes)
+			.filter( selector )
+			.map( function (i) {
+				// Need to translate back from the table node to the settings
+				var idx =3D $.inArray( this, nodes );
+				return a[ idx ];
+			} )
+			.toArray();
+	};
+=09
+=09
+=09
+	/**
+	 * Context selector for the API's context (i.e. the tables the API instan=
ce
+	 * refers to.
+	 *
+	 * @name    DataTable.Api#tables
+	 * @param {string|integer} [selector] Selector to pick which tables the i=
terator
+	 *   should operate on. If not given, all tables in the current context a=
re
+	 *   used. This can be given as a jQuery selector (for example `':gt(0)'`=
) to
+	 *   select multiple tables or as an integer to select a single table.
+	 * @returns {DataTable.Api} Returns a new API instance if a selector is g=
iven.
+	 */
+	_api_register( 'tables()', function ( selector ) {
+		// A new instance is created if there was a selector specified
+		return selector !=3D=3D undefined && selector !=3D=3D null ?
+			new _Api( __table_selector( selector, this.context ) ) :
+			this;
+	} );
+=09
+=09
+	_api_register( 'table()', function ( selector ) {
+		var tables =3D this.tables( selector );
+		var ctx =3D tables.context;
+=09
+		// Truncate to the first matched table
+		return ctx.length ?
+			new _Api( ctx[0] ) :
+			tables;
+	} );
+=09
+=09
+	_api_registerPlural( 'tables().nodes()', 'table().node()' , function () {
+		return this.iterator( 'table', function ( ctx ) {
+			return ctx.nTable;
+		}, 1 );
+	} );
+=09
+=09
+	_api_registerPlural( 'tables().body()', 'table().body()' , function () {
+		return this.iterator( 'table', function ( ctx ) {
+			return ctx.nTBody;
+		}, 1 );
+	} );
+=09
+=09
+	_api_registerPlural( 'tables().header()', 'table().header()' , function (=
) {
+		return this.iterator( 'table', function ( ctx ) {
+			return ctx.nTHead;
+		}, 1 );
+	} );
+=09
+=09
+	_api_registerPlural( 'tables().footer()', 'table().footer()' , function (=
) {
+		return this.iterator( 'table', function ( ctx ) {
+			return ctx.nTFoot;
+		}, 1 );
+	} );
+=09
+=09
+	_api_registerPlural( 'tables().containers()', 'table().container()' , fun=
ction () {
+		return this.iterator( 'table', function ( ctx ) {
+			return ctx.nTableWrapper;
+		}, 1 );
+	} );
+=09
+=09
+=09
+	/**
+	 * Redraw the tables in the current context.
+	 */
+	_api_register( 'draw()', function ( paging ) {
+		return this.iterator( 'table', function ( settings ) {
+			if ( paging =3D=3D=3D 'page' ) {
+				_fnDraw( settings );
+			}
+			else {
+				if ( typeof paging =3D=3D=3D 'string' ) {
+					paging =3D paging =3D=3D=3D 'full-hold' ?
+						false :
+						true;
+				}
+=09
+				_fnReDraw( settings, paging=3D=3D=3Dfalse );
+			}
+		} );
+	} );
+=09
+=09
+=09
+	/**
+	 * Get the current page index.
+	 *
+	 * @return {integer} Current page index (zero based)
+	 *//**
+	 * Set the current page.
+	 *
+	 * Note that if you attempt to show a page which does not exist, DataTabl=
es will
+	 * not throw an error, but rather reset the paging.
+	 *
+	 * @param {integer|string} action The paging action to take. This can be =
one of:
+	 *  * `integer` - The page index to jump to
+	 *  * `string` - An action to take:
+	 *    * `first` - Jump to first page.
+	 *    * `next` - Jump to the next page
+	 *    * `previous` - Jump to previous page
+	 *    * `last` - Jump to the last page.
+	 * @returns {DataTables.Api} this
+	 */
+	_api_register( 'page()', function ( action ) {
+		if ( action =3D=3D=3D undefined ) {
+			return this.page.info().page; // not an expensive call
+		}
+=09
+		// else, have an action to take on all tables
+		return this.iterator( 'table', function ( settings ) {
+			_fnPageChange( settings, action );
+		} );
+	} );
+=09
+=09
+	/**
+	 * Paging information for the first table in the current context.
+	 *
+	 * If you require paging information for another table, use the `table()`=
 method
+	 * with a suitable selector.
+	 *
+	 * @return {object} Object with the following properties set:
+	 *  * `page` - Current page index (zero based - i.e. the first page is `0=
`)
+	 *  * `pages` - Total number of pages
+	 *  * `start` - Display index for the first record shown on the current p=
age
+	 *  * `end` - Display index for the last record shown on the current page
+	 *  * `length` - Display length (number of records). Note that generally =
`start
+	 *    + length =3D end`, but this is not always true, for example if ther=
e are
+	 *    only 2 records to show on the final page, with a length of 10.
+	 *  * `recordsTotal` - Full data set length
+	 *  * `recordsDisplay` - Data set length once the current filtering crite=
rion
+	 *    are applied.
+	 */
+	_api_register( 'page.info()', function ( action ) {
+		if ( this.context.length =3D=3D=3D 0 ) {
+			return undefined;
+		}
+=09
+		var
+			settings   =3D this.context[0],
+			start      =3D settings._iDisplayStart,
+			len        =3D settings.oFeatures.bPaginate ? settings._iDisplayLength =
: -1,
+			visRecords =3D settings.fnRecordsDisplay(),
+			all        =3D len =3D=3D=3D -1;
+=09
+		return {
+			"page":           all ? 0 : Math.floor( start / len ),
+			"pages":          all ? 1 : Math.ceil( visRecords / len ),
+			"start":          start,
+			"end":            settings.fnDisplayEnd(),
+			"length":         len,
+			"recordsTotal":   settings.fnRecordsTotal(),
+			"recordsDisplay": visRecords,
+			"serverSide":     _fnDataSource( settings ) =3D=3D=3D 'ssp'
+		};
+	} );
+=09
+=09
+	/**
+	 * Get the current page length.
+	 *
+	 * @return {integer} Current page length. Note `-1` indicates that all re=
cords
+	 *   are to be shown.
+	 *//**
+	 * Set the current page length.
+	 *
+	 * @param {integer} Page length to set. Use `-1` to show all records.
+	 * @returns {DataTables.Api} this
+	 */
+	_api_register( 'page.len()', function ( len ) {
+		// Note that we can't call this function 'length()' because `length`
+		// is a Javascript property of functions which defines how many arguments
+		// the function expects.
+		if ( len =3D=3D=3D undefined ) {
+			return this.context.length !=3D=3D 0 ?
+				this.context[0]._iDisplayLength :
+				undefined;
+		}
+=09
+		// else, set the page length
+		return this.iterator( 'table', function ( settings ) {
+			_fnLengthChange( settings, len );
+		} );
+	} );
+=09
+=09
+=09
+	var __reload =3D function ( settings, holdPosition, callback ) {
+		// Use the draw event to trigger a callback
+		if ( callback ) {
+			var api =3D new _Api( settings );
+=09
+			api.one( 'draw', function () {
+				callback( api.ajax.json() );
+			} );
+		}
+=09
+		if ( _fnDataSource( settings ) =3D=3D 'ssp' ) {
+			_fnReDraw( settings, holdPosition );
+		}
+		else {
+			_fnProcessingDisplay( settings, true );
+=09
+			// Cancel an existing request
+			var xhr =3D settings.jqXHR;
+			if ( xhr && xhr.readyState !=3D=3D 4 ) {
+				xhr.abort();
+			}
+=09
+			// Trigger xhr
+			_fnBuildAjax( settings, [], function( json ) {
+				_fnClearTable( settings );
+=09
+				var data =3D _fnAjaxDataSrc( settings, json );
+				for ( var i=3D0, ien=3Ddata.length ; i<ien ; i++ ) {
+					_fnAddData( settings, data[i] );
+				}
+=09
+				_fnReDraw( settings, holdPosition );
+				_fnProcessingDisplay( settings, false );
+			} );
+		}
+	};
+=09
+=09
+	/**
+	 * Get the JSON response from the last Ajax request that DataTables made =
to the
+	 * server. Note that this returns the JSON from the first table in the cu=
rrent
+	 * context.
+	 *
+	 * @return {object} JSON received from the server.
+	 */
+	_api_register( 'ajax.json()', function () {
+		var ctx =3D this.context;
+=09
+		if ( ctx.length > 0 ) {
+			return ctx[0].json;
+		}
+=09
+		// else return undefined;
+	} );
+=09
+=09
+	/**
+	 * Get the data submitted in the last Ajax request
+	 */
+	_api_register( 'ajax.params()', function () {
+		var ctx =3D this.context;
+=09
+		if ( ctx.length > 0 ) {
+			return ctx[0].oAjaxData;
+		}
+=09
+		// else return undefined;
+	} );
+=09
+=09
+	/**
+	 * Reload tables from the Ajax data source. Note that this function will
+	 * automatically re-draw the table when the remote data has been loaded.
+	 *
+	 * @param {boolean} [reset=3Dtrue] Reset (default) or hold the current pa=
ging
+	 *   position. A full re-sort and re-filter is performed when this method=
 is
+	 *   called, which is why the pagination reset is the default action.
+	 * @returns {DataTables.Api} this
+	 */
+	_api_register( 'ajax.reload()', function ( callback, resetPaging ) {
+		return this.iterator( 'table', function (settings) {
+			__reload( settings, resetPaging=3D=3D=3Dfalse, callback );
+		} );
+	} );
+=09
+=09
+	/**
+	 * Get the current Ajax URL. Note that this returns the URL from the first
+	 * table in the current context.
+	 *
+	 * @return {string} Current Ajax source URL
+	 *//**
+	 * Set the Ajax URL. Note that this will set the URL for all tables in the
+	 * current context.
+	 *
+	 * @param {string} url URL to set.
+	 * @returns {DataTables.Api} this
+	 */
+	_api_register( 'ajax.url()', function ( url ) {
+		var ctx =3D this.context;
+=09
+		if ( url =3D=3D=3D undefined ) {
+			// get
+			if ( ctx.length =3D=3D=3D 0 ) {
+				return undefined;
+			}
+			ctx =3D ctx[0];
+=09
+			return ctx.ajax ?
+				$.isPlainObject( ctx.ajax ) ?
+					ctx.ajax.url :
+					ctx.ajax :
+				ctx.sAjaxSource;
+		}
+=09
+		// set
+		return this.iterator( 'table', function ( settings ) {
+			if ( $.isPlainObject( settings.ajax ) ) {
+				settings.ajax.url =3D url;
+			}
+			else {
+				settings.ajax =3D url;
+			}
+			// No need to consider sAjaxSource here since DataTables gives priority
+			// to `ajax` over `sAjaxSource`. So setting `ajax` here, renders any
+			// value of `sAjaxSource` redundant.
+		} );
+	} );
+=09
+=09
+	/**
+	 * Load data from the newly set Ajax URL. Note that this method is only
+	 * available when `ajax.url()` is used to set a URL. Additionally, this m=
ethod
+	 * has the same effect as calling `ajax.reload()` but is provided for
+	 * convenience when setting a new URL. Like `ajax.reload()` it will
+	 * automatically redraw the table once the remote data has been loaded.
+	 *
+	 * @returns {DataTables.Api} this
+	 */
+	_api_register( 'ajax.url().load()', function ( callback, resetPaging ) {
+		// Same as a reload, but makes sense to present it for easy access after=
 a
+		// url change
+		return this.iterator( 'table', function ( ctx ) {
+			__reload( ctx, resetPaging=3D=3D=3Dfalse, callback );
+		} );
+	} );
+=09
+=09
+=09
+=09
+	var _selector_run =3D function ( type, selector, selectFn, settings, opts=
 )
+	{
+		var
+			out =3D [], res,
+			a, i, ien, j, jen,
+			selectorType =3D typeof selector;
+=09
+		// Can't just check for isArray here, as an API or jQuery instance might=
 be
+		// given with their array like look
+		if ( ! selector || selectorType =3D=3D=3D 'string' || selectorType =3D=
=3D=3D 'function' || selector.length =3D=3D=3D undefined ) {
+			selector =3D [ selector ];
+		}
+=09
+		for ( i=3D0, ien=3Dselector.length ; i<ien ; i++ ) {
+			// Only split on simple strings - complex expressions will be jQuery se=
lectors
+			a =3D selector[i] && selector[i].split && ! selector[i].match(/[\[\(:]/=
) ?
+				selector[i].split(',') :
+				[ selector[i] ];
+=09
+			for ( j=3D0, jen=3Da.length ; j<jen ; j++ ) {
+				res =3D selectFn( typeof a[j] =3D=3D=3D 'string' ? (a[j]).trim() : a[j=
] );
+=09
+				if ( res && res.length ) {
+					out =3D out.concat( res );
+				}
+			}
+		}
+=09
+		// selector extensions
+		var ext =3D _ext.selector[ type ];
+		if ( ext.length ) {
+			for ( i=3D0, ien=3Dext.length ; i<ien ; i++ ) {
+				out =3D ext[i]( settings, opts, out );
+			}
+		}
+=09
+		return _unique( out );
+	};
+=09
+=09
+	var _selector_opts =3D function ( opts )
+	{
+		if ( ! opts ) {
+			opts =3D {};
+		}
+=09
+		// Backwards compatibility for 1.9- which used the terminology filter ra=
ther
+		// than search
+		if ( opts.filter && opts.search =3D=3D=3D undefined ) {
+			opts.search =3D opts.filter;
+		}
+=09
+		return $.extend( {
+			search: 'none',
+			order: 'current',
+			page: 'all'
+		}, opts );
+	};
+=09
+=09
+	var _selector_first =3D function ( inst )
+	{
+		// Reduce the API instance to the first item found
+		for ( var i=3D0, ien=3Dinst.length ; i<ien ; i++ ) {
+			if ( inst[i].length > 0 ) {
+				// Assign the first element to the first item in the instance
+				// and truncate the instance and context
+				inst[0] =3D inst[i];
+				inst[0].length =3D 1;
+				inst.length =3D 1;
+				inst.context =3D [ inst.context[i] ];
+=09
+				return inst;
+			}
+		}
+=09
+		// Not found - return an empty instance
+		inst.length =3D 0;
+		return inst;
+	};
+=09
+=09
+	var _selector_row_indexes =3D function ( settings, opts )
+	{
+		var
+			i, ien, tmp, a=3D[],
+			displayFiltered =3D settings.aiDisplay,
+			displayMaster =3D settings.aiDisplayMaster;
+=09
+		var
+			search =3D opts.search,  // none, applied, removed
+			order  =3D opts.order,   // applied, current, index (original - compati=
bility with 1.9)
+			page   =3D opts.page;    // all, current
+=09
+		if ( _fnDataSource( settings ) =3D=3D 'ssp' ) {
+			// In server-side processing mode, most options are irrelevant since
+			// rows not shown don't exist and the index order is the applied order
+			// Removed is a special case - for consistency just return an empty
+			// array
+			return search =3D=3D=3D 'removed' ?
+				[] :
+				_range( 0, displayMaster.length );
+		}
+		else if ( page =3D=3D 'current' ) {
+			// Current page implies that order=3Dcurrent and filter=3Dapplied, sinc=
e it is
+			// fairly senseless otherwise, regardless of what order and search actu=
ally
+			// are
+			for ( i=3Dsettings._iDisplayStart, ien=3Dsettings.fnDisplayEnd() ; i<ie=
n ; i++ ) {
+				a.push( displayFiltered[i] );
+			}
+		}
+		else if ( order =3D=3D 'current' || order =3D=3D 'applied' ) {
+			if ( search =3D=3D 'none') {
+				a =3D displayMaster.slice();
+			}
+			else if ( search =3D=3D 'applied' ) {
+				a =3D displayFiltered.slice();
+			}
+			else if ( search =3D=3D 'removed' ) {
+				// O(n+m) solution by creating a hash map
+				var displayFilteredMap =3D {};
+=09
+				for ( var i=3D0, ien=3DdisplayFiltered.length ; i<ien ; i++ ) {
+					displayFilteredMap[displayFiltered[i]] =3D null;
+				}
+=09
+				a =3D $.map( displayMaster, function (el) {
+					return ! displayFilteredMap.hasOwnProperty(el) ?
+						el :
+						null;
+				} );
+			}
+		}
+		else if ( order =3D=3D 'index' || order =3D=3D 'original' ) {
+			for ( i=3D0, ien=3Dsettings.aoData.length ; i<ien ; i++ ) {
+				if ( search =3D=3D 'none' ) {
+					a.push( i );
+				}
+				else { // applied | removed
+					tmp =3D $.inArray( i, displayFiltered );
+=09
+					if ((tmp =3D=3D=3D -1 && search =3D=3D 'removed') ||
+						(tmp >=3D 0   && search =3D=3D 'applied') )
+					{
+						a.push( i );
+					}
+				}
+			}
+		}
+=09
+		return a;
+	};
+=09
+=09
+	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * =
* * *
+	 * Rows
+	 *
+	 * {}          - no selector - use all available rows
+	 * {integer}   - row aoData index
+	 * {node}      - TR node
+	 * {string}    - jQuery selector to apply to the TR elements
+	 * {array}     - jQuery array of nodes, or simply an array of TR nodes
+	 *
+	 */
+	var __row_selector =3D function ( settings, selector, opts )
+	{
+		var rows;
+		var run =3D function ( sel ) {
+			var selInt =3D _intVal( sel );
+			var i, ien;
+			var aoData =3D settings.aoData;
+=09
+			// Short cut - selector is a number and no options provided (default is
+			// all records, so no need to check if the index is in there, since it
+			// must be - dev error if the index doesn't exist).
+			if ( selInt !=3D=3D null && ! opts ) {
+				return [ selInt ];
+			}
+=09
+			if ( ! rows ) {
+				rows =3D _selector_row_indexes( settings, opts );
+			}
+=09
+			if ( selInt !=3D=3D null && $.inArray( selInt, rows ) !=3D=3D -1 ) {
+				// Selector - integer
+				return [ selInt ];
+			}
+			else if ( sel =3D=3D=3D null || sel =3D=3D=3D undefined || sel =3D=3D=
=3D '' ) {
+				// Selector - none
+				return rows;
+			}
+=09
+			// Selector - function
+			if ( typeof sel =3D=3D=3D 'function' ) {
+				return $.map( rows, function (idx) {
+					var row =3D aoData[ idx ];
+					return sel( idx, row._aData, row.nTr ) ? idx : null;
+				} );
+			}
+=09
+			// Selector - node
+			if ( sel.nodeName ) {
+				var rowIdx =3D sel._DT_RowIndex;  // Property added by DT for fast loo=
kup
+				var cellIdx =3D sel._DT_CellIndex;
+=09
+				if ( rowIdx !=3D=3D undefined ) {
+					// Make sure that the row is actually still present in the table
+					return aoData[ rowIdx ] && aoData[ rowIdx ].nTr =3D=3D=3D sel ?
+						[ rowIdx ] :
+						[];
+				}
+				else if ( cellIdx ) {
+					return aoData[ cellIdx.row ] && aoData[ cellIdx.row ].nTr =3D=3D=3D s=
el.parentNode ?
+						[ cellIdx.row ] :
+						[];
+				}
+				else {
+					var host =3D $(sel).closest('*[data-dt-row]');
+					return host.length ?
+						[ host.data('dt-row') ] :
+						[];
+				}
+			}
+=09
+			// ID selector. Want to always be able to select rows by id, regardless
+			// of if the tr element has been created or not, so can't rely upon
+			// jQuery here - hence a custom implementation. This does not match
+			// Sizzle's fast selector or HTML4 - in HTML5 the ID can be anything,
+			// but to select it using a CSS selector engine (like Sizzle or
+			// querySelect) it would need to need to be escaped for some characters.
+			// DataTables simplifies this for row selectors since you can select
+			// only a row. A # indicates an id any anything that follows is the id -
+			// unescaped.
+			if ( typeof sel =3D=3D=3D 'string' && sel.charAt(0) =3D=3D=3D '#' ) {
+				// get row index from id
+				var rowObj =3D settings.aIds[ sel.replace( /^#/, '' ) ];
+				if ( rowObj !=3D=3D undefined ) {
+					return [ rowObj.idx ];
+				}
+=09
+				// need to fall through to jQuery in case there is DOM id that
+				// matches
+			}
+=09=09=09
+			// Get nodes in the order from the `rows` array with null values removed
+			var nodes =3D _removeEmpty(
+				_pluck_order( settings.aoData, rows, 'nTr' )
+			);
+=09
+			// Selector - jQuery selector string, array of nodes or jQuery object/
+			// As jQuery's .filter() allows jQuery objects to be passed in filter,
+			// it also allows arrays, so this will cope with all three options
+			return $(nodes)
+				.filter( sel )
+				.map( function () {
+					return this._DT_RowIndex;
+				} )
+				.toArray();
+		};
+=09
+		return _selector_run( 'row', selector, run, settings, opts );
+	};
+=09
+=09
+	_api_register( 'rows()', function ( selector, opts ) {
+		// argument shifting
+		if ( selector =3D=3D=3D undefined ) {
+			selector =3D '';
+		}
+		else if ( $.isPlainObject( selector ) ) {
+			opts =3D selector;
+			selector =3D '';
+		}
+=09
+		opts =3D _selector_opts( opts );
+=09
+		var inst =3D this.iterator( 'table', function ( settings ) {
+			return __row_selector( settings, selector, opts );
+		}, 1 );
+=09
+		// Want argument shifting here and in __row_selector?
+		inst.selector.rows =3D selector;
+		inst.selector.opts =3D opts;
+=09
+		return inst;
+	} );
+=09
+	_api_register( 'rows().nodes()', function () {
+		return this.iterator( 'row', function ( settings, row ) {
+			return settings.aoData[ row ].nTr || undefined;
+		}, 1 );
+	} );
+=09
+	_api_register( 'rows().data()', function () {
+		return this.iterator( true, 'rows', function ( settings, rows ) {
+			return _pluck_order( settings.aoData, rows, '_aData' );
+		}, 1 );
+	} );
+=09
+	_api_registerPlural( 'rows().cache()', 'row().cache()', function ( type )=
 {
+		return this.iterator( 'row', function ( settings, row ) {
+			var r =3D settings.aoData[ row ];
+			return type =3D=3D=3D 'search' ? r._aFilterData : r._aSortData;
+		}, 1 );
+	} );
+=09
+	_api_registerPlural( 'rows().invalidate()', 'row().invalidate()', functio=
n ( src ) {
+		return this.iterator( 'row', function ( settings, row ) {
+			_fnInvalidate( settings, row, src );
+		} );
+	} );
+=09
+	_api_registerPlural( 'rows().indexes()', 'row().index()', function () {
+		return this.iterator( 'row', function ( settings, row ) {
+			return row;
+		}, 1 );
+	} );
+=09
+	_api_registerPlural( 'rows().ids()', 'row().id()', function ( hash ) {
+		var a =3D [];
+		var context =3D this.context;
+=09
+		// `iterator` will drop undefined values, but in this case we want them
+		for ( var i=3D0, ien=3Dcontext.length ; i<ien ; i++ ) {
+			for ( var j=3D0, jen=3Dthis[i].length ; j<jen ; j++ ) {
+				var id =3D context[i].rowIdFn( context[i].aoData[ this[i][j] ]._aData =
);
+				a.push( (hash =3D=3D=3D true ? '#' : '' )+ id );
+			}
+		}
+=09
+		return new _Api( context, a );
+	} );
+=09
+	_api_registerPlural( 'rows().remove()', 'row().remove()', function () {
+		var that =3D this;
+=09
+		this.iterator( 'row', function ( settings, row, thatIdx ) {
+			var data =3D settings.aoData;
+			var rowData =3D data[ row ];
+			var i, ien, j, jen;
+			var loopRow, loopCells;
+=09
+			data.splice( row, 1 );
+=09
+			// Update the cached indexes
+			for ( i=3D0, ien=3Ddata.length ; i<ien ; i++ ) {
+				loopRow =3D data[i];
+				loopCells =3D loopRow.anCells;
+=09
+				// Rows
+				if ( loopRow.nTr !=3D=3D null ) {
+					loopRow.nTr._DT_RowIndex =3D i;
+				}
+=09
+				// Cells
+				if ( loopCells !=3D=3D null ) {
+					for ( j=3D0, jen=3DloopCells.length ; j<jen ; j++ ) {
+						loopCells[j]._DT_CellIndex.row =3D i;
+					}
+				}
+			}
+=09
+			// Delete from the display arrays
+			_fnDeleteIndex( settings.aiDisplayMaster, row );
+			_fnDeleteIndex( settings.aiDisplay, row );
+			_fnDeleteIndex( that[ thatIdx ], row, false ); // maintain local indexes
+=09
+			// For server-side processing tables - subtract the deleted row from th=
e count
+			if ( settings._iRecordsDisplay > 0 ) {
+				settings._iRecordsDisplay--;
+			}
+=09
+			// Check for an 'overflow' they case for displaying the table
+			_fnLengthOverflow( settings );
+=09
+			// Remove the row's ID reference if there is one
+			var id =3D settings.rowIdFn( rowData._aData );
+			if ( id !=3D=3D undefined ) {
+				delete settings.aIds[ id ];
+			}
+		} );
+=09
+		this.iterator( 'table', function ( settings ) {
+			for ( var i=3D0, ien=3Dsettings.aoData.length ; i<ien ; i++ ) {
+				settings.aoData[i].idx =3D i;
+			}
+		} );
+=09
+		return this;
+	} );
+=09
+=09
+	_api_register( 'rows.add()', function ( rows ) {
+		var newRows =3D this.iterator( 'table', function ( settings ) {
+				var row, i, ien;
+				var out =3D [];
+=09
+				for ( i=3D0, ien=3Drows.length ; i<ien ; i++ ) {
+					row =3D rows[i];
+=09
+					if ( row.nodeName && row.nodeName.toUpperCase() =3D=3D=3D 'TR' ) {
+						out.push( _fnAddTr( settings, row )[0] );
+					}
+					else {
+						out.push( _fnAddData( settings, row ) );
+					}
+				}
+=09
+				return out;
+			}, 1 );
+=09
+		// Return an Api.rows() extended instance, so rows().nodes() etc can be =
used
+		var modRows =3D this.rows( -1 );
+		modRows.pop();
+		$.merge( modRows, newRows );
+=09
+		return modRows;
+	} );
+=09
+=09
+=09
+=09
+=09
+	/**
+	 *
+	 */
+	_api_register( 'row()', function ( selector, opts ) {
+		return _selector_first( this.rows( selector, opts ) );
+	} );
+=09
+=09
+	_api_register( 'row().data()', function ( data ) {
+		var ctx =3D this.context;
+=09
+		if ( data =3D=3D=3D undefined ) {
+			// Get
+			return ctx.length && this.length ?
+				ctx[0].aoData[ this[0] ]._aData :
+				undefined;
+		}
+=09
+		// Set
+		var row =3D ctx[0].aoData[ this[0] ];
+		row._aData =3D data;
+=09
+		// If the DOM has an id, and the data source is an array
+		if ( Array.isArray( data ) && row.nTr && row.nTr.id ) {
+			_fnSetObjectDataFn( ctx[0].rowId )( data, row.nTr.id );
+		}
+=09
+		// Automatically invalidate
+		_fnInvalidate( ctx[0], this[0], 'data' );
+=09
+		return this;
+	} );
+=09
+=09
+	_api_register( 'row().node()', function () {
+		var ctx =3D this.context;
+=09
+		return ctx.length && this.length ?
+			ctx[0].aoData[ this[0] ].nTr || null :
+			null;
+	} );
+=09
+=09
+	_api_register( 'row.add()', function ( row ) {
+		// Allow a jQuery object to be passed in - only a single row is added fr=
om
+		// it though - the first element in the set
+		if ( row instanceof $ && row.length ) {
+			row =3D row[0];
+		}
+=09
+		var rows =3D this.iterator( 'table', function ( settings ) {
+			if ( row.nodeName && row.nodeName.toUpperCase() =3D=3D=3D 'TR' ) {
+				return _fnAddTr( settings, row )[0];
+			}
+			return _fnAddData( settings, row );
+		} );
+=09
+		// Return an Api.rows() extended instance, with the newly added row sele=
cted
+		return this.row( rows[0] );
+	} );
+=09
+=09
+	$(document).on('plugin-init.dt', function (e, context) {
+		var api =3D new _Api( context );
+=09
+		api.on( 'stateSaveParams', function ( e, settings, d ) {
+			// This could be more compact with the API, but it is a lot faster as a=
 simple
+			// internal loop
+			var idFn =3D settings.rowIdFn;
+			var data =3D settings.aoData;
+			var ids =3D [];
+=09
+			for (var i=3D0 ; i<data.length ; i++) {
+				if (data[i]._detailsShow) {
+					ids.push( '#' + idFn(data[i]._aData) );
+				}
+			}
+=09
+			d.childRows =3D ids;
+		})
+=09
+		var loaded =3D api.state.loaded();
+=09
+		if ( loaded && loaded.childRows ) {
+			api
+				.rows( $.map(loaded.childRows, function (id){
+					return id.replace(/:/g, '\\:')
+				}) )
+				.every( function () {
+					_fnCallbackFire( context, null, 'requestChild', [ this ] )
+				});
+		}
+	});
+=09
+	var __details_add =3D function ( ctx, row, data, klass )
+	{
+		// Convert to array of TR elements
+		var rows =3D [];
+		var addRow =3D function ( r, k ) {
+			// Recursion to allow for arrays of jQuery objects
+			if ( Array.isArray( r ) || r instanceof $ ) {
+				for ( var i=3D0, ien=3Dr.length ; i<ien ; i++ ) {
+					addRow( r[i], k );
+				}
+				return;
+			}
+=09
+			// If we get a TR element, then just add it directly - up to the dev
+			// to add the correct number of columns etc
+			if ( r.nodeName && r.nodeName.toLowerCase() =3D=3D=3D 'tr' ) {
+				rows.push( r );
+			}
+			else {
+				// Otherwise create a row with a wrapper
+				var created =3D $('<tr><td></td></tr>').addClass( k );
+				$('td', created)
+					.addClass( k )
+					.html( r )
+					[0].colSpan =3D _fnVisbleColumns( ctx );
+=09
+				rows.push( created[0] );
+			}
+		};
+=09
+		addRow( data, klass );
+=09
+		if ( row._details ) {
+			row._details.detach();
+		}
+=09
+		row._details =3D $(rows);
+=09
+		// If the children were already shown, that state should be retained
+		if ( row._detailsShow ) {
+			row._details.insertAfter( row.nTr );
+		}
+	};
+=09
+=09
+	// Make state saving of child row details async to allow them to be batch=
 processed
+	var __details_state =3D DataTable.util.throttle(
+		function (ctx) {
+			_fnSaveState( ctx[0] )
+		},
+		500
+	);
+=09
+=09
+	var __details_remove =3D function ( api, idx )
+	{
+		var ctx =3D api.context;
+=09
+		if ( ctx.length ) {
+			var row =3D ctx[0].aoData[ idx !=3D=3D undefined ? idx : api[0] ];
+=09
+			if ( row && row._details ) {
+				row._details.remove();
+=09
+				row._detailsShow =3D undefined;
+				row._details =3D undefined;
+				$( row.nTr ).removeClass( 'dt-hasChild' );
+				__details_state( ctx );
+			}
+		}
+	};
+=09
+=09
+	var __details_display =3D function ( api, show ) {
+		var ctx =3D api.context;
+=09
+		if ( ctx.length && api.length ) {
+			var row =3D ctx[0].aoData[ api[0] ];
+=09
+			if ( row._details ) {
+				row._detailsShow =3D show;
+=09
+				if ( show ) {
+					row._details.insertAfter( row.nTr );
+					$( row.nTr ).addClass( 'dt-hasChild' );
+				}
+				else {
+					row._details.detach();
+					$( row.nTr ).removeClass( 'dt-hasChild' );
+				}
+=09
+				_fnCallbackFire( ctx[0], null, 'childRow', [ show, api.row( api[0] ) ]=
 )
+=09
+				__details_events( ctx[0] );
+				__details_state( ctx );
+			}
+		}
+	};
+=09
+=09
+	var __details_events =3D function ( settings )
+	{
+		var api =3D new _Api( settings );
+		var namespace =3D '.dt.DT_details';
+		var drawEvent =3D 'draw'+namespace;
+		var colvisEvent =3D 'column-visibility'+namespace;
+		var destroyEvent =3D 'destroy'+namespace;
+		var data =3D settings.aoData;
+=09
+		api.off( drawEvent +' '+ colvisEvent +' '+ destroyEvent );
+=09
+		if ( _pluck( data, '_details' ).length > 0 ) {
+			// On each draw, insert the required elements into the document
+			api.on( drawEvent, function ( e, ctx ) {
+				if ( settings !=3D=3D ctx ) {
+					return;
+				}
+=09
+				api.rows( {page:'current'} ).eq(0).each( function (idx) {
+					// Internal data grab
+					var row =3D data[ idx ];
+=09
+					if ( row._detailsShow ) {
+						row._details.insertAfter( row.nTr );
+					}
+				} );
+			} );
+=09
+			// Column visibility change - update the colspan
+			api.on( colvisEvent, function ( e, ctx, idx, vis ) {
+				if ( settings !=3D=3D ctx ) {
+					return;
+				}
+=09
+				// Update the colspan for the details rows (note, only if it already h=
as
+				// a colspan)
+				var row, visible =3D _fnVisbleColumns( ctx );
+=09
+				for ( var i=3D0, ien=3Ddata.length ; i<ien ; i++ ) {
+					row =3D data[i];
+=09
+					if ( row._details ) {
+						row._details.children('td[colspan]').attr('colspan', visible );
+					}
+				}
+			} );
+=09
+			// Table destroyed - nuke any child rows
+			api.on( destroyEvent, function ( e, ctx ) {
+				if ( settings !=3D=3D ctx ) {
+					return;
+				}
+=09
+				for ( var i=3D0, ien=3Ddata.length ; i<ien ; i++ ) {
+					if ( data[i]._details ) {
+						__details_remove( api, i );
+					}
+				}
+			} );
+		}
+	};
+=09
+	// Strings for the method names to help minification
+	var _emp =3D '';
+	var _child_obj =3D _emp+'row().child';
+	var _child_mth =3D _child_obj+'()';
+=09
+	// data can be:
+	//  tr
+	//  string
+	//  jQuery or array of any of the above
+	_api_register( _child_mth, function ( data, klass ) {
+		var ctx =3D this.context;
+=09
+		if ( data =3D=3D=3D undefined ) {
+			// get
+			return ctx.length && this.length ?
+				ctx[0].aoData[ this[0] ]._details :
+				undefined;
+		}
+		else if ( data =3D=3D=3D true ) {
+			// show
+			this.child.show();
+		}
+		else if ( data =3D=3D=3D false ) {
+			// remove
+			__details_remove( this );
+		}
+		else if ( ctx.length && this.length ) {
+			// set
+			__details_add( ctx[0], ctx[0].aoData[ this[0] ], data, klass );
+		}
+=09
+		return this;
+	} );
+=09
+=09
+	_api_register( [
+		_child_obj+'.show()',
+		_child_mth+'.show()' // only when `child()` was called with parameters (=
without
+	], function ( show ) {   // it returns an object and this method is not e=
xecuted)
+		__details_display( this, true );
+		return this;
+	} );
+=09
+=09
+	_api_register( [
+		_child_obj+'.hide()',
+		_child_mth+'.hide()' // only when `child()` was called with parameters (=
without
+	], function () {         // it returns an object and this method is not e=
xecuted)
+		__details_display( this, false );
+		return this;
+	} );
+=09
+=09
+	_api_register( [
+		_child_obj+'.remove()',
+		_child_mth+'.remove()' // only when `child()` was called with parameters=
 (without
+	], function () {           // it returns an object and this method is not=
 executed)
+		__details_remove( this );
+		return this;
+	} );
+=09
+=09
+	_api_register( _child_obj+'.isShown()', function () {
+		var ctx =3D this.context;
+=09
+		if ( ctx.length && this.length ) {
+			// _detailsShown as false or undefined will fall through to return false
+			return ctx[0].aoData[ this[0] ]._detailsShow || false;
+		}
+		return false;
+	} );
+=09
+=09
+=09
+	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * =
* * *
+	 * Columns
+	 *
+	 * {integer}           - column index (>=3D0 count from left, <0 count fr=
om right)
+	 * "{integer}:visIdx"  - visible column index (i.e. translate to column i=
ndex)  (>=3D0 count from left, <0 count from right)
+	 * "{integer}:visible" - alias for {integer}:visIdx  (>=3D0 count from le=
ft, <0 count from right)
+	 * "{string}:name"     - column name
+	 * "{string}"          - jQuery selector on column header nodes
+	 *
+	 */
+=09
+	// can be an array of these items, comma separated list, or an array of c=
omma
+	// separated lists
+=09
+	var __re_column_selector =3D /^([^:]+):(name|visIdx|visible)$/;
+=09
+=09
+	// r1 and r2 are redundant - but it means that the parameters match for t=
he
+	// iterator callback in columns().data()
+	var __columnData =3D function ( settings, column, r1, r2, rows ) {
+		var a =3D [];
+		for ( var row=3D0, ien=3Drows.length ; row<ien ; row++ ) {
+			a.push( _fnGetCellData( settings, rows[row], column ) );
+		}
+		return a;
+	};
+=09
+=09
+	var __column_selector =3D function ( settings, selector, opts )
+	{
+		var
+			columns =3D settings.aoColumns,
+			names =3D _pluck( columns, 'sName' ),
+			nodes =3D _pluck( columns, 'nTh' );
+=09
+		var run =3D function ( s ) {
+			var selInt =3D _intVal( s );
+=09
+			// Selector - all
+			if ( s =3D=3D=3D '' ) {
+				return _range( columns.length );
+			}
+=09
+			// Selector - index
+			if ( selInt !=3D=3D null ) {
+				return [ selInt >=3D 0 ?
+					selInt : // Count from left
+					columns.length + selInt // Count from right (+ because its a negative=
 value)
+				];
+			}
+=09
+			// Selector =3D function
+			if ( typeof s =3D=3D=3D 'function' ) {
+				var rows =3D _selector_row_indexes( settings, opts );
+=09
+				return $.map( columns, function (col, idx) {
+					return s(
+							idx,
+							__columnData( settings, idx, 0, 0, rows ),
+							nodes[ idx ]
+						) ? idx : null;
+				} );
+			}
+=09
+			// jQuery or string selector
+			var match =3D typeof s =3D=3D=3D 'string' ?
+				s.match( __re_column_selector ) :
+				'';
+=09
+			if ( match ) {
+				switch( match[2] ) {
+					case 'visIdx':
+					case 'visible':
+						var idx =3D parseInt( match[1], 10 );
+						// Visible index given, convert to column index
+						if ( idx < 0 ) {
+							// Counting from the right
+							var visColumns =3D $.map( columns, function (col,i) {
+								return col.bVisible ? i : null;
+							} );
+							return [ visColumns[ visColumns.length + idx ] ];
+						}
+						// Counting from the left
+						return [ _fnVisibleToColumnIndex( settings, idx ) ];
+=09
+					case 'name':
+						// match by name. `names` is column index complete and in order
+						return $.map( names, function (name, i) {
+							return name =3D=3D=3D match[1] ? i : null;
+						} );
+=09
+					default:
+						return [];
+				}
+			}
+=09
+			// Cell in the table body
+			if ( s.nodeName && s._DT_CellIndex ) {
+				return [ s._DT_CellIndex.column ];
+			}
+=09
+			// jQuery selector on the TH elements for the columns
+			var jqResult =3D $( nodes )
+				.filter( s )
+				.map( function () {
+					return $.inArray( this, nodes ); // `nodes` is column index complete =
and in order
+				} )
+				.toArray();
+=09
+			if ( jqResult.length || ! s.nodeName ) {
+				return jqResult;
+			}
+=09
+			// Otherwise a node which might have a `dt-column` data attribute, or be
+			// a child or such an element
+			var host =3D $(s).closest('*[data-dt-column]');
+			return host.length ?
+				[ host.data('dt-column') ] :
+				[];
+		};
+=09
+		return _selector_run( 'column', selector, run, settings, opts );
+	};
+=09
+=09
+	var __setColumnVis =3D function ( settings, column, vis ) {
+		var
+			cols =3D settings.aoColumns,
+			col  =3D cols[ column ],
+			data =3D settings.aoData,
+			row, cells, i, ien, tr;
+=09
+		// Get
+		if ( vis =3D=3D=3D undefined ) {
+			return col.bVisible;
+		}
+=09
+		// Set
+		// No change
+		if ( col.bVisible =3D=3D=3D vis ) {
+			return;
+		}
+=09
+		if ( vis ) {
+			// Insert column
+			// Need to decide if we should use appendChild or insertBefore
+			var insertBefore =3D $.inArray( true, _pluck(cols, 'bVisible'), column+=
1 );
+=09
+			for ( i=3D0, ien=3Ddata.length ; i<ien ; i++ ) {
+				tr =3D data[i].nTr;
+				cells =3D data[i].anCells;
+=09
+				if ( tr ) {
+					// insertBefore can act like appendChild if 2nd arg is null
+					tr.insertBefore( cells[ column ], cells[ insertBefore ] || null );
+				}
+			}
+		}
+		else {
+			// Remove column
+			$( _pluck( settings.aoData, 'anCells', column ) ).detach();
+		}
+=09
+		// Common actions
+		col.bVisible =3D vis;
+	};
+=09
+=09
+	_api_register( 'columns()', function ( selector, opts ) {
+		// argument shifting
+		if ( selector =3D=3D=3D undefined ) {
+			selector =3D '';
+		}
+		else if ( $.isPlainObject( selector ) ) {
+			opts =3D selector;
+			selector =3D '';
+		}
+=09
+		opts =3D _selector_opts( opts );
+=09
+		var inst =3D this.iterator( 'table', function ( settings ) {
+			return __column_selector( settings, selector, opts );
+		}, 1 );
+=09
+		// Want argument shifting here and in _row_selector?
+		inst.selector.cols =3D selector;
+		inst.selector.opts =3D opts;
+=09
+		return inst;
+	} );
+=09
+	_api_registerPlural( 'columns().header()', 'column().header()', function =
( selector, opts ) {
+		return this.iterator( 'column', function ( settings, column ) {
+			return settings.aoColumns[column].nTh;
+		}, 1 );
+	} );
+=09
+	_api_registerPlural( 'columns().footer()', 'column().footer()', function =
( selector, opts ) {
+		return this.iterator( 'column', function ( settings, column ) {
+			return settings.aoColumns[column].nTf;
+		}, 1 );
+	} );
+=09
+	_api_registerPlural( 'columns().data()', 'column().data()', function () {
+		return this.iterator( 'column-rows', __columnData, 1 );
+	} );
+=09
+	_api_registerPlural( 'columns().dataSrc()', 'column().dataSrc()', functio=
n () {
+		return this.iterator( 'column', function ( settings, column ) {
+			return settings.aoColumns[column].mData;
+		}, 1 );
+	} );
+=09
+	_api_registerPlural( 'columns().cache()', 'column().cache()', function ( =
type ) {
+		return this.iterator( 'column-rows', function ( settings, column, i, j, =
rows ) {
+			return _pluck_order( settings.aoData, rows,
+				type =3D=3D=3D 'search' ? '_aFilterData' : '_aSortData', column
+			);
+		}, 1 );
+	} );
+=09
+	_api_registerPlural( 'columns().nodes()', 'column().nodes()', function ()=
 {
+		return this.iterator( 'column-rows', function ( settings, column, i, j, =
rows ) {
+			return _pluck_order( settings.aoData, rows, 'anCells', column ) ;
+		}, 1 );
+	} );
+=09
+	_api_registerPlural( 'columns().visible()', 'column().visible()', functio=
n ( vis, calc ) {
+		var that =3D this;
+		var ret =3D this.iterator( 'column', function ( settings, column ) {
+			if ( vis =3D=3D=3D undefined ) {
+				return settings.aoColumns[ column ].bVisible;
+			} // else
+			__setColumnVis( settings, column, vis );
+		} );
+=09
+		// Group the column visibility changes
+		if ( vis !=3D=3D undefined ) {
+			this.iterator( 'table', function ( settings ) {
+				// Redraw the header after changes
+				_fnDrawHead( settings, settings.aoHeader );
+				_fnDrawHead( settings, settings.aoFooter );
+=09=09
+				// Update colspan for no records display. Child rows and extensions wi=
ll use their own
+				// listeners to do this - only need to update the empty table item here
+				if ( ! settings.aiDisplay.length ) {
+					$(settings.nTBody).find('td[colspan]').attr('colspan', _fnVisbleColum=
ns(settings));
+				}
+=09=09
+				_fnSaveState( settings );
+=09
+				// Second loop once the first is done for events
+				that.iterator( 'column', function ( settings, column ) {
+					_fnCallbackFire( settings, null, 'column-visibility', [settings, colu=
mn, vis, calc] );
+				} );
+=09
+				if ( calc =3D=3D=3D undefined || calc ) {
+					that.columns.adjust();
+				}
+			});
+		}
+=09
+		return ret;
+	} );
+=09
+	_api_registerPlural( 'columns().indexes()', 'column().index()', function =
( type ) {
+		return this.iterator( 'column', function ( settings, column ) {
+			return type =3D=3D=3D 'visible' ?
+				_fnColumnIndexToVisible( settings, column ) :
+				column;
+		}, 1 );
+	} );
+=09
+	_api_register( 'columns.adjust()', function () {
+		return this.iterator( 'table', function ( settings ) {
+			_fnAdjustColumnSizing( settings );
+		}, 1 );
+	} );
+=09
+	_api_register( 'column.index()', function ( type, idx ) {
+		if ( this.context.length !=3D=3D 0 ) {
+			var ctx =3D this.context[0];
+=09
+			if ( type =3D=3D=3D 'fromVisible' || type =3D=3D=3D 'toData' ) {
+				return _fnVisibleToColumnIndex( ctx, idx );
+			}
+			else if ( type =3D=3D=3D 'fromData' || type =3D=3D=3D 'toVisible' ) {
+				return _fnColumnIndexToVisible( ctx, idx );
+			}
+		}
+	} );
+=09
+	_api_register( 'column()', function ( selector, opts ) {
+		return _selector_first( this.columns( selector, opts ) );
+	} );
+=09
+	var __cell_selector =3D function ( settings, selector, opts )
+	{
+		var data =3D settings.aoData;
+		var rows =3D _selector_row_indexes( settings, opts );
+		var cells =3D _removeEmpty( _pluck_order( data, rows, 'anCells' ) );
+		var allCells =3D $(_flatten( [], cells ));
+		var row;
+		var columns =3D settings.aoColumns.length;
+		var a, i, ien, j, o, host;
+=09
+		var run =3D function ( s ) {
+			var fnSelector =3D typeof s =3D=3D=3D 'function';
+=09
+			if ( s =3D=3D=3D null || s =3D=3D=3D undefined || fnSelector ) {
+				// All cells and function selectors
+				a =3D [];
+=09
+				for ( i=3D0, ien=3Drows.length ; i<ien ; i++ ) {
+					row =3D rows[i];
+=09
+					for ( j=3D0 ; j<columns ; j++ ) {
+						o =3D {
+							row: row,
+							column: j
+						};
+=09
+						if ( fnSelector ) {
+							// Selector - function
+							host =3D data[ row ];
+=09
+							if ( s( o, _fnGetCellData(settings, row, j), host.anCells ? host.an=
Cells[j] : null ) ) {
+								a.push( o );
+							}
+						}
+						else {
+							// Selector - all
+							a.push( o );
+						}
+					}
+				}
+=09
+				return a;
+			}
+=09=09=09
+			// Selector - index
+			if ( $.isPlainObject( s ) ) {
+				// Valid cell index and its in the array of selectable rows
+				return s.column !=3D=3D undefined && s.row !=3D=3D undefined && $.inAr=
ray( s.row, rows ) !=3D=3D -1 ?
+					[s] :
+					[];
+			}
+=09
+			// Selector - jQuery filtered cells
+			var jqResult =3D allCells
+				.filter( s )
+				.map( function (i, el) {
+					return { // use a new object, in case someone changes the values
+						row:    el._DT_CellIndex.row,
+						column: el._DT_CellIndex.column
+	 				};
+				} )
+				.toArray();
+=09
+			if ( jqResult.length || ! s.nodeName ) {
+				return jqResult;
+			}
+=09
+			// Otherwise the selector is a node, and there is one last option - the
+			// element might be a child of an element which has dt-row and dt-column
+			// data attributes
+			host =3D $(s).closest('*[data-dt-row]');
+			return host.length ?
+				[ {
+					row: host.data('dt-row'),
+					column: host.data('dt-column')
+				} ] :
+				[];
+		};
+=09
+		return _selector_run( 'cell', selector, run, settings, opts );
+	};
+=09
+=09
+=09
+=09
+	_api_register( 'cells()', function ( rowSelector, columnSelector, opts ) {
+		// Argument shifting
+		if ( $.isPlainObject( rowSelector ) ) {
+			// Indexes
+			if ( rowSelector.row =3D=3D=3D undefined ) {
+				// Selector options in first parameter
+				opts =3D rowSelector;
+				rowSelector =3D null;
+			}
+			else {
+				// Cell index objects in first parameter
+				opts =3D columnSelector;
+				columnSelector =3D null;
+			}
+		}
+		if ( $.isPlainObject( columnSelector ) ) {
+			opts =3D columnSelector;
+			columnSelector =3D null;
+		}
+=09
+		// Cell selector
+		if ( columnSelector =3D=3D=3D null || columnSelector =3D=3D=3D undefined=
 ) {
+			return this.iterator( 'table', function ( settings ) {
+				return __cell_selector( settings, rowSelector, _selector_opts( opts ) =
);
+			} );
+		}
+=09
+		// The default built in options need to apply to row and columns
+		var internalOpts =3D opts ? {
+			page: opts.page,
+			order: opts.order,
+			search: opts.search
+		} : {};
+=09
+		// Row + column selector
+		var columns =3D this.columns( columnSelector, internalOpts );
+		var rows =3D this.rows( rowSelector, internalOpts );
+		var i, ien, j, jen;
+=09
+		var cellsNoOpts =3D this.iterator( 'table', function ( settings, idx ) {
+			var a =3D [];
+=09
+			for ( i=3D0, ien=3Drows[idx].length ; i<ien ; i++ ) {
+				for ( j=3D0, jen=3Dcolumns[idx].length ; j<jen ; j++ ) {
+					a.push( {
+						row:    rows[idx][i],
+						column: columns[idx][j]
+					} );
+				}
+			}
+=09
+			return a;
+		}, 1 );
+=09
+		// There is currently only one extension which uses a cell selector exte=
nsion
+		// It is a _major_ performance drag to run this if it isn't needed, so t=
his is
+		// an extension specific check at the moment
+		var cells =3D opts && opts.selected ?
+			this.cells( cellsNoOpts, opts ) :
+			cellsNoOpts;
+=09
+		$.extend( cells.selector, {
+			cols: columnSelector,
+			rows: rowSelector,
+			opts: opts
+		} );
+=09
+		return cells;
+	} );
+=09
+=09
+	_api_registerPlural( 'cells().nodes()', 'cell().node()', function () {
+		return this.iterator( 'cell', function ( settings, row, column ) {
+			var data =3D settings.aoData[ row ];
+=09
+			return data && data.anCells ?
+				data.anCells[ column ] :
+				undefined;
+		}, 1 );
+	} );
+=09
+=09
+	_api_register( 'cells().data()', function () {
+		return this.iterator( 'cell', function ( settings, row, column ) {
+			return _fnGetCellData( settings, row, column );
+		}, 1 );
+	} );
+=09
+=09
+	_api_registerPlural( 'cells().cache()', 'cell().cache()', function ( type=
 ) {
+		type =3D type =3D=3D=3D 'search' ? '_aFilterData' : '_aSortData';
+=09
+		return this.iterator( 'cell', function ( settings, row, column ) {
+			return settings.aoData[ row ][ type ][ column ];
+		}, 1 );
+	} );
+=09
+=09
+	_api_registerPlural( 'cells().render()', 'cell().render()', function ( ty=
pe ) {
+		return this.iterator( 'cell', function ( settings, row, column ) {
+			return _fnGetCellData( settings, row, column, type );
+		}, 1 );
+	} );
+=09
+=09
+	_api_registerPlural( 'cells().indexes()', 'cell().index()', function () {
+		return this.iterator( 'cell', function ( settings, row, column ) {
+			return {
+				row: row,
+				column: column,
+				columnVisible: _fnColumnIndexToVisible( settings, column )
+			};
+		}, 1 );
+	} );
+=09
+=09
+	_api_registerPlural( 'cells().invalidate()', 'cell().invalidate()', funct=
ion ( src ) {
+		return this.iterator( 'cell', function ( settings, row, column ) {
+			_fnInvalidate( settings, row, src, column );
+		} );
+	} );
+=09
+=09
+=09
+	_api_register( 'cell()', function ( rowSelector, columnSelector, opts ) {
+		return _selector_first( this.cells( rowSelector, columnSelector, opts ) =
);
+	} );
+=09
+=09
+	_api_register( 'cell().data()', function ( data ) {
+		var ctx =3D this.context;
+		var cell =3D this[0];
+=09
+		if ( data =3D=3D=3D undefined ) {
+			// Get
+			return ctx.length && cell.length ?
+				_fnGetCellData( ctx[0], cell[0].row, cell[0].column ) :
+				undefined;
+		}
+=09
+		// Set
+		_fnSetCellData( ctx[0], cell[0].row, cell[0].column, data );
+		_fnInvalidate( ctx[0], cell[0].row, 'data', cell[0].column );
+=09
+		return this;
+	} );
+=09
+=09
+=09
+	/**
+	 * Get current ordering (sorting) that has been applied to the table.
+	 *
+	 * @returns {array} 2D array containing the sorting information for the f=
irst
+	 *   table in the current context. Each element in the parent array repre=
sents
+	 *   a column being sorted upon (i.e. multi-sorting with two columns woul=
d have
+	 *   2 inner arrays). The inner arrays may have 2 or 3 elements. The firs=
t is
+	 *   the column index that the sorting condition applies to, the second i=
s the
+	 *   direction of the sort (`desc` or `asc`) and, optionally, the third i=
s the
+	 *   index of the sorting order from the `column.sorting` initialisation =
array.
+	 *//**
+	 * Set the ordering for the table.
+	 *
+	 * @param {integer} order Column index to sort upon.
+	 * @param {string} direction Direction of the sort to be applied (`asc` o=
r `desc`)
+	 * @returns {DataTables.Api} this
+	 *//**
+	 * Set the ordering for the table.
+	 *
+	 * @param {array} order 1D array of sorting information to be applied.
+	 * @param {array} [...] Optional additional sorting conditions
+	 * @returns {DataTables.Api} this
+	 *//**
+	 * Set the ordering for the table.
+	 *
+	 * @param {array} order 2D array of sorting information to be applied.
+	 * @returns {DataTables.Api} this
+	 */
+	_api_register( 'order()', function ( order, dir ) {
+		var ctx =3D this.context;
+=09
+		if ( order =3D=3D=3D undefined ) {
+			// get
+			return ctx.length !=3D=3D 0 ?
+				ctx[0].aaSorting :
+				undefined;
+		}
+=09
+		// set
+		if ( typeof order =3D=3D=3D 'number' ) {
+			// Simple column / direction passed in
+			order =3D [ [ order, dir ] ];
+		}
+		else if ( order.length && ! Array.isArray( order[0] ) ) {
+			// Arguments passed in (list of 1D arrays)
+			order =3D Array.prototype.slice.call( arguments );
+		}
+		// otherwise a 2D array was passed in
+=09
+		return this.iterator( 'table', function ( settings ) {
+			settings.aaSorting =3D order.slice();
+		} );
+	} );
+=09
+=09
+	/**
+	 * Attach a sort listener to an element for a given column
+	 *
+	 * @param {node|jQuery|string} node Identifier for the element(s) to atta=
ch the
+	 *   listener to. This can take the form of a single DOM node, a jQuery
+	 *   collection of nodes or a jQuery selector which will identify the nod=
e(s).
+	 * @param {integer} column the column that a click on this node will sort=
 on
+	 * @param {function} [callback] callback function when sort is run
+	 * @returns {DataTables.Api} this
+	 */
+	_api_register( 'order.listener()', function ( node, column, callback ) {
+		return this.iterator( 'table', function ( settings ) {
+			_fnSortAttachListener( settings, node, column, callback );
+		} );
+	} );
+=09
+=09
+	_api_register( 'order.fixed()', function ( set ) {
+		if ( ! set ) {
+			var ctx =3D this.context;
+			var fixed =3D ctx.length ?
+				ctx[0].aaSortingFixed :
+				undefined;
+=09
+			return Array.isArray( fixed ) ?
+				{ pre: fixed } :
+				fixed;
+		}
+=09
+		return this.iterator( 'table', function ( settings ) {
+			settings.aaSortingFixed =3D $.extend( true, {}, set );
+		} );
+	} );
+=09
+=09
+	// Order by the selected column(s)
+	_api_register( [
+		'columns().order()',
+		'column().order()'
+	], function ( dir ) {
+		var that =3D this;
+=09
+		return this.iterator( 'table', function ( settings, i ) {
+			var sort =3D [];
+=09
+			$.each( that[i], function (j, col) {
+				sort.push( [ col, dir ] );
+			} );
+=09
+			settings.aaSorting =3D sort;
+		} );
+	} );
+=09
+=09
+=09
+	_api_register( 'search()', function ( input, regex, smart, caseInsen ) {
+		var ctx =3D this.context;
+=09
+		if ( input =3D=3D=3D undefined ) {
+			// get
+			return ctx.length !=3D=3D 0 ?
+				ctx[0].oPreviousSearch.sSearch :
+				undefined;
+		}
+=09
+		// set
+		return this.iterator( 'table', function ( settings ) {
+			if ( ! settings.oFeatures.bFilter ) {
+				return;
+			}
+=09
+			_fnFilterComplete( settings, $.extend( {}, settings.oPreviousSearch, {
+				"sSearch": input+"",
+				"bRegex":  regex =3D=3D=3D null ? false : regex,
+				"bSmart":  smart =3D=3D=3D null ? true  : smart,
+				"bCaseInsensitive": caseInsen =3D=3D=3D null ? true : caseInsen
+			} ), 1 );
+		} );
+	} );
+=09
+=09
+	_api_registerPlural(
+		'columns().search()',
+		'column().search()',
+		function ( input, regex, smart, caseInsen ) {
+			return this.iterator( 'column', function ( settings, column ) {
+				var preSearch =3D settings.aoPreSearchCols;
+=09
+				if ( input =3D=3D=3D undefined ) {
+					// get
+					return preSearch[ column ].sSearch;
+				}
+=09
+				// set
+				if ( ! settings.oFeatures.bFilter ) {
+					return;
+				}
+=09
+				$.extend( preSearch[ column ], {
+					"sSearch": input+"",
+					"bRegex":  regex =3D=3D=3D null ? false : regex,
+					"bSmart":  smart =3D=3D=3D null ? true  : smart,
+					"bCaseInsensitive": caseInsen =3D=3D=3D null ? true : caseInsen
+				} );
+=09
+				_fnFilterComplete( settings, settings.oPreviousSearch, 1 );
+			} );
+		}
+	);
+=09
+	/*
+	 * State API methods
+	 */
+=09
+	_api_register( 'state()', function () {
+		return this.context.length ?
+			this.context[0].oSavedState :
+			null;
+	} );
+=09
+=09
+	_api_register( 'state.clear()', function () {
+		return this.iterator( 'table', function ( settings ) {
+			// Save an empty object
+			settings.fnStateSaveCallback.call( settings.oInstance, settings, {} );
+		} );
+	} );
+=09
+=09
+	_api_register( 'state.loaded()', function () {
+		return this.context.length ?
+			this.context[0].oLoadedState :
+			null;
+	} );
+=09
+=09
+	_api_register( 'state.save()', function () {
+		return this.iterator( 'table', function ( settings ) {
+			_fnSaveState( settings );
+		} );
+	} );
+=09
+=09
+=09
+	/**
+	 * Provide a common method for plug-ins to check the version of DataTable=
s being
+	 * used, in order to ensure compatibility.
+	 *
+	 *  @param {string} version Version string to check for, in the format "X=
.Y.Z".
+	 *    Note that the formats "X" and "X.Y" are also acceptable.
+	 *  @returns {boolean} true if this version of DataTables is greater or e=
qual to
+	 *    the required version, or false if this version of DataTales is not
+	 *    suitable
+	 *  @static
+	 *  @dtopt API-Static
+	 *
+	 *  @example
+	 *    alert( $.fn.dataTable.versionCheck( '1.9.0' ) );
+	 */
+	DataTable.versionCheck =3D DataTable.fnVersionCheck =3D function( version=
 )
+	{
+		var aThis =3D DataTable.version.split('.');
+		var aThat =3D version.split('.');
+		var iThis, iThat;
+=09
+		for ( var i=3D0, iLen=3DaThat.length ; i<iLen ; i++ ) {
+			iThis =3D parseInt( aThis[i], 10 ) || 0;
+			iThat =3D parseInt( aThat[i], 10 ) || 0;
+=09
+			// Parts are the same, keep comparing
+			if (iThis =3D=3D=3D iThat) {
+				continue;
+			}
+=09
+			// Parts are different, return immediately
+			return iThis > iThat;
+		}
+=09
+		return true;
+	};
+=09
+=09
+	/**
+	 * Check if a `<table>` node is a DataTable table already or not.
+	 *
+	 *  @param {node|jquery|string} table Table node, jQuery object or jQuery
+	 *      selector for the table to test. Note that if more than more than =
one
+	 *      table is passed on, only the first will be checked
+	 *  @returns {boolean} true the table given is a DataTable, or false othe=
rwise
+	 *  @static
+	 *  @dtopt API-Static
+	 *
+	 *  @example
+	 *    if ( ! $.fn.DataTable.isDataTable( '#example' ) ) {
+	 *      $('#example').dataTable();
+	 *    }
+	 */
+	DataTable.isDataTable =3D DataTable.fnIsDataTable =3D function ( table )
+	{
+		var t =3D $(table).get(0);
+		var is =3D false;
+=09
+		if ( table instanceof DataTable.Api ) {
+			return true;
+		}
+=09
+		$.each( DataTable.settings, function (i, o) {
+			var head =3D o.nScrollHead ? $('table', o.nScrollHead)[0] : null;
+			var foot =3D o.nScrollFoot ? $('table', o.nScrollFoot)[0] : null;
+=09
+			if ( o.nTable =3D=3D=3D t || head =3D=3D=3D t || foot =3D=3D=3D t ) {
+				is =3D true;
+			}
+		} );
+=09
+		return is;
+	};
+=09
+=09
+	/**
+	 * Get all DataTable tables that have been initialised - optionally you c=
an
+	 * select to get only currently visible tables.
+	 *
+	 *  @param {boolean} [visible=3Dfalse] Flag to indicate if you want all (=
default)
+	 *    or visible tables only.
+	 *  @returns {array} Array of `table` nodes (not DataTable instances) whi=
ch are
+	 *    DataTables
+	 *  @static
+	 *  @dtopt API-Static
+	 *
+	 *  @example
+	 *    $.each( $.fn.dataTable.tables(true), function () {
+	 *      $(table).DataTable().columns.adjust();
+	 *    } );
+	 */
+	DataTable.tables =3D DataTable.fnTables =3D function ( visible )
+	{
+		var api =3D false;
+=09
+		if ( $.isPlainObject( visible ) ) {
+			api =3D visible.api;
+			visible =3D visible.visible;
+		}
+=09
+		var a =3D $.map( DataTable.settings, function (o) {
+			if ( !visible || (visible && $(o.nTable).is(':visible')) ) {
+				return o.nTable;
+			}
+		} );
+=09
+		return api ?
+			new _Api( a ) :
+			a;
+	};
+=09
+=09
+	/**
+	 * Convert from camel case parameters to Hungarian notation. This is made=
 public
+	 * for the extensions to provide the same ability as DataTables core to a=
ccept
+	 * either the 1.9 style Hungarian notation, or the 1.10+ style camelCase
+	 * parameters.
+	 *
+	 *  @param {object} src The model object which holds all parameters that =
can be
+	 *    mapped.
+	 *  @param {object} user The object to convert from camel case to Hungari=
an.
+	 *  @param {boolean} force When set to `true`, properties which already h=
ave a
+	 *    Hungarian value in the `user` object will be overwritten. Otherwise=
 they
+	 *    won't be.
+	 */
+	DataTable.camelToHungarian =3D _fnCamelToHungarian;
+=09
+=09
+=09
+	/**
+	 *
+	 */
+	_api_register( '$()', function ( selector, opts ) {
+		var
+			rows   =3D this.rows( opts ).nodes(), // Get all rows
+			jqRows =3D $(rows);
+=09
+		return $( [].concat(
+			jqRows.filter( selector ).toArray(),
+			jqRows.find( selector ).toArray()
+		) );
+	} );
+=09
+=09
+	// jQuery functions to operate on the tables
+	$.each( [ 'on', 'one', 'off' ], function (i, key) {
+		_api_register( key+'()', function ( /* event, handler */ ) {
+			var args =3D Array.prototype.slice.call(arguments);
+=09
+			// Add the `dt` namespace automatically if it isn't already present
+			args[0] =3D $.map( args[0].split( /\s/ ), function ( e ) {
+				return ! e.match(/\.dt\b/) ?
+					e+'.dt' :
+					e;
+				} ).join( ' ' );
+=09
+			var inst =3D $( this.tables().nodes() );
+			inst[key].apply( inst, args );
+			return this;
+		} );
+	} );
+=09
+=09
+	_api_register( 'clear()', function () {
+		return this.iterator( 'table', function ( settings ) {
+			_fnClearTable( settings );
+		} );
+	} );
+=09
+=09
+	_api_register( 'settings()', function () {
+		return new _Api( this.context, this.context );
+	} );
+=09
+=09
+	_api_register( 'init()', function () {
+		var ctx =3D this.context;
+		return ctx.length ? ctx[0].oInit : null;
+	} );
+=09
+=09
+	_api_register( 'data()', function () {
+		return this.iterator( 'table', function ( settings ) {
+			return _pluck( settings.aoData, '_aData' );
+		} ).flatten();
+	} );
+=09
+=09
+	_api_register( 'destroy()', function ( remove ) {
+		remove =3D remove || false;
+=09
+		return this.iterator( 'table', function ( settings ) {
+			var orig      =3D settings.nTableWrapper.parentNode;
+			var classes   =3D settings.oClasses;
+			var table     =3D settings.nTable;
+			var tbody     =3D settings.nTBody;
+			var thead     =3D settings.nTHead;
+			var tfoot     =3D settings.nTFoot;
+			var jqTable   =3D $(table);
+			var jqTbody   =3D $(tbody);
+			var jqWrapper =3D $(settings.nTableWrapper);
+			var rows      =3D $.map( settings.aoData, function (r) { return r.nTr; =
} );
+			var i, ien;
+=09
+			// Flag to note that the table is currently being destroyed - no action
+			// should be taken
+			settings.bDestroying =3D true;
+=09
+			// Fire off the destroy callbacks for plug-ins etc
+			_fnCallbackFire( settings, "aoDestroyCallback", "destroy", [settings] );
+=09
+			// If not being removed from the document, make all columns visible
+			if ( ! remove ) {
+				new _Api( settings ).columns().visible( true );
+			}
+=09
+			// Blitz all `DT` namespaced events (these are internal events, the
+			// lowercase, `dt` events are user subscribed and they are responsible
+			// for removing them
+			jqWrapper.off('.DT').find(':not(tbody *)').off('.DT');
+			$(window).off('.DT-'+settings.sInstance);
+=09
+			// When scrolling we had to break the table up - restore it
+			if ( table !=3D thead.parentNode ) {
+				jqTable.children('thead').detach();
+				jqTable.append( thead );
+			}
+=09
+			if ( tfoot && table !=3D tfoot.parentNode ) {
+				jqTable.children('tfoot').detach();
+				jqTable.append( tfoot );
+			}
+=09
+			settings.aaSorting =3D [];
+			settings.aaSortingFixed =3D [];
+			_fnSortingClasses( settings );
+=09
+			$( rows ).removeClass( settings.asStripeClasses.join(' ') );
+=09
+			$('th, td', thead).removeClass( classes.sSortable+' '+
+				classes.sSortableAsc+' '+classes.sSortableDesc+' '+classes.sSortableNo=
ne
+			);
+=09
+			// Add the TR elements back into the table in their original order
+			jqTbody.children().detach();
+			jqTbody.append( rows );
+=09
+			// Remove the DataTables generated nodes, events and classes
+			var removedMethod =3D remove ? 'remove' : 'detach';
+			jqTable[ removedMethod ]();
+			jqWrapper[ removedMethod ]();
+=09
+			// If we need to reattach the table to the document
+			if ( ! remove && orig ) {
+				// insertBefore acts like appendChild if !arg[1]
+				orig.insertBefore( table, settings.nTableReinsertBefore );
+=09
+				// Restore the width of the original table - was read from the style p=
roperty,
+				// so we can restore directly to that
+				jqTable
+					.css( 'width', settings.sDestroyWidth )
+					.removeClass( classes.sTable );
+=09
+				// If the were originally stripe classes - then we add them back here.
+				// Note this is not fool proof (for example if not all rows had stripe
+				// classes - but it's a good effort without getting carried away
+				ien =3D settings.asDestroyStripes.length;
+=09
+				if ( ien ) {
+					jqTbody.children().each( function (i) {
+						$(this).addClass( settings.asDestroyStripes[i % ien] );
+					} );
+				}
+			}
+=09
+			/* Remove the settings object from the settings array */
+			var idx =3D $.inArray( settings, DataTable.settings );
+			if ( idx !=3D=3D -1 ) {
+				DataTable.settings.splice( idx, 1 );
+			}
+		} );
+	} );
+=09
+=09
+	// Add the `every()` method for rows, columns and cells in a compact form
+	$.each( [ 'column', 'row', 'cell' ], function ( i, type ) {
+		_api_register( type+'s().every()', function ( fn ) {
+			var opts =3D this.selector.opts;
+			var api =3D this;
+=09
+			return this.iterator( type, function ( settings, arg1, arg2, arg3, arg4=
 ) {
+				// Rows and columns:
+				//  arg1 - index
+				//  arg2 - table counter
+				//  arg3 - loop counter
+				//  arg4 - undefined
+				// Cells:
+				//  arg1 - row index
+				//  arg2 - column index
+				//  arg3 - table counter
+				//  arg4 - loop counter
+				fn.call(
+					api[ type ](
+						arg1,
+						type=3D=3D=3D'cell' ? arg2 : opts,
+						type=3D=3D=3D'cell' ? opts : undefined
+					),
+					arg1, arg2, arg3, arg4
+				);
+			} );
+		} );
+	} );
+=09
+=09
+	// i18n method for extensions to be able to use the language object from =
the
+	// DataTable
+	_api_register( 'i18n()', function ( token, def, plural ) {
+		var ctx =3D this.context[0];
+		var resolved =3D _fnGetObjectDataFn( token )( ctx.oLanguage );
+=09
+		if ( resolved =3D=3D=3D undefined ) {
+			resolved =3D def;
+		}
+=09
+		if ( plural !=3D=3D undefined && $.isPlainObject( resolved ) ) {
+			resolved =3D resolved[ plural ] !=3D=3D undefined ?
+				resolved[ plural ] :
+				resolved._;
+		}
+=09
+		return resolved.replace( '%d', plural ); // nb: plural might be undefine=
d,
+	} );=09
+	/**
+	 * Version string for plug-ins to check compatibility. Allowed format is
+	 * `a.b.c-d` where: a:int, b:int, c:int, d:string(dev|beta|alpha). `d` is=
 used
+	 * only for non-release builds. See http://semver.org/ for more informati=
on.
+	 *  @member
+	 *  @type string
+	 *  @default Version number
+	 */
+	DataTable.version =3D "1.11.5";
+=09
+	/**
+	 * Private data store, containing all of the settings objects that are
+	 * created for the tables on a given page.
+	 *
+	 * Note that the `DataTable.settings` object is aliased to
+	 * `jQuery.fn.dataTableExt` through which it may be accessed and
+	 * manipulated, or `jQuery.fn.dataTable.settings`.
+	 *  @member
+	 *  @type array
+	 *  @default []
+	 *  @private
+	 */
+	DataTable.settings =3D [];
+=09
+	/**
+	 * Object models container, for the various models that DataTables has
+	 * available to it. These models define the objects that are used to hold
+	 * the active state and configuration of the table.
+	 *  @namespace
+	 */
+	DataTable.models =3D {};
+=09
+=09
+=09
+	/**
+	 * Template object for the way in which DataTables holds information about
+	 * search information for the global filter and individual column filters.
+	 *  @namespace
+	 */
+	DataTable.models.oSearch =3D {
+		/**
+		 * Flag to indicate if the filtering should be case insensitive or not
+		 *  @type boolean
+		 *  @default true
+		 */
+		"bCaseInsensitive": true,
+=09
+		/**
+		 * Applied search term
+		 *  @type string
+		 *  @default <i>Empty string</i>
+		 */
+		"sSearch": "",
+=09
+		/**
+		 * Flag to indicate if the search term should be interpreted as a
+		 * regular expression (true) or not (false) and therefore and special
+		 * regex characters escaped.
+		 *  @type boolean
+		 *  @default false
+		 */
+		"bRegex": false,
+=09
+		/**
+		 * Flag to indicate if DataTables is to use its smart filtering or not.
+		 *  @type boolean
+		 *  @default true
+		 */
+		"bSmart": true,
+=09
+		/**
+		 * Flag to indicate if DataTables should only trigger a search when
+		 * the return key is pressed.
+		 *  @type boolean
+		 *  @default false
+		 */
+		"return": false
+	};
+=09
+=09=09
+=09=09
+=09=09
+		/**
+		 * Template object for the way in which DataTables holds information abo=
ut
+		 * each individual row. This is the object format used for the settings
+		 * aoData array.
+		 *  @namespace
+		 */
+		DataTable.models.oRow =3D {
+			/**
+			 * TR element for the row
+			 *  @type node
+			 *  @default null
+			 */
+			"nTr": null,
+=09=09
+			/**
+			 * Array of TD elements for each row. This is null until the row has be=
en
+			 * created.
+			 *  @type array nodes
+			 *  @default []
+			 */
+			"anCells": null,
+=09=09
+			/**
+			 * Data object from the original data source for the row. This is either
+			 * an array if using the traditional form of DataTables, or an object if
+			 * using mData options. The exact type will depend on the passed in
+			 * data from the data source, or will be an array if using DOM a data
+			 * source.
+			 *  @type array|object
+			 *  @default []
+			 */
+			"_aData": [],
+=09=09
+			/**
+			 * Sorting data cache - this array is ostensibly the same length as the
+			 * number of columns (although each index is generated only as it is
+			 * needed), and holds the data that is used for sorting each column in =
the
+			 * row. We do this cache generation at the start of the sort in order t=
hat
+			 * the formatting of the sort data need be done only once for each cell
+			 * per sort. This array should not be read from or written to by anythi=
ng
+			 * other than the master sorting methods.
+			 *  @type array
+			 *  @default null
+			 *  @private
+			 */
+			"_aSortData": null,
+=09=09
+			/**
+			 * Per cell filtering data cache. As per the sort data cache, used to
+			 * increase the performance of the filtering in DataTables
+			 *  @type array
+			 *  @default null
+			 *  @private
+			 */
+			"_aFilterData": null,
+=09=09
+			/**
+			 * Filtering data cache. This is the same as the cell filtering cache, =
but
+			 * in this case a string rather than an array. This is easily computed =
with
+			 * a join on `_aFilterData`, but is provided as a cache so the join isn=
't
+			 * needed on every search (memory traded for performance)
+			 *  @type array
+			 *  @default null
+			 *  @private
+			 */
+			"_sFilterRow": null,
+=09=09
+			/**
+			 * Cache of the class name that DataTables has applied to the row, so we
+			 * can quickly look at this variable rather than needing to do a DOM ch=
eck
+			 * on className for the nTr property.
+			 *  @type string
+			 *  @default <i>Empty string</i>
+			 *  @private
+			 */
+			"_sRowStripe": "",
+=09=09
+			/**
+			 * Denote if the original data source was from the DOM, or the data sou=
rce
+			 * object. This is used for invalidating data, so DataTables can
+			 * automatically read data from the original source, unless uninstructed
+			 * otherwise.
+			 *  @type string
+			 *  @default null
+			 *  @private
+			 */
+			"src": null,
+=09=09
+			/**
+			 * Index in the aoData array. This saves an indexOf lookup when we have=
 the
+			 * object, but want to know the index
+			 *  @type integer
+			 *  @default -1
+			 *  @private
+			 */
+			"idx": -1
+		};
+=09=09
+=09=09
+		/**
+		 * Template object for the column information object in DataTables. This=
 object
+		 * is held in the settings aoColumns array and contains all the informat=
ion that
+		 * DataTables needs about each individual column.
+		 *
+		 * Note that this object is related to {@link DataTable.defaults.column}
+		 * but this one is the internal data store for DataTables's cache of col=
umns.
+		 * It should NOT be manipulated outside of DataTables. Any configuration=
 should
+		 * be done through the initialisation options.
+		 *  @namespace
+		 */
+		DataTable.models.oColumn =3D {
+			/**
+			 * Column index. This could be worked out on-the-fly with $.inArray, bu=
t it
+			 * is faster to just hold it as a variable
+			 *  @type integer
+			 *  @default null
+			 */
+			"idx": null,
+=09=09
+			/**
+			 * A list of the columns that sorting should occur on when this column
+			 * is sorted. That this property is an array allows multi-column sorting
+			 * to be defined for a column (for example first name / last name colum=
ns
+			 * would benefit from this). The values are integers pointing to the
+			 * columns to be sorted on (typically it will be a single integer point=
ing
+			 * at itself, but that doesn't need to be the case).
+			 *  @type array
+			 */
+			"aDataSort": null,
+=09=09
+			/**
+			 * Define the sorting directions that are applied to the column, in seq=
uence
+			 * as the column is repeatedly sorted upon - i.e. the first value is us=
ed
+			 * as the sorting direction when the column if first sorted (clicked on=
).
+			 * Sort it again (click again) and it will move on to the next index.
+			 * Repeat until loop.
+			 *  @type array
+			 */
+			"asSorting": null,
+=09=09
+			/**
+			 * Flag to indicate if the column is searchable, and thus should be inc=
luded
+			 * in the filtering or not.
+			 *  @type boolean
+			 */
+			"bSearchable": null,
+=09=09
+			/**
+			 * Flag to indicate if the column is sortable or not.
+			 *  @type boolean
+			 */
+			"bSortable": null,
+=09=09
+			/**
+			 * Flag to indicate if the column is currently visible in the table or =
not
+			 *  @type boolean
+			 */
+			"bVisible": null,
+=09=09
+			/**
+			 * Store for manual type assignment using the `column.type` option. This
+			 * is held in store so we can manipulate the column's `sType` property.
+			 *  @type string
+			 *  @default null
+			 *  @private
+			 */
+			"_sManualType": null,
+=09=09
+			/**
+			 * Flag to indicate if HTML5 data attributes should be used as the data
+			 * source for filtering or sorting. True is either are.
+			 *  @type boolean
+			 *  @default false
+			 *  @private
+			 */
+			"_bAttrSrc": false,
+=09=09
+			/**
+			 * Developer definable function that is called whenever a cell is creat=
ed (Ajax source,
+			 * etc) or processed for input (DOM source). This can be used as a comp=
liment to mRender
+			 * allowing you to modify the DOM element (add background colour for ex=
ample) when the
+			 * element is available.
+			 *  @type function
+			 *  @param {element} nTd The TD node that has been created
+			 *  @param {*} sData The Data for the cell
+			 *  @param {array|object} oData The data for the whole row
+			 *  @param {int} iRow The row index for the aoData data store
+			 *  @default null
+			 */
+			"fnCreatedCell": null,
+=09=09
+			/**
+			 * Function to get data from a cell in a column. You should <b>never</b>
+			 * access data directly through _aData internally in DataTables - alway=
s use
+			 * the method attached to this property. It allows mData to function as
+			 * required. This function is automatically assigned by the column
+			 * initialisation method
+			 *  @type function
+			 *  @param {array|object} oData The data array/object for the array
+			 *    (i.e. aoData[]._aData)
+			 *  @param {string} sSpecific The specific data type you want to get -
+			 *    'display', 'type' 'filter' 'sort'
+			 *  @returns {*} The data for the cell from the given row's data
+			 *  @default null
+			 */
+			"fnGetData": null,
+=09=09
+			/**
+			 * Function to set data for a cell in the column. You should <b>never</=
b>
+			 * set the data directly to _aData internally in DataTables - always use
+			 * this method. It allows mData to function as required. This function
+			 * is automatically assigned by the column initialisation method
+			 *  @type function
+			 *  @param {array|object} oData The data array/object for the array
+			 *    (i.e. aoData[]._aData)
+			 *  @param {*} sValue Value to set
+			 *  @default null
+			 */
+			"fnSetData": null,
+=09=09
+			/**
+			 * Property to read the value for the cells in the column from the data
+			 * source array / object. If null, then the default content is used, if=
 a
+			 * function is given then the return from the function is used.
+			 *  @type function|int|string|null
+			 *  @default null
+			 */
+			"mData": null,
+=09=09
+			/**
+			 * Partner property to mData which is used (only when defined) to get
+			 * the data - i.e. it is basically the same as mData, but without the
+			 * 'set' option, and also the data fed to it is the result from mData.
+			 * This is the rendering method to match the data method of mData.
+			 *  @type function|int|string|null
+			 *  @default null
+			 */
+			"mRender": null,
+=09=09
+			/**
+			 * Unique header TH/TD element for this column - this is what the sorti=
ng
+			 * listener is attached to (if sorting is enabled.)
+			 *  @type node
+			 *  @default null
+			 */
+			"nTh": null,
+=09=09
+			/**
+			 * Unique footer TH/TD element for this column (if there is one). Not u=
sed
+			 * in DataTables as such, but can be used for plug-ins to reference the
+			 * footer for each column.
+			 *  @type node
+			 *  @default null
+			 */
+			"nTf": null,
+=09=09
+			/**
+			 * The class to apply to all TD elements in the table's TBODY for the c=
olumn
+			 *  @type string
+			 *  @default null
+			 */
+			"sClass": null,
+=09=09
+			/**
+			 * When DataTables calculates the column widths to assign to each colum=
n,
+			 * it finds the longest string in each column and then constructs a
+			 * temporary table and reads the widths from that. The problem with this
+			 * is that "mmm" is much wider then "iiii", but the latter is a longer
+			 * string - thus the calculation can go wrong (doing it properly and pu=
tting
+			 * it into an DOM object and measuring that is horribly(!) slow). Thus =
as
+			 * a "work around" we provide this option. It will append its value to =
the
+			 * text that is found to be the longest string for the column - i.e. pa=
dding.
+			 *  @type string
+			 */
+			"sContentPadding": null,
+=09=09
+			/**
+			 * Allows a default value to be given for a column's data, and will be =
used
+			 * whenever a null data source is encountered (this can be because mData
+			 * is set to null, or because the data source itself is null).
+			 *  @type string
+			 *  @default null
+			 */
+			"sDefaultContent": null,
+=09=09
+			/**
+			 * Name for the column, allowing reference to the column by name as wel=
l as
+			 * by index (needs a lookup to work by name).
+			 *  @type string
+			 */
+			"sName": null,
+=09=09
+			/**
+			 * Custom sorting data type - defines which of the available plug-ins in
+			 * afnSortData the custom sorting will use - if any is defined.
+			 *  @type string
+			 *  @default std
+			 */
+			"sSortDataType": 'std',
+=09=09
+			/**
+			 * Class to be applied to the header element when sorting on this column
+			 *  @type string
+			 *  @default null
+			 */
+			"sSortingClass": null,
+=09=09
+			/**
+			 * Class to be applied to the header element when sorting on this colum=
n -
+			 * when jQuery UI theming is used.
+			 *  @type string
+			 *  @default null
+			 */
+			"sSortingClassJUI": null,
+=09=09
+			/**
+			 * Title of the column - what is seen in the TH element (nTh).
+			 *  @type string
+			 */
+			"sTitle": null,
+=09=09
+			/**
+			 * Column sorting and filtering type
+			 *  @type string
+			 *  @default null
+			 */
+			"sType": null,
+=09=09
+			/**
+			 * Width of the column
+			 *  @type string
+			 *  @default null
+			 */
+			"sWidth": null,
+=09=09
+			/**
+			 * Width of the column when it was first "encountered"
+			 *  @type string
+			 *  @default null
+			 */
+			"sWidthOrig": null
+		};
+=09=09
+=09=09
+		/*
+		 * Developer note: The properties of the object below are given in Hunga=
rian
+		 * notation, that was used as the interface for DataTables prior to v1.1=
0, however
+		 * from v1.10 onwards the primary interface is camel case. In order to a=
void
+		 * breaking backwards compatibility utterly with this change, the Hungar=
ian
+		 * version is still, internally the primary interface, but is is not doc=
umented
+		 * - hence the @name tags in each doc comment. This allows a Javascript =
function
+		 * to create a map from Hungarian notation to camel case (going the othe=
r direction
+		 * would require each property to be listed, which would add around 3K t=
o the size
+		 * of DataTables, while this method is about a 0.5K hit).
+		 *
+		 * Ultimately this does pave the way for Hungarian notation to be dropped
+		 * completely, but that is a massive amount of work and will break curre=
nt
+		 * installs (therefore is on-hold until v2).
+		 */
+=09=09
+		/**
+		 * Initialisation options that can be given to DataTables at initialisat=
ion
+		 * time.
+		 *  @namespace
+		 */
+		DataTable.defaults =3D {
+			/**
+			 * An array of data to use for the table, passed in at initialisation w=
hich
+			 * will be used in preference to any data which is already in the DOM. =
This is
+			 * particularly useful for constructing tables purely in Javascript, for
+			 * example with a custom Ajax call.
+			 *  @type array
+			 *  @default null
+			 *
+			 *  @dtopt Option
+			 *  @name DataTable.defaults.data
+			 *
+			 *  @example
+			 *    // Using a 2D array data source
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "data": [
+			 *          ['Trident', 'Internet Explorer 4.0', 'Win 95+', 4, 'X'],
+			 *          ['Trident', 'Internet Explorer 5.0', 'Win 95+', 5, 'C'],
+			 *        ],
+			 *        "columns": [
+			 *          { "title": "Engine" },
+			 *          { "title": "Browser" },
+			 *          { "title": "Platform" },
+			 *          { "title": "Version" },
+			 *          { "title": "Grade" }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using an array of objects as a data source (`data`)
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "data": [
+			 *          {
+			 *            "engine":   "Trident",
+			 *            "browser":  "Internet Explorer 4.0",
+			 *            "platform": "Win 95+",
+			 *            "version":  4,
+			 *            "grade":    "X"
+			 *          },
+			 *          {
+			 *            "engine":   "Trident",
+			 *            "browser":  "Internet Explorer 5.0",
+			 *            "platform": "Win 95+",
+			 *            "version":  5,
+			 *            "grade":    "C"
+			 *          }
+			 *        ],
+			 *        "columns": [
+			 *          { "title": "Engine",   "data": "engine" },
+			 *          { "title": "Browser",  "data": "browser" },
+			 *          { "title": "Platform", "data": "platform" },
+			 *          { "title": "Version",  "data": "version" },
+			 *          { "title": "Grade",    "data": "grade" }
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"aaData": null,
+=09=09
+=09=09
+			/**
+			 * If ordering is enabled, then DataTables will perform a first pass so=
rt on
+			 * initialisation. You can define which column(s) the sort is performed
+			 * upon, and the sorting direction, with this variable. The `sorting` a=
rray
+			 * should contain an array for each column to be sorted initially conta=
ining
+			 * the column's index and a direction string ('asc' or 'desc').
+			 *  @type array
+			 *  @default [[0,'asc']]
+			 *
+			 *  @dtopt Option
+			 *  @name DataTable.defaults.order
+			 *
+			 *  @example
+			 *    // Sort by 3rd column first, and then 4th column
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "order": [[2,'asc'], [3,'desc']]
+			 *      } );
+			 *    } );
+			 *
+			 *    // No initial sorting
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "order": []
+			 *      } );
+			 *    } );
+			 */
+			"aaSorting": [[0,'asc']],
+=09=09
+=09=09
+			/**
+			 * This parameter is basically identical to the `sorting` parameter, but
+			 * cannot be overridden by user interaction with the table. What this m=
eans
+			 * is that you could have a column (visible or hidden) which the sorting
+			 * will always be forced on first - any sorting after that (from the us=
er)
+			 * will then be performed as required. This can be useful for grouping =
rows
+			 * together.
+			 *  @type array
+			 *  @default null
+			 *
+			 *  @dtopt Option
+			 *  @name DataTable.defaults.orderFixed
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "orderFixed": [[0,'asc']]
+			 *      } );
+			 *    } )
+			 */
+			"aaSortingFixed": [],
+=09=09
+=09=09
+			/**
+			 * DataTables can be instructed to load data to display in the table fr=
om a
+			 * Ajax source. This option defines how that Ajax call is made and wher=
e to.
+			 *
+			 * The `ajax` property has three different modes of operation, dependin=
g on
+			 * how it is defined. These are:
+			 *
+			 * * `string` - Set the URL from where the data should be loaded from.
+			 * * `object` - Define properties for `jQuery.ajax`.
+			 * * `function` - Custom data get function
+			 *
+			 * `string`
+			 * --------
+			 *
+			 * As a string, the `ajax` property simply defines the URL from which
+			 * DataTables will load data.
+			 *
+			 * `object`
+			 * --------
+			 *
+			 * As an object, the parameters in the object are passed to
+			 * [jQuery.ajax](http://api.jquery.com/jQuery.ajax/) allowing fine cont=
rol
+			 * of the Ajax request. DataTables has a number of default parameters w=
hich
+			 * you can override using this option. Please refer to the jQuery
+			 * documentation for a full description of the options available, altho=
ugh
+			 * the following parameters provide additional options in DataTables or
+			 * require special consideration:
+			 *
+			 * * `data` - As with jQuery, `data` can be provided as an object, but =
it
+			 *   can also be used as a function to manipulate the data DataTables s=
ends
+			 *   to the server. The function takes a single parameter, an object of
+			 *   parameters with the values that DataTables has readied for sending=
. An
+			 *   object may be returned which will be merged into the DataTables
+			 *   defaults, or you can add the items to the object that was passed i=
n and
+			 *   not return anything from the function. This supersedes `fnServerPa=
rams`
+			 *   from DataTables 1.9-.
+			 *
+			 * * `dataSrc` - By default DataTables will look for the property `data=
` (or
+			 *   `aaData` for compatibility with DataTables 1.9-) when obtaining da=
ta
+			 *   from an Ajax source or for server-side processing - this parameter
+			 *   allows that property to be changed. You can use Javascript dotted
+			 *   object notation to get a data source for multiple levels of nestin=
g, or
+			 *   it my be used as a function. As a function it takes a single param=
eter,
+			 *   the JSON returned from the server, which can be manipulated as
+			 *   required, with the returned value being that used by DataTables as=
 the
+			 *   data source for the table. This supersedes `sAjaxDataProp` from
+			 *   DataTables 1.9-.
+			 *
+			 * * `success` - Should not be overridden it is used internally in
+			 *   DataTables. To manipulate / transform the data returned by the ser=
ver
+			 *   use `ajax.dataSrc`, or use `ajax` as a function (see below).
+			 *
+			 * `function`
+			 * ----------
+			 *
+			 * As a function, making the Ajax call is left up to yourself allowing
+			 * complete control of the Ajax request. Indeed, if desired, a method o=
ther
+			 * than Ajax could be used to obtain the required data, such as Web sto=
rage
+			 * or an AIR database.
+			 *
+			 * The function is given four parameters and no return is required. The
+			 * parameters are:
+			 *
+			 * 1. _object_ - Data to send to the server
+			 * 2. _function_ - Callback function that must be executed when the req=
uired
+			 *    data has been obtained. That data should be passed into the callb=
ack
+			 *    as the only parameter
+			 * 3. _object_ - DataTables settings object for the table
+			 *
+			 * Note that this supersedes `fnServerData` from DataTables 1.9-.
+			 *
+			 *  @type string|object|function
+			 *  @default null
+			 *
+			 *  @dtopt Option
+			 *  @name DataTable.defaults.ajax
+			 *  @since 1.10.0
+			 *
+			 * @example
+			 *   // Get JSON data from a file via Ajax.
+			 *   // Note DataTables expects data in the form `{ data: [ ...data... =
] }` by default).
+			 *   $('#example').dataTable( {
+			 *     "ajax": "data.json"
+			 *   } );
+			 *
+			 * @example
+			 *   // Get JSON data from a file via Ajax, using `dataSrc` to change
+			 *   // `data` to `tableData` (i.e. `{ tableData: [ ...data... ] }`)
+			 *   $('#example').dataTable( {
+			 *     "ajax": {
+			 *       "url": "data.json",
+			 *       "dataSrc": "tableData"
+			 *     }
+			 *   } );
+			 *
+			 * @example
+			 *   // Get JSON data from a file via Ajax, using `dataSrc` to read data
+			 *   // from a plain array rather than an array in an object
+			 *   $('#example').dataTable( {
+			 *     "ajax": {
+			 *       "url": "data.json",
+			 *       "dataSrc": ""
+			 *     }
+			 *   } );
+			 *
+			 * @example
+			 *   // Manipulate the data returned from the server - add a link to da=
ta
+			 *   // (note this can, should, be done using `render` for the column -=
 this
+			 *   // is just a simple example of how the data can be manipulated).
+			 *   $('#example').dataTable( {
+			 *     "ajax": {
+			 *       "url": "data.json",
+			 *       "dataSrc": function ( json ) {
+			 *         for ( var i=3D0, ien=3Djson.length ; i<ien ; i++ ) {
+			 *           json[i][0] =3D '<a href=3D"/message/'+json[i][0]+'>View me=
ssage</a>';
+			 *         }
+			 *         return json;
+			 *       }
+			 *     }
+			 *   } );
+			 *
+			 * @example
+			 *   // Add data to the request
+			 *   $('#example').dataTable( {
+			 *     "ajax": {
+			 *       "url": "data.json",
+			 *       "data": function ( d ) {
+			 *         return {
+			 *           "extra_search": $('#extra').val()
+			 *         };
+			 *       }
+			 *     }
+			 *   } );
+			 *
+			 * @example
+			 *   // Send request as POST
+			 *   $('#example').dataTable( {
+			 *     "ajax": {
+			 *       "url": "data.json",
+			 *       "type": "POST"
+			 *     }
+			 *   } );
+			 *
+			 * @example
+			 *   // Get the data from localStorage (could interface with a form for
+			 *   // adding, editing and removing rows).
+			 *   $('#example').dataTable( {
+			 *     "ajax": function (data, callback, settings) {
+			 *       callback(
+			 *         JSON.parse( localStorage.getItem('dataTablesData') )
+			 *       );
+			 *     }
+			 *   } );
+			 */
+			"ajax": null,
+=09=09
+=09=09
+			/**
+			 * This parameter allows you to readily specify the entries in the leng=
th drop
+			 * down menu that DataTables shows when pagination is enabled. It can be
+			 * either a 1D array of options which will be used for both the display=
ed
+			 * option and the value, or a 2D array which will use the array in the =
first
+			 * position as the value, and the array in the second position as the
+			 * displayed options (useful for language strings such as 'All').
+			 *
+			 * Note that the `pageLength` property will be automatically set to the
+			 * first value given in this array, unless `pageLength` is also provide=
d.
+			 *  @type array
+			 *  @default [ 10, 25, 50, 100 ]
+			 *
+			 *  @dtopt Option
+			 *  @name DataTable.defaults.lengthMenu
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
+			 *      } );
+			 *    } );
+			 */
+			"aLengthMenu": [ 10, 25, 50, 100 ],
+=09=09
+=09=09
+			/**
+			 * The `columns` option in the initialisation parameter allows you to d=
efine
+			 * details about the way individual columns behave. For a full list of
+			 * column options that can be set, please see
+			 * {@link DataTable.defaults.column}. Note that if you use `columns` to
+			 * define your columns, you must have an entry in the array for every s=
ingle
+			 * column that you have in your table (these can be null if you don't w=
hich
+			 * to specify any options).
+			 *  @member
+			 *
+			 *  @name DataTable.defaults.column
+			 */
+			"aoColumns": null,
+=09=09
+			/**
+			 * Very similar to `columns`, `columnDefs` allows you to target a speci=
fic
+			 * column, multiple columns, or all columns, using the `targets` proper=
ty of
+			 * each object in the array. This allows great flexibility when creating
+			 * tables, as the `columnDefs` arrays can be of any length, targeting t=
he
+			 * columns you specifically want. `columnDefs` may use any of the column
+			 * options available: {@link DataTable.defaults.column}, but it _must_
+			 * have `targets` defined in each object in the array. Values in the `t=
argets`
+			 * array may be:
+			 *   <ul>
+			 *     <li>a string - class name will be matched on the TH for the colu=
mn</li>
+			 *     <li>0 or a positive integer - column index counting from the lef=
t</li>
+			 *     <li>a negative integer - column index counting from the right</l=
i>
+			 *     <li>the string "_all" - all columns (i.e. assign a default)</li>
+			 *   </ul>
+			 *  @member
+			 *
+			 *  @name DataTable.defaults.columnDefs
+			 */
+			"aoColumnDefs": null,
+=09=09
+=09=09
+			/**
+			 * Basically the same as `search`, this parameter defines the individua=
l column
+			 * filtering state at initialisation time. The array must be of the sam=
e size
+			 * as the number of columns, and each element be an object with the par=
ameters
+			 * `search` and `escapeRegex` (the latter is optional). 'null' is also
+			 * accepted and the default will be used.
+			 *  @type array
+			 *  @default []
+			 *
+			 *  @dtopt Option
+			 *  @name DataTable.defaults.searchCols
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "searchCols": [
+			 *          null,
+			 *          { "search": "My filter" },
+			 *          null,
+			 *          { "search": "^[0-9]", "escapeRegex": false }
+			 *        ]
+			 *      } );
+			 *    } )
+			 */
+			"aoSearchCols": [],
+=09=09
+=09=09
+			/**
+			 * An array of CSS classes that should be applied to displayed rows. Th=
is
+			 * array may be of any length, and DataTables will apply each class
+			 * sequentially, looping when required.
+			 *  @type array
+			 *  @default null <i>Will take the values determined by the `oClasses.s=
tripe*`
+			 *    options</i>
+			 *
+			 *  @dtopt Option
+			 *  @name DataTable.defaults.stripeClasses
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "stripeClasses": [ 'strip1', 'strip2', 'strip3' ]
+			 *      } );
+			 *    } )
+			 */
+			"asStripeClasses": null,
+=09=09
+=09=09
+			/**
+			 * Enable or disable automatic column width calculation. This can be di=
sabled
+			 * as an optimisation (it takes some time to calculate the widths) if t=
he
+			 * tables widths are passed in using `columns`.
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.autoWidth
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "autoWidth": false
+			 *      } );
+			 *    } );
+			 */
+			"bAutoWidth": true,
+=09=09
+=09=09
+			/**
+			 * Deferred rendering can provide DataTables with a huge speed boost wh=
en you
+			 * are using an Ajax or JS data source for the table. This option, when=
 set to
+			 * true, will cause DataTables to defer the creation of the table eleme=
nts for
+			 * each row until they are needed for a draw - saving a significant amo=
unt of
+			 * time.
+			 *  @type boolean
+			 *  @default false
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.deferRender
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "ajax": "sources/arrays.txt",
+			 *        "deferRender": true
+			 *      } );
+			 *    } );
+			 */
+			"bDeferRender": false,
+=09=09
+=09=09
+			/**
+			 * Replace a DataTable which matches the given selector and replace it =
with
+			 * one which has the properties of the new initialisation object passed=
. If no
+			 * table matches the selector, then the new DataTable will be construct=
ed as
+			 * per normal.
+			 *  @type boolean
+			 *  @default false
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.destroy
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "srollY": "200px",
+			 *        "paginate": false
+			 *      } );
+			 *
+			 *      // Some time later....
+			 *      $('#example').dataTable( {
+			 *        "filter": false,
+			 *        "destroy": true
+			 *      } );
+			 *    } );
+			 */
+			"bDestroy": false,
+=09=09
+=09=09
+			/**
+			 * Enable or disable filtering of data. Filtering in DataTables is "sma=
rt" in
+			 * that it allows the end user to input multiple words (space separated=
) and
+			 * will match a row containing those words, even if not in the order th=
at was
+			 * specified (this allow matching across multiple columns). Note that i=
f you
+			 * wish to use filtering in DataTables this must remain 'true' - to rem=
ove the
+			 * default filtering input box and retain filtering abilities, please u=
se
+			 * {@link DataTable.defaults.dom}.
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.searching
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "searching": false
+			 *      } );
+			 *    } );
+			 */
+			"bFilter": true,
+=09=09
+=09=09
+			/**
+			 * Enable or disable the table information display. This shows informat=
ion
+			 * about the data that is currently visible on the page, including info=
rmation
+			 * about filtered data if that action is being performed.
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.info
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "info": false
+			 *      } );
+			 *    } );
+			 */
+			"bInfo": true,
+=09=09
+=09=09
+			/**
+			 * Allows the end user to select the size of a formatted page from a se=
lect
+			 * menu (sizes are 10, 25, 50 and 100). Requires pagination (`paginate`=
).
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.lengthChange
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "lengthChange": false
+			 *      } );
+			 *    } );
+			 */
+			"bLengthChange": true,
+=09=09
+=09=09
+			/**
+			 * Enable or disable pagination.
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.paging
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "paging": false
+			 *      } );
+			 *    } );
+			 */
+			"bPaginate": true,
+=09=09
+=09=09
+			/**
+			 * Enable or disable the display of a 'processing' indicator when the t=
able is
+			 * being processed (e.g. a sort). This is particularly useful for table=
s with
+			 * large amounts of data where it can take a noticeable amount of time =
to sort
+			 * the entries.
+			 *  @type boolean
+			 *  @default false
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.processing
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "processing": true
+			 *      } );
+			 *    } );
+			 */
+			"bProcessing": false,
+=09=09
+=09=09
+			/**
+			 * Retrieve the DataTables object for the given selector. Note that if =
the
+			 * table has already been initialised, this parameter will cause DataTa=
bles
+			 * to simply return the object that has already been set up - it will n=
ot take
+			 * account of any changes you might have made to the initialisation obj=
ect
+			 * passed to DataTables (setting this parameter to true is an acknowled=
gement
+			 * that you understand this). `destroy` can be used to reinitialise a t=
able if
+			 * you need.
+			 *  @type boolean
+			 *  @default false
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.retrieve
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      initTable();
+			 *      tableActions();
+			 *    } );
+			 *
+			 *    function initTable ()
+			 *    {
+			 *      return $('#example').dataTable( {
+			 *        "scrollY": "200px",
+			 *        "paginate": false,
+			 *        "retrieve": true
+			 *      } );
+			 *    }
+			 *
+			 *    function tableActions ()
+			 *    {
+			 *      var table =3D initTable();
+			 *      // perform API operations with oTable
+			 *    }
+			 */
+			"bRetrieve": false,
+=09=09
+=09=09
+			/**
+			 * When vertical (y) scrolling is enabled, DataTables will force the he=
ight of
+			 * the table's viewport to the given height at all times (useful for la=
yout).
+			 * However, this can look odd when filtering data down to a small data =
set,
+			 * and the footer is left "floating" further down. This parameter (when
+			 * enabled) will cause DataTables to collapse the table's viewport down=
 when
+			 * the result set will fit within the given Y height.
+			 *  @type boolean
+			 *  @default false
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.scrollCollapse
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "scrollY": "200",
+			 *        "scrollCollapse": true
+			 *      } );
+			 *    } );
+			 */
+			"bScrollCollapse": false,
+=09=09
+=09=09
+			/**
+			 * Configure DataTables to use server-side processing. Note that the
+			 * `ajax` parameter must also be given in order to give DataTables a
+			 * source to obtain the required data for each draw.
+			 *  @type boolean
+			 *  @default false
+			 *
+			 *  @dtopt Features
+			 *  @dtopt Server-side
+			 *  @name DataTable.defaults.serverSide
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "serverSide": true,
+			 *        "ajax": "xhr.php"
+			 *      } );
+			 *    } );
+			 */
+			"bServerSide": false,
+=09=09
+=09=09
+			/**
+			 * Enable or disable sorting of columns. Sorting of individual columns =
can be
+			 * disabled by the `sortable` option for each column.
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.ordering
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "ordering": false
+			 *      } );
+			 *    } );
+			 */
+			"bSort": true,
+=09=09
+=09=09
+			/**
+			 * Enable or display DataTables' ability to sort multiple columns at the
+			 * same time (activated by shift-click by the user).
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.orderMulti
+			 *
+			 *  @example
+			 *    // Disable multiple column sorting ability
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "orderMulti": false
+			 *      } );
+			 *    } );
+			 */
+			"bSortMulti": true,
+=09=09
+=09=09
+			/**
+			 * Allows control over whether DataTables should use the top (true) uni=
que
+			 * cell that is found for a single column, or the bottom (false - defau=
lt).
+			 * This is useful when using complex headers.
+			 *  @type boolean
+			 *  @default false
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.orderCellsTop
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "orderCellsTop": true
+			 *      } );
+			 *    } );
+			 */
+			"bSortCellsTop": false,
+=09=09
+=09=09
+			/**
+			 * Enable or disable the addition of the classes `sorting\_1`, `sorting=
\_2` and
+			 * `sorting\_3` to the columns which are currently being sorted on. Thi=
s is
+			 * presented as a feature switch as it can increase processing time (wh=
ile
+			 * classes are removed and added) so for large data sets you might want=
 to
+			 * turn this off.
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.orderClasses
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "orderClasses": false
+			 *      } );
+			 *    } );
+			 */
+			"bSortClasses": true,
+=09=09
+=09=09
+			/**
+			 * Enable or disable state saving. When enabled HTML5 `localStorage` wi=
ll be
+			 * used to save table display information such as pagination informatio=
n,
+			 * display length, filtering and sorting. As such when the end user rel=
oads
+			 * the page the display display will match what thy had previously set =
up.
+			 *
+			 * Due to the use of `localStorage` the default state saving is not sup=
ported
+			 * in IE6 or 7. If state saving is required in those browsers, use
+			 * `stateSaveCallback` to provide a storage solution such as cookies.
+			 *  @type boolean
+			 *  @default false
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.stateSave
+			 *
+			 *  @example
+			 *    $(document).ready( function () {
+			 *      $('#example').dataTable( {
+			 *        "stateSave": true
+			 *      } );
+			 *    } );
+			 */
+			"bStateSave": false,
+=09=09
+=09=09
+			/**
+			 * This function is called when a TR element is created (and all TD chi=
ld
+			 * elements have been inserted), or registered if using a DOM source, a=
llowing
+			 * manipulation of the TR element (adding classes etc).
+			 *  @type function
+			 *  @param {node} row "TR" element for the current row
+			 *  @param {array} data Raw data array for this row
+			 *  @param {int} dataIndex The index of this row in the internal aoData=
 array
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.createdRow
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "createdRow": function( row, data, dataIndex ) {
+			 *          // Bold the grade for all 'A' grade browsers
+			 *          if ( data[4] =3D=3D "A" )
+			 *          {
+			 *            $('td:eq(4)', row).html( '<b>A</b>' );
+			 *          }
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"fnCreatedRow": null,
+=09=09
+=09=09
+			/**
+			 * This function is called on every 'draw' event, and allows you to
+			 * dynamically modify any aspect you want about the created DOM.
+			 *  @type function
+			 *  @param {object} settings DataTables settings object
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.drawCallback
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "drawCallback": function( settings ) {
+			 *          alert( 'DataTables has redrawn the table' );
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"fnDrawCallback": null,
+=09=09
+=09=09
+			/**
+			 * Identical to fnHeaderCallback() but for the table footer this functi=
on
+			 * allows you to modify the table footer on every 'draw' event.
+			 *  @type function
+			 *  @param {node} foot "TR" element for the footer
+			 *  @param {array} data Full table data (as derived from the original H=
TML)
+			 *  @param {int} start Index for the current display starting point in =
the
+			 *    display array
+			 *  @param {int} end Index for the current display ending point in the
+			 *    display array
+			 *  @param {array int} display Index array to translate the visual posi=
tion
+			 *    to the full data array
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.footerCallback
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "footerCallback": function( tfoot, data, start, end, display =
) {
+			 *          tfoot.getElementsByTagName('th')[0].innerHTML =3D "Starting=
 index is "+start;
+			 *        }
+			 *      } );
+			 *    } )
+			 */
+			"fnFooterCallback": null,
+=09=09
+=09=09
+			/**
+			 * When rendering large numbers in the information element for the table
+			 * (i.e. "Showing 1 to 10 of 57 entries") DataTables will render large =
numbers
+			 * to have a comma separator for the 'thousands' units (e.g. 1 million =
is
+			 * rendered as "1,000,000") to help readability for the end user. This
+			 * function will override the default method DataTables uses.
+			 *  @type function
+			 *  @member
+			 *  @param {int} toFormat number to be formatted
+			 *  @returns {string} formatted string for DataTables to show the number
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.formatNumber
+			 *
+			 *  @example
+			 *    // Format a number using a single quote for the separator (note t=
hat
+			 *    // this can also be done with the language.thousands option)
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "formatNumber": function ( toFormat ) {
+			 *          return toFormat.toString().replace(
+			 *            /\B(?=3D(\d{3})+(?!\d))/g, "'"
+			 *          );
+			 *        };
+			 *      } );
+			 *    } );
+			 */
+			"fnFormatNumber": function ( toFormat ) {
+				return toFormat.toString().replace(
+					/\B(?=3D(\d{3})+(?!\d))/g,
+					this.oLanguage.sThousands
+				);
+			},
+=09=09
+=09=09
+			/**
+			 * This function is called on every 'draw' event, and allows you to
+			 * dynamically modify the header row. This can be used to calculate and
+			 * display useful information about the table.
+			 *  @type function
+			 *  @param {node} head "TR" element for the header
+			 *  @param {array} data Full table data (as derived from the original H=
TML)
+			 *  @param {int} start Index for the current display starting point in =
the
+			 *    display array
+			 *  @param {int} end Index for the current display ending point in the
+			 *    display array
+			 *  @param {array int} display Index array to translate the visual posi=
tion
+			 *    to the full data array
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.headerCallback
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "fheaderCallback": function( head, data, start, end, display =
) {
+			 *          head.getElementsByTagName('th')[0].innerHTML =3D "Displayin=
g "+(end-start)+" records";
+			 *        }
+			 *      } );
+			 *    } )
+			 */
+			"fnHeaderCallback": null,
+=09=09
+=09=09
+			/**
+			 * The information element can be used to convey information about the =
current
+			 * state of the table. Although the internationalisation options presen=
ted by
+			 * DataTables are quite capable of dealing with most customisations, th=
ere may
+			 * be times where you wish to customise the string further. This callba=
ck
+			 * allows you to do exactly that.
+			 *  @type function
+			 *  @param {object} oSettings DataTables settings object
+			 *  @param {int} start Starting position in data for the draw
+			 *  @param {int} end End position in data for the draw
+			 *  @param {int} max Total number of rows in the table (regardless of
+			 *    filtering)
+			 *  @param {int} total Total number of rows in the data set, after filt=
ering
+			 *  @param {string} pre The string that DataTables has formatted using =
it's
+			 *    own rules
+			 *  @returns {string} The string to be displayed in the information ele=
ment.
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.infoCallback
+			 *
+			 *  @example
+			 *    $('#example').dataTable( {
+			 *      "infoCallback": function( settings, start, end, max, total, pre=
 ) {
+			 *        return start +" to "+ end;
+			 *      }
+			 *    } );
+			 */
+			"fnInfoCallback": null,
+=09=09
+=09=09
+			/**
+			 * Called when the table has been initialised. Normally DataTables will
+			 * initialise sequentially and there will be no need for this function,
+			 * however, this does not hold true when using external language inform=
ation
+			 * since that is obtained using an async XHR call.
+			 *  @type function
+			 *  @param {object} settings DataTables settings object
+			 *  @param {object} json The JSON object request from the server - only
+			 *    present if client-side Ajax sourced data is used
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.initComplete
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "initComplete": function(settings, json) {
+			 *          alert( 'DataTables has finished its initialisation.' );
+			 *        }
+			 *      } );
+			 *    } )
+			 */
+			"fnInitComplete": null,
+=09=09
+=09=09
+			/**
+			 * Called at the very start of each table draw and can be used to cance=
l the
+			 * draw by returning false, any other return (including undefined) resu=
lts in
+			 * the full draw occurring).
+			 *  @type function
+			 *  @param {object} settings DataTables settings object
+			 *  @returns {boolean} False will cancel the draw, anything else (inclu=
ding no
+			 *    return) will allow it to complete.
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.preDrawCallback
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "preDrawCallback": function( settings ) {
+			 *          if ( $('#test').val() =3D=3D 1 ) {
+			 *            return false;
+			 *          }
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"fnPreDrawCallback": null,
+=09=09
+=09=09
+			/**
+			 * This function allows you to 'post process' each row after it have be=
en
+			 * generated for each table draw, but before it is rendered on screen. =
This
+			 * function might be used for setting the row class name etc.
+			 *  @type function
+			 *  @param {node} row "TR" element for the current row
+			 *  @param {array} data Raw data array for this row
+			 *  @param {int} displayIndex The display index for the current table d=
raw
+			 *  @param {int} displayIndexFull The index of the data in the full lis=
t of
+			 *    rows (after filtering)
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.rowCallback
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "rowCallback": function( row, data, displayIndex, displayInde=
xFull ) {
+			 *          // Bold the grade for all 'A' grade browsers
+			 *          if ( data[4] =3D=3D "A" ) {
+			 *            $('td:eq(4)', row).html( '<b>A</b>' );
+			 *          }
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"fnRowCallback": null,
+=09=09
+=09=09
+			/**
+			 * __Deprecated__ The functionality provided by this parameter has now =
been
+			 * superseded by that provided through `ajax`, which should be used ins=
tead.
+			 *
+			 * This parameter allows you to override the default function which obt=
ains
+			 * the data from the server so something more suitable for your applica=
tion.
+			 * For example you could use POST data, or pull information from a Gear=
s or
+			 * AIR database.
+			 *  @type function
+			 *  @member
+			 *  @param {string} source HTTP source to obtain the data from (`ajax`)
+			 *  @param {array} data A key/value pair object containing the data to =
send
+			 *    to the server
+			 *  @param {function} callback to be called on completion of the data g=
et
+			 *    process that will draw the data on the page.
+			 *  @param {object} settings DataTables settings object
+			 *
+			 *  @dtopt Callbacks
+			 *  @dtopt Server-side
+			 *  @name DataTable.defaults.serverData
+			 *
+			 *  @deprecated 1.10. Please use `ajax` for this functionality now.
+			 */
+			"fnServerData": null,
+=09=09
+=09=09
+			/**
+			 * __Deprecated__ The functionality provided by this parameter has now =
been
+			 * superseded by that provided through `ajax`, which should be used ins=
tead.
+			 *
+			 *  It is often useful to send extra data to the server when making an =
Ajax
+			 * request - for example custom filtering information, and this callback
+			 * function makes it trivial to send extra information to the server. T=
he
+			 * passed in parameter is the data set that has been constructed by
+			 * DataTables, and you can add to this or modify it as you require.
+			 *  @type function
+			 *  @param {array} data Data array (array of objects which are name/val=
ue
+			 *    pairs) that has been constructed by DataTables and will be sent t=
o the
+			 *    server. In the case of Ajax sourced data with server-side process=
ing
+			 *    this will be an empty array, for server-side processing there wil=
l be a
+			 *    significant number of parameters!
+			 *  @returns {undefined} Ensure that you modify the data array passed i=
n,
+			 *    as this is passed by reference.
+			 *
+			 *  @dtopt Callbacks
+			 *  @dtopt Server-side
+			 *  @name DataTable.defaults.serverParams
+			 *
+			 *  @deprecated 1.10. Please use `ajax` for this functionality now.
+			 */
+			"fnServerParams": null,
+=09=09
+=09=09
+			/**
+			 * Load the table state. With this function you can define from where, =
and how, the
+			 * state of a table is loaded. By default DataTables will load from `lo=
calStorage`
+			 * but you might wish to use a server-side database or cookies.
+			 *  @type function
+			 *  @member
+			 *  @param {object} settings DataTables settings object
+			 *  @param {object} callback Callback that can be executed when done. It
+			 *    should be passed the loaded state object.
+			 *  @return {object} The DataTables state object to be loaded
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.stateLoadCallback
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "stateSave": true,
+			 *        "stateLoadCallback": function (settings, callback) {
+			 *          $.ajax( {
+			 *            "url": "/state_load",
+			 *            "dataType": "json",
+			 *            "success": function (json) {
+			 *              callback( json );
+			 *            }
+			 *          } );
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"fnStateLoadCallback": function ( settings ) {
+				try {
+					return JSON.parse(
+						(settings.iStateDuration =3D=3D=3D -1 ? sessionStorage : localStorag=
e).getItem(
+							'DataTables_'+settings.sInstance+'_'+location.pathname
+						)
+					);
+				} catch (e) {
+					return {};
+				}
+			},
+=09=09
+=09=09
+			/**
+			 * Callback which allows modification of the saved state prior to loadi=
ng that state.
+			 * This callback is called when the table is loading state from the sto=
red data, but
+			 * prior to the settings object being modified by the saved state. Note=
 that for
+			 * plug-in authors, you should use the `stateLoadParams` event to load =
parameters for
+			 * a plug-in.
+			 *  @type function
+			 *  @param {object} settings DataTables settings object
+			 *  @param {object} data The state object that is to be loaded
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.stateLoadParams
+			 *
+			 *  @example
+			 *    // Remove a saved filter, so filtering is never loaded
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "stateSave": true,
+			 *        "stateLoadParams": function (settings, data) {
+			 *          data.oSearch.sSearch =3D "";
+			 *        }
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Disallow state loading by returning false
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "stateSave": true,
+			 *        "stateLoadParams": function (settings, data) {
+			 *          return false;
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"fnStateLoadParams": null,
+=09=09
+=09=09
+			/**
+			 * Callback that is called when the state has been loaded from the stat=
e saving method
+			 * and the DataTables settings object has been modified as a result of =
the loaded state.
+			 *  @type function
+			 *  @param {object} settings DataTables settings object
+			 *  @param {object} data The state object that was loaded
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.stateLoaded
+			 *
+			 *  @example
+			 *    // Show an alert with the filtering value that was saved
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "stateSave": true,
+			 *        "stateLoaded": function (settings, data) {
+			 *          alert( 'Saved filter was: '+data.oSearch.sSearch );
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"fnStateLoaded": null,
+=09=09
+=09=09
+			/**
+			 * Save the table state. This function allows you to define where and h=
ow the state
+			 * information for the table is stored By default DataTables will use `=
localStorage`
+			 * but you might wish to use a server-side database or cookies.
+			 *  @type function
+			 *  @member
+			 *  @param {object} settings DataTables settings object
+			 *  @param {object} data The state object to be saved
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.stateSaveCallback
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "stateSave": true,
+			 *        "stateSaveCallback": function (settings, data) {
+			 *          // Send an Ajax request to the server with the state object
+			 *          $.ajax( {
+			 *            "url": "/state_save",
+			 *            "data": data,
+			 *            "dataType": "json",
+			 *            "method": "POST"
+			 *            "success": function () {}
+			 *          } );
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"fnStateSaveCallback": function ( settings, data ) {
+				try {
+					(settings.iStateDuration =3D=3D=3D -1 ? sessionStorage : localStorage=
).setItem(
+						'DataTables_'+settings.sInstance+'_'+location.pathname,
+						JSON.stringify( data )
+					);
+				} catch (e) {}
+			},
+=09=09
+=09=09
+			/**
+			 * Callback which allows modification of the state to be saved. Called =
when the table
+			 * has changed state a new state save is required. This method allows m=
odification of
+			 * the state saving object prior to actually doing the save, including =
addition or
+			 * other state properties or modification. Note that for plug-in author=
s, you should
+			 * use the `stateSaveParams` event to save parameters for a plug-in.
+			 *  @type function
+			 *  @param {object} settings DataTables settings object
+			 *  @param {object} data The state object to be saved
+			 *
+			 *  @dtopt Callbacks
+			 *  @name DataTable.defaults.stateSaveParams
+			 *
+			 *  @example
+			 *    // Remove a saved filter, so filtering is never saved
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "stateSave": true,
+			 *        "stateSaveParams": function (settings, data) {
+			 *          data.oSearch.sSearch =3D "";
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"fnStateSaveParams": null,
+=09=09
+=09=09
+			/**
+			 * Duration for which the saved state information is considered valid. =
After this period
+			 * has elapsed the state will be returned to the default.
+			 * Value is given in seconds.
+			 *  @type int
+			 *  @default 7200 <i>(2 hours)</i>
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.stateDuration
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "stateDuration": 60*60*24; // 1 day
+			 *      } );
+			 *    } )
+			 */
+			"iStateDuration": 7200,
+=09=09
+=09=09
+			/**
+			 * When enabled DataTables will not make a request to the server for th=
e first
+			 * page draw - rather it will use the data already on the page (no sort=
ing etc
+			 * will be applied to it), thus saving on an XHR at load time. `deferLo=
ading`
+			 * is used to indicate that deferred loading is required, but it is als=
o used
+			 * to tell DataTables how many records there are in the full table (all=
owing
+			 * the information element and pagination to be displayed correctly). I=
n the case
+			 * where a filtering is applied to the table on initial load, this can =
be
+			 * indicated by giving the parameter as an array, where the first eleme=
nt is
+			 * the number of records available after filtering and the second eleme=
nt is the
+			 * number of records without filtering (allowing the table information =
element
+			 * to be shown correctly).
+			 *  @type int | array
+			 *  @default null
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.deferLoading
+			 *
+			 *  @example
+			 *    // 57 records available in the table, no filtering applied
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "serverSide": true,
+			 *        "ajax": "scripts/server_processing.php",
+			 *        "deferLoading": 57
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // 57 records after filtering, 100 without filtering (an initial =
filter applied)
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "serverSide": true,
+			 *        "ajax": "scripts/server_processing.php",
+			 *        "deferLoading": [ 57, 100 ],
+			 *        "search": {
+			 *          "search": "my_filter"
+			 *        }
+			 *      } );
+			 *    } );
+			 */
+			"iDeferLoading": null,
+=09=09
+=09=09
+			/**
+			 * Number of rows to display on a single page when using pagination. If
+			 * feature enabled (`lengthChange`) then the end user will be able to o=
verride
+			 * this to a custom setting using a pop-up menu.
+			 *  @type int
+			 *  @default 10
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.pageLength
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "pageLength": 50
+			 *      } );
+			 *    } )
+			 */
+			"iDisplayLength": 10,
+=09=09
+=09=09
+			/**
+			 * Define the starting point for data display when using DataTables with
+			 * pagination. Note that this parameter is the number of records, rathe=
r than
+			 * the page number, so if you have 10 records per page and want to star=
t on
+			 * the third page, it should be "20".
+			 *  @type int
+			 *  @default 0
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.displayStart
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "displayStart": 20
+			 *      } );
+			 *    } )
+			 */
+			"iDisplayStart": 0,
+=09=09
+=09=09
+			/**
+			 * By default DataTables allows keyboard navigation of the table (sorti=
ng, paging,
+			 * and filtering) by adding a `tabindex` attribute to the required elem=
ents. This
+			 * allows you to tab through the controls and press the enter key to ac=
tivate them.
+			 * The tabindex is default 0, meaning that the tab follows the flow of =
the document.
+			 * You can overrule this using this parameter if you wish. Use a value =
of -1 to
+			 * disable built-in keyboard navigation.
+			 *  @type int
+			 *  @default 0
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.tabIndex
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "tabIndex": 1
+			 *      } );
+			 *    } );
+			 */
+			"iTabIndex": 0,
+=09=09
+=09=09
+			/**
+			 * Classes that DataTables assigns to the various components and featur=
es
+			 * that it adds to the HTML table. This allows classes to be configured
+			 * during initialisation in addition to through the static
+			 * {@link DataTable.ext.oStdClasses} object).
+			 *  @namespace
+			 *  @name DataTable.defaults.classes
+			 */
+			"oClasses": {},
+=09=09
+=09=09
+			/**
+			 * All strings that DataTables uses in the user interface that it creat=
es
+			 * are defined in this object, allowing you to modified them individual=
ly or
+			 * completely replace them all as required.
+			 *  @namespace
+			 *  @name DataTable.defaults.language
+			 */
+			"oLanguage": {
+				/**
+				 * Strings that are used for WAI-ARIA labels and controls only (these =
are not
+				 * actually visible on the page, but will be read by screenreaders, an=
d thus
+				 * must be internationalised as well).
+				 *  @namespace
+				 *  @name DataTable.defaults.language.aria
+				 */
+				"oAria": {
+					/**
+					 * ARIA label that is added to the table headers when the column may =
be
+					 * sorted ascending by activing the column (click or return when focu=
sed).
+					 * Note that the column header is prefixed to this string.
+					 *  @type string
+					 *  @default : activate to sort column ascending
+					 *
+					 *  @dtopt Language
+					 *  @name DataTable.defaults.language.aria.sortAscending
+					 *
+					 *  @example
+					 *    $(document).ready( function() {
+					 *      $('#example').dataTable( {
+					 *        "language": {
+					 *          "aria": {
+					 *            "sortAscending": " - click/return to sort ascending"
+					 *          }
+					 *        }
+					 *      } );
+					 *    } );
+					 */
+					"sSortAscending": ": activate to sort column ascending",
+=09=09
+					/**
+					 * ARIA label that is added to the table headers when the column may =
be
+					 * sorted descending by activing the column (click or return when foc=
used).
+					 * Note that the column header is prefixed to this string.
+					 *  @type string
+					 *  @default : activate to sort column ascending
+					 *
+					 *  @dtopt Language
+					 *  @name DataTable.defaults.language.aria.sortDescending
+					 *
+					 *  @example
+					 *    $(document).ready( function() {
+					 *      $('#example').dataTable( {
+					 *        "language": {
+					 *          "aria": {
+					 *            "sortDescending": " - click/return to sort descending"
+					 *          }
+					 *        }
+					 *      } );
+					 *    } );
+					 */
+					"sSortDescending": ": activate to sort column descending"
+				},
+=09=09
+				/**
+				 * Pagination string used by DataTables for the built-in pagination
+				 * control types.
+				 *  @namespace
+				 *  @name DataTable.defaults.language.paginate
+				 */
+				"oPaginate": {
+					/**
+					 * Text to use when using the 'full_numbers' type of pagination for t=
he
+					 * button to take the user to the first page.
+					 *  @type string
+					 *  @default First
+					 *
+					 *  @dtopt Language
+					 *  @name DataTable.defaults.language.paginate.first
+					 *
+					 *  @example
+					 *    $(document).ready( function() {
+					 *      $('#example').dataTable( {
+					 *        "language": {
+					 *          "paginate": {
+					 *            "first": "First page"
+					 *          }
+					 *        }
+					 *      } );
+					 *    } );
+					 */
+					"sFirst": "First",
+=09=09
+=09=09
+					/**
+					 * Text to use when using the 'full_numbers' type of pagination for t=
he
+					 * button to take the user to the last page.
+					 *  @type string
+					 *  @default Last
+					 *
+					 *  @dtopt Language
+					 *  @name DataTable.defaults.language.paginate.last
+					 *
+					 *  @example
+					 *    $(document).ready( function() {
+					 *      $('#example').dataTable( {
+					 *        "language": {
+					 *          "paginate": {
+					 *            "last": "Last page"
+					 *          }
+					 *        }
+					 *      } );
+					 *    } );
+					 */
+					"sLast": "Last",
+=09=09
+=09=09
+					/**
+					 * Text to use for the 'next' pagination button (to take the user to =
the
+					 * next page).
+					 *  @type string
+					 *  @default Next
+					 *
+					 *  @dtopt Language
+					 *  @name DataTable.defaults.language.paginate.next
+					 *
+					 *  @example
+					 *    $(document).ready( function() {
+					 *      $('#example').dataTable( {
+					 *        "language": {
+					 *          "paginate": {
+					 *            "next": "Next page"
+					 *          }
+					 *        }
+					 *      } );
+					 *    } );
+					 */
+					"sNext": "Next",
+=09=09
+=09=09
+					/**
+					 * Text to use for the 'previous' pagination button (to take the user=
 to
+					 * the previous page).
+					 *  @type string
+					 *  @default Previous
+					 *
+					 *  @dtopt Language
+					 *  @name DataTable.defaults.language.paginate.previous
+					 *
+					 *  @example
+					 *    $(document).ready( function() {
+					 *      $('#example').dataTable( {
+					 *        "language": {
+					 *          "paginate": {
+					 *            "previous": "Previous page"
+					 *          }
+					 *        }
+					 *      } );
+					 *    } );
+					 */
+					"sPrevious": "Previous"
+				},
+=09=09
+				/**
+				 * This string is shown in preference to `zeroRecords` when the table =
is
+				 * empty of data (regardless of filtering). Note that this is an optio=
nal
+				 * parameter - if it is not given, the value of `zeroRecords` will be =
used
+				 * instead (either the default or given value).
+				 *  @type string
+				 *  @default No data available in table
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.emptyTable
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "emptyTable": "No data available in table"
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sEmptyTable": "No data available in table",
+=09=09
+=09=09
+				/**
+				 * This string gives information to the end user about the information
+				 * that is current on display on the page. The following tokens can be
+				 * used in the string and will be dynamically replaced as the table
+				 * display updates. This tokens can be placed anywhere in the string, =
or
+				 * removed as needed by the language requires:
+				 *
+				 * * `\_START\_` - Display index of the first record on the current pa=
ge
+				 * * `\_END\_` - Display index of the last record on the current page
+				 * * `\_TOTAL\_` - Number of records in the table after filtering
+				 * * `\_MAX\_` - Number of records in the table without filtering
+				 * * `\_PAGE\_` - Current page number
+				 * * `\_PAGES\_` - Total number of pages of data in the table
+				 *
+				 *  @type string
+				 *  @default Showing _START_ to _END_ of _TOTAL_ entries
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.info
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "info": "Showing page _PAGE_ of _PAGES_"
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sInfo": "Showing _START_ to _END_ of _TOTAL_ entries",
+=09=09
+=09=09
+				/**
+				 * Display information string for when the table is empty. Typically t=
he
+				 * format of this string should match `info`.
+				 *  @type string
+				 *  @default Showing 0 to 0 of 0 entries
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.infoEmpty
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "infoEmpty": "No entries to show"
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sInfoEmpty": "Showing 0 to 0 of 0 entries",
+=09=09
+=09=09
+				/**
+				 * When a user filters the information in a table, this string is appe=
nded
+				 * to the information (`info`) to give an idea of how strong the filte=
ring
+				 * is. The variable _MAX_ is dynamically updated.
+				 *  @type string
+				 *  @default (filtered from _MAX_ total entries)
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.infoFiltered
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "infoFiltered": " - filtering from _MAX_ records"
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sInfoFiltered": "(filtered from _MAX_ total entries)",
+=09=09
+=09=09
+				/**
+				 * If can be useful to append extra information to the info string at =
times,
+				 * and this variable does exactly that. This information will be appen=
ded to
+				 * the `info` (`infoEmpty` and `infoFiltered` in whatever combination =
they are
+				 * being used) at all times.
+				 *  @type string
+				 *  @default <i>Empty string</i>
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.infoPostFix
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "infoPostFix": "All records shown are derived from real in=
formation."
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sInfoPostFix": "",
+=09=09
+=09=09
+				/**
+				 * This decimal place operator is a little different from the other
+				 * language options since DataTables doesn't output floating point
+				 * numbers, so it won't ever use this for display of a number. Rather,
+				 * what this parameter does is modify the sort methods of the table so
+				 * that numbers which are in a format which has a character other than
+				 * a period (`.`) as a decimal place will be sorted numerically.
+				 *
+				 * Note that numbers with different decimal places cannot be shown in
+				 * the same table and still be sortable, the table must be consistent.
+				 * However, multiple different tables on the page can use different
+				 * decimal place characters.
+				 *  @type string
+				 *  @default=20
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.decimal
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "decimal": ","
+				 *          "thousands": "."
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sDecimal": "",
+=09=09
+=09=09
+				/**
+				 * DataTables has a build in number formatter (`formatNumber`) which is
+				 * used to format large numbers that are used in the table information.
+				 * By default a comma is used, but this can be trivially changed to any
+				 * character you wish with this parameter.
+				 *  @type string
+				 *  @default ,
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.thousands
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "thousands": "'"
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sThousands": ",",
+=09=09
+=09=09
+				/**
+				 * Detail the action that will be taken when the drop down menu for the
+				 * pagination length option is changed. The '_MENU_' variable is repla=
ced
+				 * with a default select list of 10, 25, 50 and 100, and can be replac=
ed
+				 * with a custom select box if required.
+				 *  @type string
+				 *  @default Show _MENU_ entries
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.lengthMenu
+				 *
+				 *  @example
+				 *    // Language change only
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "lengthMenu": "Display _MENU_ records"
+				 *        }
+				 *      } );
+				 *    } );
+				 *
+				 *  @example
+				 *    // Language and options change
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "lengthMenu": 'Display <select>'+
+				 *            '<option value=3D"10">10</option>'+
+				 *            '<option value=3D"20">20</option>'+
+				 *            '<option value=3D"30">30</option>'+
+				 *            '<option value=3D"40">40</option>'+
+				 *            '<option value=3D"50">50</option>'+
+				 *            '<option value=3D"-1">All</option>'+
+				 *            '</select> records'
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sLengthMenu": "Show _MENU_ entries",
+=09=09
+=09=09
+				/**
+				 * When using Ajax sourced data and during the first draw when DataTab=
les is
+				 * gathering the data, this message is shown in an empty row in the ta=
ble to
+				 * indicate to the end user the the data is being loaded. Note that th=
is
+				 * parameter is not used when loading data by server-side processing, =
just
+				 * Ajax sourced data with client-side processing.
+				 *  @type string
+				 *  @default Loading...
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.loadingRecords
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "loadingRecords": "Please wait - loading..."
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sLoadingRecords": "Loading...",
+=09=09
+=09=09
+				/**
+				 * Text which is displayed when the table is processing a user action
+				 * (usually a sort command or similar).
+				 *  @type string
+				 *  @default Processing...
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.processing
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "processing": "DataTables is currently busy"
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sProcessing": "Processing...",
+=09=09
+=09=09
+				/**
+				 * Details the actions that will be taken when the user types into the
+				 * filtering input text box. The variable "_INPUT_", if used in the st=
ring,
+				 * is replaced with the HTML text box for the filtering input allowing
+				 * control over where it appears in the string. If "_INPUT_" is not gi=
ven
+				 * then the input box is appended to the string automatically.
+				 *  @type string
+				 *  @default Search:
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.search
+				 *
+				 *  @example
+				 *    // Input text box will be appended at the end automatically
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "search": "Filter records:"
+				 *        }
+				 *      } );
+				 *    } );
+				 *
+				 *  @example
+				 *    // Specify where the filter should appear
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "search": "Apply filter _INPUT_ to table"
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sSearch": "Search:",
+=09=09
+=09=09
+				/**
+				 * Assign a `placeholder` attribute to the search `input` element
+				 *  @type string
+				 *  @default=20
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.searchPlaceholder
+				 */
+				"sSearchPlaceholder": "",
+=09=09
+=09=09
+				/**
+				 * All of the language information can be stored in a file on the
+				 * server-side, which DataTables will look up if this parameter is pas=
sed.
+				 * It must store the URL of the language file, which is in a JSON form=
at,
+				 * and the object has the same properties as the oLanguage object in t=
he
+				 * initialiser object (i.e. the above parameters). Please refer to one=
 of
+				 * the example language files to see how this works in action.
+				 *  @type string
+				 *  @default <i>Empty string - i.e. disabled</i>
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.url
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "url": "http://www.sprymedia.co.uk/dataTables/lang.txt"
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sUrl": "",
+=09=09
+=09=09
+				/**
+				 * Text shown inside the table records when the is no information to be
+				 * displayed after filtering. `emptyTable` is shown when there is simp=
ly no
+				 * information in the table at all (regardless of filtering).
+				 *  @type string
+				 *  @default No matching records found
+				 *
+				 *  @dtopt Language
+				 *  @name DataTable.defaults.language.zeroRecords
+				 *
+				 *  @example
+				 *    $(document).ready( function() {
+				 *      $('#example').dataTable( {
+				 *        "language": {
+				 *          "zeroRecords": "No records to display"
+				 *        }
+				 *      } );
+				 *    } );
+				 */
+				"sZeroRecords": "No matching records found"
+			},
+=09=09
+=09=09
+			/**
+			 * This parameter allows you to have define the global filtering state =
at
+			 * initialisation time. As an object the `search` parameter must be
+			 * defined, but all other parameters are optional. When `regex` is true,
+			 * the search string will be treated as a regular expression, when false
+			 * (default) it will be treated as a straight string. When `smart`
+			 * DataTables will use it's smart filtering methods (to word match at
+			 * any point in the data), when false this will not be done.
+			 *  @namespace
+			 *  @extends DataTable.models.oSearch
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.search
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "search": {"search": "Initial search"}
+			 *      } );
+			 *    } )
+			 */
+			"oSearch": $.extend( {}, DataTable.models.oSearch ),
+=09=09
+=09=09
+			/**
+			 * __Deprecated__ The functionality provided by this parameter has now =
been
+			 * superseded by that provided through `ajax`, which should be used ins=
tead.
+			 *
+			 * By default DataTables will look for the property `data` (or `aaData`=
 for
+			 * compatibility with DataTables 1.9-) when obtaining data from an Ajax
+			 * source or for server-side processing - this parameter allows that
+			 * property to be changed. You can use Javascript dotted object notatio=
n to
+			 * get a data source for multiple levels of nesting.
+			 *  @type string
+			 *  @default data
+			 *
+			 *  @dtopt Options
+			 *  @dtopt Server-side
+			 *  @name DataTable.defaults.ajaxDataProp
+			 *
+			 *  @deprecated 1.10. Please use `ajax` for this functionality now.
+			 */
+			"sAjaxDataProp": "data",
+=09=09
+=09=09
+			/**
+			 * __Deprecated__ The functionality provided by this parameter has now =
been
+			 * superseded by that provided through `ajax`, which should be used ins=
tead.
+			 *
+			 * You can instruct DataTables to load data from an external
+			 * source using this parameter (use aData if you want to pass data in y=
ou
+			 * already have). Simply provide a url a JSON object can be obtained fr=
om.
+			 *  @type string
+			 *  @default null
+			 *
+			 *  @dtopt Options
+			 *  @dtopt Server-side
+			 *  @name DataTable.defaults.ajaxSource
+			 *
+			 *  @deprecated 1.10. Please use `ajax` for this functionality now.
+			 */
+			"sAjaxSource": null,
+=09=09
+=09=09
+			/**
+			 * This initialisation variable allows you to specify exactly where in =
the
+			 * DOM you want DataTables to inject the various controls it adds to th=
e page
+			 * (for example you might want the pagination controls at the top of the
+			 * table). DIV elements (with or without a custom class) can also be ad=
ded to
+			 * aid styling. The follow syntax is used:
+			 *   <ul>
+			 *     <li>The following options are allowed:
+			 *       <ul>
+			 *         <li>'l' - Length changing</li>
+			 *         <li>'f' - Filtering input</li>
+			 *         <li>'t' - The table!</li>
+			 *         <li>'i' - Information</li>
+			 *         <li>'p' - Pagination</li>
+			 *         <li>'r' - pRocessing</li>
+			 *       </ul>
+			 *     </li>
+			 *     <li>The following constants are allowed:
+			 *       <ul>
+			 *         <li>'H' - jQueryUI theme "header" classes ('fg-toolbar ui-wi=
dget-header ui-corner-tl ui-corner-tr ui-helper-clearfix')</li>
+			 *         <li>'F' - jQueryUI theme "footer" classes ('fg-toolbar ui-wi=
dget-header ui-corner-bl ui-corner-br ui-helper-clearfix')</li>
+			 *       </ul>
+			 *     </li>
+			 *     <li>The following syntax is expected:
+			 *       <ul>
+			 *         <li>'&lt;' and '&gt;' - div elements</li>
+			 *         <li>'&lt;"class" and '&gt;' - div with a class</li>
+			 *         <li>'&lt;"#id" and '&gt;' - div with an ID</li>
+			 *       </ul>
+			 *     </li>
+			 *     <li>Examples:
+			 *       <ul>
+			 *         <li>'&lt;"wrapper"flipt&gt;'</li>
+			 *         <li>'&lt;lf&lt;t&gt;ip&gt;'</li>
+			 *       </ul>
+			 *     </li>
+			 *   </ul>
+			 *  @type string
+			 *  @default lfrtip <i>(when `jQueryUI` is false)</i> <b>or</b>
+			 *    <"H"lfr>t<"F"ip> <i>(when `jQueryUI` is true)</i>
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.dom
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "dom": '&lt;"top"i&gt;rt&lt;"bottom"flp&gt;&lt;"clear"&gt;'
+			 *      } );
+			 *    } );
+			 */
+			"sDom": "lfrtip",
+=09=09
+=09=09
+			/**
+			 * Search delay option. This will throttle full table searches that use=
 the
+			 * DataTables provided search input element (it does not effect calls to
+			 * `dt-api search()`, providing a delay before the search is made.
+			 *  @type integer
+			 *  @default 0
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.searchDelay
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "searchDelay": 200
+			 *      } );
+			 *    } )
+			 */
+			"searchDelay": null,
+=09=09
+=09=09
+			/**
+			 * DataTables features six different built-in options for the buttons to
+			 * display for pagination control:
+			 *
+			 * * `numbers` - Page number buttons only
+			 * * `simple` - 'Previous' and 'Next' buttons only
+			 * * 'simple_numbers` - 'Previous' and 'Next' buttons, plus page numbers
+			 * * `full` - 'First', 'Previous', 'Next' and 'Last' buttons
+			 * * `full_numbers` - 'First', 'Previous', 'Next' and 'Last' buttons, p=
lus page numbers
+			 * * `first_last_numbers` - 'First' and 'Last' buttons, plus page numbe=
rs
+			 *=20=20
+			 * Further methods can be added using {@link DataTable.ext.oPagination}.
+			 *  @type string
+			 *  @default simple_numbers
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.pagingType
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "pagingType": "full_numbers"
+			 *      } );
+			 *    } )
+			 */
+			"sPaginationType": "simple_numbers",
+=09=09
+=09=09
+			/**
+			 * Enable horizontal scrolling. When a table is too wide to fit into a
+			 * certain layout, or you have a large number of columns in the table, =
you
+			 * can enable x-scrolling to show the table in a viewport, which can be
+			 * scrolled. This property can be `true` which will allow the table to
+			 * scroll horizontally when needed, or any CSS unit, or a number (in wh=
ich
+			 * case it will be treated as a pixel measurement). Setting as simply `=
true`
+			 * is recommended.
+			 *  @type boolean|string
+			 *  @default <i>blank string - i.e. disabled</i>
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.scrollX
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "scrollX": true,
+			 *        "scrollCollapse": true
+			 *      } );
+			 *    } );
+			 */
+			"sScrollX": "",
+=09=09
+=09=09
+			/**
+			 * This property can be used to force a DataTable to use more width tha=
n it
+			 * might otherwise do when x-scrolling is enabled. For example if you h=
ave a
+			 * table which requires to be well spaced, this parameter is useful for
+			 * "over-sizing" the table, and thus forcing scrolling. This property c=
an by
+			 * any CSS unit, or a number (in which case it will be treated as a pix=
el
+			 * measurement).
+			 *  @type string
+			 *  @default <i>blank string - i.e. disabled</i>
+			 *
+			 *  @dtopt Options
+			 *  @name DataTable.defaults.scrollXInner
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "scrollX": "100%",
+			 *        "scrollXInner": "110%"
+			 *      } );
+			 *    } );
+			 */
+			"sScrollXInner": "",
+=09=09
+=09=09
+			/**
+			 * Enable vertical scrolling. Vertical scrolling will constrain the Dat=
aTable
+			 * to the given height, and enable scrolling for any data which overflo=
ws the
+			 * current viewport. This can be used as an alternative to paging to di=
splay
+			 * a lot of data in a small area (although paging and scrolling can bot=
h be
+			 * enabled at the same time). This property can be any CSS unit, or a n=
umber
+			 * (in which case it will be treated as a pixel measurement).
+			 *  @type string
+			 *  @default <i>blank string - i.e. disabled</i>
+			 *
+			 *  @dtopt Features
+			 *  @name DataTable.defaults.scrollY
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "scrollY": "200px",
+			 *        "paginate": false
+			 *      } );
+			 *    } );
+			 */
+			"sScrollY": "",
+=09=09
+=09=09
+			/**
+			 * __Deprecated__ The functionality provided by this parameter has now =
been
+			 * superseded by that provided through `ajax`, which should be used ins=
tead.
+			 *
+			 * Set the HTTP method that is used to make the Ajax call for server-si=
de
+			 * processing or Ajax sourced data.
+			 *  @type string
+			 *  @default GET
+			 *
+			 *  @dtopt Options
+			 *  @dtopt Server-side
+			 *  @name DataTable.defaults.serverMethod
+			 *
+			 *  @deprecated 1.10. Please use `ajax` for this functionality now.
+			 */
+			"sServerMethod": "GET",
+=09=09
+=09=09
+			/**
+			 * DataTables makes use of renderers when displaying HTML elements for
+			 * a table. These renderers can be added or modified by plug-ins to
+			 * generate suitable mark-up for a site. For example the Bootstrap
+			 * integration plug-in for DataTables uses a paging button renderer to
+			 * display pagination buttons in the mark-up required by Bootstrap.
+			 *
+			 * For further information about the renderers available see
+			 * DataTable.ext.renderer
+			 *  @type string|object
+			 *  @default null
+			 *
+			 *  @name DataTable.defaults.renderer
+			 *
+			 */
+			"renderer": null,
+=09=09
+=09=09
+			/**
+			 * Set the data property name that DataTables should use to get a row's=
 id
+			 * to set as the `id` property in the node.
+			 *  @type string
+			 *  @default DT_RowId
+			 *
+			 *  @name DataTable.defaults.rowId
+			 */
+			"rowId": "DT_RowId"
+		};
+=09=09
+		_fnHungarianMap( DataTable.defaults );
+=09=09
+=09=09
+=09=09
+		/*
+		 * Developer note - See note in model.defaults.js about the use of Hunga=
rian
+		 * notation and camel case.
+		 */
+=09=09
+		/**
+		 * Column options that can be given to DataTables at initialisation time.
+		 *  @namespace
+		 */
+		DataTable.defaults.column =3D {
+			/**
+			 * Define which column(s) an order will occur on for this column. This
+			 * allows a column's ordering to take multiple columns into account when
+			 * doing a sort or use the data from a different column. For example fi=
rst
+			 * name / last name columns make sense to do a multi-column sort over t=
he
+			 * two columns.
+			 *  @type array|int
+			 *  @default null <i>Takes the value of the column index automatically<=
/i>
+			 *
+			 *  @name DataTable.defaults.column.orderData
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "orderData": [ 0, 1 ], "targets": [ 0 ] },
+			 *          { "orderData": [ 1, 0 ], "targets": [ 1 ] },
+			 *          { "orderData": 2, "targets": [ 2 ] }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          { "orderData": [ 0, 1 ] },
+			 *          { "orderData": [ 1, 0 ] },
+			 *          { "orderData": 2 },
+			 *          null,
+			 *          null
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"aDataSort": null,
+			"iDataSort": -1,
+=09=09
+=09=09
+			/**
+			 * You can control the default ordering direction, and even alter the
+			 * behaviour of the sort handler (i.e. only allow ascending ordering et=
c)
+			 * using this parameter.
+			 *  @type array
+			 *  @default [ 'asc', 'desc' ]
+			 *
+			 *  @name DataTable.defaults.column.orderSequence
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "orderSequence": [ "asc" ], "targets": [ 1 ] },
+			 *          { "orderSequence": [ "desc", "asc", "asc" ], "targets": [ 2=
 ] },
+			 *          { "orderSequence": [ "desc" ], "targets": [ 3 ] }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          null,
+			 *          { "orderSequence": [ "asc" ] },
+			 *          { "orderSequence": [ "desc", "asc", "asc" ] },
+			 *          { "orderSequence": [ "desc" ] },
+			 *          null
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"asSorting": [ 'asc', 'desc' ],
+=09=09
+=09=09
+			/**
+			 * Enable or disable filtering on the data in this column.
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @name DataTable.defaults.column.searchable
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "searchable": false, "targets": [ 0 ] }
+			 *        ] } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          { "searchable": false },
+			 *          null,
+			 *          null,
+			 *          null,
+			 *          null
+			 *        ] } );
+			 *    } );
+			 */
+			"bSearchable": true,
+=09=09
+=09=09
+			/**
+			 * Enable or disable ordering on this column.
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @name DataTable.defaults.column.orderable
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "orderable": false, "targets": [ 0 ] }
+			 *        ] } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          { "orderable": false },
+			 *          null,
+			 *          null,
+			 *          null,
+			 *          null
+			 *        ] } );
+			 *    } );
+			 */
+			"bSortable": true,
+=09=09
+=09=09
+			/**
+			 * Enable or disable the display of this column.
+			 *  @type boolean
+			 *  @default true
+			 *
+			 *  @name DataTable.defaults.column.visible
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "visible": false, "targets": [ 0 ] }
+			 *        ] } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          { "visible": false },
+			 *          null,
+			 *          null,
+			 *          null,
+			 *          null
+			 *        ] } );
+			 *    } );
+			 */
+			"bVisible": true,
+=09=09
+=09=09
+			/**
+			 * Developer definable function that is called whenever a cell is creat=
ed (Ajax source,
+			 * etc) or processed for input (DOM source). This can be used as a comp=
liment to mRender
+			 * allowing you to modify the DOM element (add background colour for ex=
ample) when the
+			 * element is available.
+			 *  @type function
+			 *  @param {element} td The TD node that has been created
+			 *  @param {*} cellData The Data for the cell
+			 *  @param {array|object} rowData The data for the whole row
+			 *  @param {int} row The row index for the aoData data store
+			 *  @param {int} col The column index for aoColumns
+			 *
+			 *  @name DataTable.defaults.column.createdCell
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [ {
+			 *          "targets": [3],
+			 *          "createdCell": function (td, cellData, rowData, row, col) {
+			 *            if ( cellData =3D=3D "1.7" ) {
+			 *              $(td).css('color', 'blue')
+			 *            }
+			 *          }
+			 *        } ]
+			 *      });
+			 *    } );
+			 */
+			"fnCreatedCell": null,
+=09=09
+=09=09
+			/**
+			 * This parameter has been replaced by `data` in DataTables to ensure n=
aming
+			 * consistency. `dataProp` can still be used, as there is backwards
+			 * compatibility in DataTables for this option, but it is strongly
+			 * recommended that you use `data` in preference to `dataProp`.
+			 *  @name DataTable.defaults.column.dataProp
+			 */
+=09=09
+=09=09
+			/**
+			 * This property can be used to read data from any data source property,
+			 * including deeply nested objects / properties. `data` can be given in=
 a
+			 * number of different ways which effect its behaviour:
+			 *
+			 * * `integer` - treated as an array index for the data source. This is=
 the
+			 *   default that DataTables uses (incrementally increased for each col=
umn).
+			 * * `string` - read an object property from the data source. There are
+			 *   three 'special' options that can be used in the string to alter how
+			 *   DataTables reads the data from the source object:
+			 *    * `.` - Dotted Javascript notation. Just as you use a `.` in
+			 *      Javascript to read from nested objects, so to can the options
+			 *      specified in `data`. For example: `browser.version` or
+			 *      `browser.name`. If your object parameter name contains a period=
, use
+			 *      `\\` to escape it - i.e. `first\\.name`.
+			 *    * `[]` - Array notation. DataTables can automatically combine data
+			 *      from and array source, joining the data with the characters pro=
vided
+			 *      between the two brackets. For example: `name[, ]` would provide=
 a
+			 *      comma-space separated list from the source array. If no charact=
ers
+			 *      are provided between the brackets, the original array source is
+			 *      returned.
+			 *    * `()` - Function notation. Adding `()` to the end of a parameter=
 will
+			 *      execute a function of the name given. For example: `browser()` =
for a
+			 *      simple function on the data source, `browser.version()` for a
+			 *      function in a nested property or even `browser().version` to ge=
t an
+			 *      object property if the function called returns an object. Note =
that
+			 *      function notation is recommended for use in `render` rather than
+			 *      `data` as it is much simpler to use as a renderer.
+			 * * `null` - use the original data source for the row rather than pluc=
king
+			 *   data directly from it. This action has effects on two other
+			 *   initialisation options:
+			 *    * `defaultContent` - When null is given as the `data` option and
+			 *      `defaultContent` is specified for the column, the value defined=
 by
+			 *      `defaultContent` will be used for the cell.
+			 *    * `render` - When null is used for the `data` option and the `ren=
der`
+			 *      option is specified for the column, the whole data source for t=
he
+			 *      row is used for the renderer.
+			 * * `function` - the function given will be executed whenever DataTabl=
es
+			 *   needs to set or get the data for a cell in the column. The function
+			 *   takes three parameters:
+			 *    * Parameters:
+			 *      * `{array|object}` The data source for the row
+			 *      * `{string}` The type call data requested - this will be 'set' =
when
+			 *        setting data or 'filter', 'display', 'type', 'sort' or undefi=
ned
+			 *        when gathering data. Note that when `undefined` is given for =
the
+			 *        type DataTables expects to get the raw data for the object ba=
ck<
+			 *      * `{*}` Data to set when the second parameter is 'set'.
+			 *    * Return:
+			 *      * The return value from the function is not required when 'set'=
 is
+			 *        the type of call, but otherwise the return is what will be us=
ed
+			 *        for the data requested.
+			 *
+			 * Note that `data` is a getter and setter option. If you just require
+			 * formatting of data for output, you will likely want to use `render` =
which
+			 * is simply a getter and thus simpler to use.
+			 *
+			 * Note that prior to DataTables 1.9.2 `data` was called `mDataProp`. T=
he
+			 * name change reflects the flexibility of this property and is consist=
ent
+			 * with the naming of mRender. If 'mDataProp' is given, then it will st=
ill
+			 * be used by DataTables, as it automatically maps the old name to the =
new
+			 * if required.
+			 *
+			 *  @type string|int|function|null
+			 *  @default null <i>Use automatically calculated column index</i>
+			 *
+			 *  @name DataTable.defaults.column.data
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Read table data from objects
+			 *    // JSON structure for each row:
+			 *    //   {
+			 *    //      "engine": {value},
+			 *    //      "browser": {value},
+			 *    //      "platform": {value},
+			 *    //      "version": {value},
+			 *    //      "grade": {value}
+			 *    //   }
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "ajaxSource": "sources/objects.txt",
+			 *        "columns": [
+			 *          { "data": "engine" },
+			 *          { "data": "browser" },
+			 *          { "data": "platform" },
+			 *          { "data": "version" },
+			 *          { "data": "grade" }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Read information from deeply nested objects
+			 *    // JSON structure for each row:
+			 *    //   {
+			 *    //      "engine": {value},
+			 *    //      "browser": {value},
+			 *    //      "platform": {
+			 *    //         "inner": {value}
+			 *    //      },
+			 *    //      "details": [
+			 *    //         {value}, {value}
+			 *    //      ]
+			 *    //   }
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "ajaxSource": "sources/deep.txt",
+			 *        "columns": [
+			 *          { "data": "engine" },
+			 *          { "data": "browser" },
+			 *          { "data": "platform.inner" },
+			 *          { "data": "details.0" },
+			 *          { "data": "details.1" }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `data` as a function to provide different information for
+			 *    // sorting, filtering and display. In this case, currency (price)
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [ {
+			 *          "targets": [ 0 ],
+			 *          "data": function ( source, type, val ) {
+			 *            if (type =3D=3D=3D 'set') {
+			 *              source.price =3D val;
+			 *              // Store the computed display and filter values for eff=
iciency
+			 *              source.price_display =3D val=3D=3D"" ? "" : "$"+numberF=
ormat(val);
+			 *              source.price_filter  =3D val=3D=3D"" ? "" : "$"+numberF=
ormat(val)+" "+val;
+			 *              return;
+			 *            }
+			 *            else if (type =3D=3D=3D 'display') {
+			 *              return source.price_display;
+			 *            }
+			 *            else if (type =3D=3D=3D 'filter') {
+			 *              return source.price_filter;
+			 *            }
+			 *            // 'sort', 'type' and undefined all just use the integer
+			 *            return source.price;
+			 *          }
+			 *        } ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using default content
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [ {
+			 *          "targets": [ 0 ],
+			 *          "data": null,
+			 *          "defaultContent": "Click to edit"
+			 *        } ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using array notation - outputting a list from an array
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [ {
+			 *          "targets": [ 0 ],
+			 *          "data": "name[, ]"
+			 *        } ]
+			 *      } );
+			 *    } );
+			 *
+			 */
+			"mData": null,
+=09=09
+=09=09
+			/**
+			 * This property is the rendering partner to `data` and it is suggested=
 that
+			 * when you want to manipulate data for display (including filtering,
+			 * sorting etc) without altering the underlying data for the table, use=
 this
+			 * property. `render` can be considered to be the the read only compani=
on to
+			 * `data` which is read / write (then as such more complex). Like `data`
+			 * this option can be given in a number of different ways to effect its
+			 * behaviour:
+			 *
+			 * * `integer` - treated as an array index for the data source. This is=
 the
+			 *   default that DataTables uses (incrementally increased for each col=
umn).
+			 * * `string` - read an object property from the data source. There are
+			 *   three 'special' options that can be used in the string to alter how
+			 *   DataTables reads the data from the source object:
+			 *    * `.` - Dotted Javascript notation. Just as you use a `.` in
+			 *      Javascript to read from nested objects, so to can the options
+			 *      specified in `data`. For example: `browser.version` or
+			 *      `browser.name`. If your object parameter name contains a period=
, use
+			 *      `\\` to escape it - i.e. `first\\.name`.
+			 *    * `[]` - Array notation. DataTables can automatically combine data
+			 *      from and array source, joining the data with the characters pro=
vided
+			 *      between the two brackets. For example: `name[, ]` would provide=
 a
+			 *      comma-space separated list from the source array. If no charact=
ers
+			 *      are provided between the brackets, the original array source is
+			 *      returned.
+			 *    * `()` - Function notation. Adding `()` to the end of a parameter=
 will
+			 *      execute a function of the name given. For example: `browser()` =
for a
+			 *      simple function on the data source, `browser.version()` for a
+			 *      function in a nested property or even `browser().version` to ge=
t an
+			 *      object property if the function called returns an object.
+			 * * `object` - use different data for the different data types request=
ed by
+			 *   DataTables ('filter', 'display', 'type' or 'sort'). The property n=
ames
+			 *   of the object is the data type the property refers to and the valu=
e can
+			 *   defined using an integer, string or function using the same rules =
as
+			 *   `render` normally does. Note that an `_` option _must_ be specifie=
d.
+			 *   This is the default value to use if you haven't specified a value =
for
+			 *   the data type requested by DataTables.
+			 * * `function` - the function given will be executed whenever DataTabl=
es
+			 *   needs to set or get the data for a cell in the column. The function
+			 *   takes three parameters:
+			 *    * Parameters:
+			 *      * {array|object} The data source for the row (based on `data`)
+			 *      * {string} The type call data requested - this will be 'filter',
+			 *        'display', 'type' or 'sort'.
+			 *      * {array|object} The full data source for the row (not based on
+			 *        `data`)
+			 *    * Return:
+			 *      * The return value from the function is what will be used for t=
he
+			 *        data requested.
+			 *
+			 *  @type string|int|function|object|null
+			 *  @default null Use the data source value.
+			 *
+			 *  @name DataTable.defaults.column.render
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Create a comma separated list from an array of objects
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "ajaxSource": "sources/deep.txt",
+			 *        "columns": [
+			 *          { "data": "engine" },
+			 *          { "data": "browser" },
+			 *          {
+			 *            "data": "platform",
+			 *            "render": "[, ].name"
+			 *          }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Execute a function to obtain data
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [ {
+			 *          "targets": [ 0 ],
+			 *          "data": null, // Use the full data source object for the re=
nderer's source
+			 *          "render": "browserName()"
+			 *        } ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // As an object, extracting different data for the different types
+			 *    // This would be used with a data source such as:
+			 *    //   { "phone": 5552368, "phone_filter": "5552368 555-2368", "pho=
ne_display": "555-2368" }
+			 *    // Here the `phone` integer is used for sorting and type detectio=
n, while `phone_filter`
+			 *    // (which has both forms) is used for filtering for if a user inp=
uts either format, while
+			 *    // the formatted phone number is the one that is shown in the tab=
le.
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [ {
+			 *          "targets": [ 0 ],
+			 *          "data": null, // Use the full data source object for the re=
nderer's source
+			 *          "render": {
+			 *            "_": "phone",
+			 *            "filter": "phone_filter",
+			 *            "display": "phone_display"
+			 *          }
+			 *        } ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Use as a function to create a link from the data source
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [ {
+			 *          "targets": [ 0 ],
+			 *          "data": "download_link",
+			 *          "render": function ( data, type, full ) {
+			 *            return '<a href=3D"'+data+'">Download</a>';
+			 *          }
+			 *        } ]
+			 *      } );
+			 *    } );
+			 */
+			"mRender": null,
+=09=09
+=09=09
+			/**
+			 * Change the cell type created for the column - either TD cells or TH =
cells. This
+			 * can be useful as TH cells have semantic meaning in the table body, a=
llowing them
+			 * to act as a header for a row (you may wish to add scope=3D'row' to t=
he TH elements).
+			 *  @type string
+			 *  @default td
+			 *
+			 *  @name DataTable.defaults.column.cellType
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Make the first column use TH cells
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [ {
+			 *          "targets": [ 0 ],
+			 *          "cellType": "th"
+			 *        } ]
+			 *      } );
+			 *    } );
+			 */
+			"sCellType": "td",
+=09=09
+=09=09
+			/**
+			 * Class to give to each cell in this column.
+			 *  @type string
+			 *  @default <i>Empty string</i>
+			 *
+			 *  @name DataTable.defaults.column.class
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "class": "my_class", "targets": [ 0 ] }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          { "class": "my_class" },
+			 *          null,
+			 *          null,
+			 *          null,
+			 *          null
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"sClass": "",
+=09=09
+			/**
+			 * When DataTables calculates the column widths to assign to each colum=
n,
+			 * it finds the longest string in each column and then constructs a
+			 * temporary table and reads the widths from that. The problem with this
+			 * is that "mmm" is much wider then "iiii", but the latter is a longer
+			 * string - thus the calculation can go wrong (doing it properly and pu=
tting
+			 * it into an DOM object and measuring that is horribly(!) slow). Thus =
as
+			 * a "work around" we provide this option. It will append its value to =
the
+			 * text that is found to be the longest string for the column - i.e. pa=
dding.
+			 * Generally you shouldn't need this!
+			 *  @type string
+			 *  @default <i>Empty string<i>
+			 *
+			 *  @name DataTable.defaults.column.contentPadding
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          null,
+			 *          null,
+			 *          null,
+			 *          {
+			 *            "contentPadding": "mmm"
+			 *          }
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"sContentPadding": "",
+=09=09
+=09=09
+			/**
+			 * Allows a default value to be given for a column's data, and will be =
used
+			 * whenever a null data source is encountered (this can be because `dat=
a`
+			 * is set to null, or because the data source itself is null).
+			 *  @type string
+			 *  @default null
+			 *
+			 *  @name DataTable.defaults.column.defaultContent
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          {
+			 *            "data": null,
+			 *            "defaultContent": "Edit",
+			 *            "targets": [ -1 ]
+			 *          }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          null,
+			 *          null,
+			 *          null,
+			 *          {
+			 *            "data": null,
+			 *            "defaultContent": "Edit"
+			 *          }
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"sDefaultContent": null,
+=09=09
+=09=09
+			/**
+			 * This parameter is only used in DataTables' server-side processing. I=
t can
+			 * be exceptionally useful to know what columns are being displayed on =
the
+			 * client side, and to map these to database fields. When defined, the =
names
+			 * also allow DataTables to reorder information from the server if it c=
omes
+			 * back in an unexpected order (i.e. if you switch your columns around =
on the
+			 * client-side, your server-side code does not also need updating).
+			 *  @type string
+			 *  @default <i>Empty string</i>
+			 *
+			 *  @name DataTable.defaults.column.name
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "name": "engine", "targets": [ 0 ] },
+			 *          { "name": "browser", "targets": [ 1 ] },
+			 *          { "name": "platform", "targets": [ 2 ] },
+			 *          { "name": "version", "targets": [ 3 ] },
+			 *          { "name": "grade", "targets": [ 4 ] }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          { "name": "engine" },
+			 *          { "name": "browser" },
+			 *          { "name": "platform" },
+			 *          { "name": "version" },
+			 *          { "name": "grade" }
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"sName": "",
+=09=09
+=09=09
+			/**
+			 * Defines a data source type for the ordering which can be used to read
+			 * real-time information from the table (updating the internally cached
+			 * version) prior to ordering. This allows ordering to occur on user
+			 * editable elements such as form inputs.
+			 *  @type string
+			 *  @default std
+			 *
+			 *  @name DataTable.defaults.column.orderDataType
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "orderDataType": "dom-text", "targets": [ 2, 3 ] },
+			 *          { "type": "numeric", "targets": [ 3 ] },
+			 *          { "orderDataType": "dom-select", "targets": [ 4 ] },
+			 *          { "orderDataType": "dom-checkbox", "targets": [ 5 ] }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          null,
+			 *          null,
+			 *          { "orderDataType": "dom-text" },
+			 *          { "orderDataType": "dom-text", "type": "numeric" },
+			 *          { "orderDataType": "dom-select" },
+			 *          { "orderDataType": "dom-checkbox" }
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"sSortDataType": "std",
+=09=09
+=09=09
+			/**
+			 * The title of this column.
+			 *  @type string
+			 *  @default null <i>Derived from the 'TH' value for this column in the
+			 *    original HTML table.</i>
+			 *
+			 *  @name DataTable.defaults.column.title
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "title": "My column title", "targets": [ 0 ] }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          { "title": "My column title" },
+			 *          null,
+			 *          null,
+			 *          null,
+			 *          null
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"sTitle": null,
+=09=09
+=09=09
+			/**
+			 * The type allows you to specify how the data for this column will be
+			 * ordered. Four types (string, numeric, date and html (which will strip
+			 * HTML tags before ordering)) are currently available. Note that only =
date
+			 * formats understood by Javascript's Date() object will be accepted as=
 type
+			 * date. For example: "Mar 26, 2008 5:03 PM". May take the values: 'str=
ing',
+			 * 'numeric', 'date' or 'html' (by default). Further types can be adding
+			 * through plug-ins.
+			 *  @type string
+			 *  @default null <i>Auto-detected from raw data</i>
+			 *
+			 *  @name DataTable.defaults.column.type
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "type": "html", "targets": [ 0 ] }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          { "type": "html" },
+			 *          null,
+			 *          null,
+			 *          null,
+			 *          null
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"sType": null,
+=09=09
+=09=09
+			/**
+			 * Defining the width of the column, this parameter may take any CSS va=
lue
+			 * (3em, 20px etc). DataTables applies 'smart' widths to columns which =
have not
+			 * been given a specific width through this interface ensuring that the=
 table
+			 * remains readable.
+			 *  @type string
+			 *  @default null <i>Automatic</i>
+			 *
+			 *  @name DataTable.defaults.column.width
+			 *  @dtopt Columns
+			 *
+			 *  @example
+			 *    // Using `columnDefs`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columnDefs": [
+			 *          { "width": "20%", "targets": [ 0 ] }
+			 *        ]
+			 *      } );
+			 *    } );
+			 *
+			 *  @example
+			 *    // Using `columns`
+			 *    $(document).ready( function() {
+			 *      $('#example').dataTable( {
+			 *        "columns": [
+			 *          { "width": "20%" },
+			 *          null,
+			 *          null,
+			 *          null,
+			 *          null
+			 *        ]
+			 *      } );
+			 *    } );
+			 */
+			"sWidth": null
+		};
+=09=09
+		_fnHungarianMap( DataTable.defaults.column );
+=09=09
+=09=09
+=09=09
+		/**
+		 * DataTables settings object - this holds all the information needed fo=
r a
+		 * given table, including configuration, data and current application of=
 the
+		 * table options. DataTables does not have a single instance for each Da=
taTable
+		 * with the settings attached to that instance, but rather instances of =
the
+		 * DataTable "class" are created on-the-fly as needed (typically by a
+		 * $().dataTable() call) and the settings object is then applied to that
+		 * instance.
+		 *
+		 * Note that this object is related to {@link DataTable.defaults} but th=
is
+		 * one is the internal data store for DataTables's cache of columns. It =
should
+		 * NOT be manipulated outside of DataTables. Any configuration should be=
 done
+		 * through the initialisation options.
+		 *  @namespace
+		 *  @todo Really should attach the settings object to individual instanc=
es so we
+		 *    don't need to create new instances on each $().dataTable() call (i=
f the
+		 *    table already exists). It would also save passing oSettings around=
 and
+		 *    into every single function. However, this is a very significant
+		 *    architecture change for DataTables and will almost certainly break
+		 *    backwards compatibility with older installations. This is somethin=
g that
+		 *    will be done in 2.0.
+		 */
+		DataTable.models.oSettings =3D {
+			/**
+			 * Primary features of DataTables and their enablement state.
+			 *  @namespace
+			 */
+			"oFeatures": {
+=09=09
+				/**
+				 * Flag to say if DataTables should automatically try to calculate the
+				 * optimum table and columns widths (true) or not (false).
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bAutoWidth": null,
+=09=09
+				/**
+				 * Delay the creation of TR and TD elements until they are actually
+				 * needed by a driven page draw. This can give a significant speed
+				 * increase for Ajax source and Javascript source data, but makes no
+				 * difference at all for DOM and server-side processing tables.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bDeferRender": null,
+=09=09
+				/**
+				 * Enable filtering on the table or not. Note that if this is disabled
+				 * then there is no filtering at all on the table, including fnFilter.
+				 * To just remove the filtering input use sDom and remove the 'f' opti=
on.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bFilter": null,
+=09=09
+				/**
+				 * Table information element (the 'Showing x of y records' div) enable
+				 * flag.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bInfo": null,
+=09=09
+				/**
+				 * Present a user control allowing the end user to change the page size
+				 * when pagination is enabled.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bLengthChange": null,
+=09=09
+				/**
+				 * Pagination enabled or not. Note that if this is disabled then length
+				 * changing must also be disabled.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bPaginate": null,
+=09=09
+				/**
+				 * Processing indicator enable flag whenever DataTables is enacting a
+				 * user request - typically an Ajax request for server-side processing.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bProcessing": null,
+=09=09
+				/**
+				 * Server-side processing enabled flag - when enabled DataTables will
+				 * get all data from the server for every draw - there is no filtering,
+				 * sorting or paging done on the client-side.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bServerSide": null,
+=09=09
+				/**
+				 * Sorting enablement flag.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bSort": null,
+=09=09
+				/**
+				 * Multi-column sorting
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bSortMulti": null,
+=09=09
+				/**
+				 * Apply a class to the columns which are being sorted to provide a
+				 * visual highlight or not. This can slow things down when enabled sin=
ce
+				 * there is a lot of DOM interaction.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bSortClasses": null,
+=09=09
+				/**
+				 * State saving enablement flag.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bStateSave": null
+			},
+=09=09
+=09=09
+			/**
+			 * Scrolling settings for a table.
+			 *  @namespace
+			 */
+			"oScroll": {
+				/**
+				 * When the table is shorter in height than sScrollY, collapse the
+				 * table container down to the height of the table (when true).
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type boolean
+				 */
+				"bCollapse": null,
+=09=09
+				/**
+				 * Width of the scrollbar for the web-browser's platform. Calculated
+				 * during table initialisation.
+				 *  @type int
+				 *  @default 0
+				 */
+				"iBarWidth": 0,
+=09=09
+				/**
+				 * Viewport width for horizontal scrolling. Horizontal scrolling is
+				 * disabled if an empty string.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type string
+				 */
+				"sX": null,
+=09=09
+				/**
+				 * Width to expand the table to when using x-scrolling. Typically you
+				 * should not need to use this.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type string
+				 *  @deprecated
+				 */
+				"sXInner": null,
+=09=09
+				/**
+				 * Viewport height for vertical scrolling. Vertical scrolling is disab=
led
+				 * if an empty string.
+				 * Note that this parameter will be set by the initialisation routine.=
 To
+				 * set a default use {@link DataTable.defaults}.
+				 *  @type string
+				 */
+				"sY": null
+			},
+=09=09
+			/**
+			 * Language information for the table.
+			 *  @namespace
+			 *  @extends DataTable.defaults.oLanguage
+			 */
+			"oLanguage": {
+				/**
+				 * Information callback function. See
+				 * {@link DataTable.defaults.fnInfoCallback}
+				 *  @type function
+				 *  @default null
+				 */
+				"fnInfoCallback": null
+			},
+=09=09
+			/**
+			 * Browser support parameters
+			 *  @namespace
+			 */
+			"oBrowser": {
+				/**
+				 * Indicate if the browser incorrectly calculates width:100% inside a
+				 * scrolling element (IE6/7)
+				 *  @type boolean
+				 *  @default false
+				 */
+				"bScrollOversize": false,
+=09=09
+				/**
+				 * Determine if the vertical scrollbar is on the right or left of the
+				 * scrolling container - needed for rtl language layout, although not
+				 * all browsers move the scrollbar (Safari).
+				 *  @type boolean
+				 *  @default false
+				 */
+				"bScrollbarLeft": false,
+=09=09
+				/**
+				 * Flag for if `getBoundingClientRect` is fully supported or not
+				 *  @type boolean
+				 *  @default false
+				 */
+				"bBounding": false,
+=09=09
+				/**
+				 * Browser scrollbar width
+				 *  @type integer
+				 *  @default 0
+				 */
+				"barWidth": 0
+			},
+=09=09
+=09=09
+			"ajax": null,
+=09=09
+=09=09
+			/**
+			 * Array referencing the nodes which are used for the features. The
+			 * parameters of this object match what is allowed by sDom - i.e.
+			 *   <ul>
+			 *     <li>'l' - Length changing</li>
+			 *     <li>'f' - Filtering input</li>
+			 *     <li>'t' - The table!</li>
+			 *     <li>'i' - Information</li>
+			 *     <li>'p' - Pagination</li>
+			 *     <li>'r' - pRocessing</li>
+			 *   </ul>
+			 *  @type array
+			 *  @default []
+			 */
+			"aanFeatures": [],
+=09=09
+			/**
+			 * Store data information - see {@link DataTable.models.oRow} for detai=
led
+			 * information.
+			 *  @type array
+			 *  @default []
+			 */
+			"aoData": [],
+=09=09
+			/**
+			 * Array of indexes which are in the current display (after filtering e=
tc)
+			 *  @type array
+			 *  @default []
+			 */
+			"aiDisplay": [],
+=09=09
+			/**
+			 * Array of indexes for display - no filtering
+			 *  @type array
+			 *  @default []
+			 */
+			"aiDisplayMaster": [],
+=09=09
+			/**
+			 * Map of row ids to data indexes
+			 *  @type object
+			 *  @default {}
+			 */
+			"aIds": {},
+=09=09
+			/**
+			 * Store information about each column that is in use
+			 *  @type array
+			 *  @default []
+			 */
+			"aoColumns": [],
+=09=09
+			/**
+			 * Store information about the table's header
+			 *  @type array
+			 *  @default []
+			 */
+			"aoHeader": [],
+=09=09
+			/**
+			 * Store information about the table's footer
+			 *  @type array
+			 *  @default []
+			 */
+			"aoFooter": [],
+=09=09
+			/**
+			 * Store the applied global search information in case we want to force=
 a
+			 * research or compare the old search to a new one.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @namespace
+			 *  @extends DataTable.models.oSearch
+			 */
+			"oPreviousSearch": {},
+=09=09
+			/**
+			 * Store the applied search for each column - see
+			 * {@link DataTable.models.oSearch} for the format that is used for the
+			 * filtering information for each column.
+			 *  @type array
+			 *  @default []
+			 */
+			"aoPreSearchCols": [],
+=09=09
+			/**
+			 * Sorting that is applied to the table. Note that the inner arrays are
+			 * used in the following manner:
+			 * <ul>
+			 *   <li>Index 0 - column number</li>
+			 *   <li>Index 1 - current sorting direction</li>
+			 * </ul>
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type array
+			 *  @todo These inner arrays should really be objects
+			 */
+			"aaSorting": null,
+=09=09
+			/**
+			 * Sorting that is always applied to the table (i.e. prefixed in front =
of
+			 * aaSorting).
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type array
+			 *  @default []
+			 */
+			"aaSortingFixed": [],
+=09=09
+			/**
+			 * Classes to use for the striping of a table.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type array
+			 *  @default []
+			 */
+			"asStripeClasses": null,
+=09=09
+			/**
+			 * If restoring a table - we should restore its striping classes as well
+			 *  @type array
+			 *  @default []
+			 */
+			"asDestroyStripes": [],
+=09=09
+			/**
+			 * If restoring a table - we should restore its width
+			 *  @type int
+			 *  @default 0
+			 */
+			"sDestroyWidth": 0,
+=09=09
+			/**
+			 * Callback functions array for every time a row is inserted (i.e. on a=
 draw).
+			 *  @type array
+			 *  @default []
+			 */
+			"aoRowCallback": [],
+=09=09
+			/**
+			 * Callback functions for the header on each draw.
+			 *  @type array
+			 *  @default []
+			 */
+			"aoHeaderCallback": [],
+=09=09
+			/**
+			 * Callback function for the footer on each draw.
+			 *  @type array
+			 *  @default []
+			 */
+			"aoFooterCallback": [],
+=09=09
+			/**
+			 * Array of callback functions for draw callback functions
+			 *  @type array
+			 *  @default []
+			 */
+			"aoDrawCallback": [],
+=09=09
+			/**
+			 * Array of callback functions for row created function
+			 *  @type array
+			 *  @default []
+			 */
+			"aoRowCreatedCallback": [],
+=09=09
+			/**
+			 * Callback functions for just before the table is redrawn. A return of
+			 * false will be used to cancel the draw.
+			 *  @type array
+			 *  @default []
+			 */
+			"aoPreDrawCallback": [],
+=09=09
+			/**
+			 * Callback functions for when the table has been initialised.
+			 *  @type array
+			 *  @default []
+			 */
+			"aoInitComplete": [],
+=09=09
+=09=09
+			/**
+			 * Callbacks for modifying the settings to be stored for state saving, =
prior to
+			 * saving state.
+			 *  @type array
+			 *  @default []
+			 */
+			"aoStateSaveParams": [],
+=09=09
+			/**
+			 * Callbacks for modifying the settings that have been stored for state=
 saving
+			 * prior to using the stored values to restore the state.
+			 *  @type array
+			 *  @default []
+			 */
+			"aoStateLoadParams": [],
+=09=09
+			/**
+			 * Callbacks for operating on the settings object once the saved state =
has been
+			 * loaded
+			 *  @type array
+			 *  @default []
+			 */
+			"aoStateLoaded": [],
+=09=09
+			/**
+			 * Cache the table ID for quick access
+			 *  @type string
+			 *  @default <i>Empty string</i>
+			 */
+			"sTableId": "",
+=09=09
+			/**
+			 * The TABLE node for the main table
+			 *  @type node
+			 *  @default null
+			 */
+			"nTable": null,
+=09=09
+			/**
+			 * Permanent ref to the thead element
+			 *  @type node
+			 *  @default null
+			 */
+			"nTHead": null,
+=09=09
+			/**
+			 * Permanent ref to the tfoot element - if it exists
+			 *  @type node
+			 *  @default null
+			 */
+			"nTFoot": null,
+=09=09
+			/**
+			 * Permanent ref to the tbody element
+			 *  @type node
+			 *  @default null
+			 */
+			"nTBody": null,
+=09=09
+			/**
+			 * Cache the wrapper node (contains all DataTables controlled elements)
+			 *  @type node
+			 *  @default null
+			 */
+			"nTableWrapper": null,
+=09=09
+			/**
+			 * Indicate if when using server-side processing the loading of data
+			 * should be deferred until the second draw.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type boolean
+			 *  @default false
+			 */
+			"bDeferLoading": false,
+=09=09
+			/**
+			 * Indicate if all required information has been read in
+			 *  @type boolean
+			 *  @default false
+			 */
+			"bInitialised": false,
+=09=09
+			/**
+			 * Information about open rows. Each object in the array has the parame=
ters
+			 * 'nTr' and 'nParent'
+			 *  @type array
+			 *  @default []
+			 */
+			"aoOpenRows": [],
+=09=09
+			/**
+			 * Dictate the positioning of DataTables' control elements - see
+			 * {@link DataTable.model.oInit.sDom}.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type string
+			 *  @default null
+			 */
+			"sDom": null,
+=09=09
+			/**
+			 * Search delay (in mS)
+			 *  @type integer
+			 *  @default null
+			 */
+			"searchDelay": null,
+=09=09
+			/**
+			 * Which type of pagination should be used.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type string
+			 *  @default two_button
+			 */
+			"sPaginationType": "two_button",
+=09=09
+			/**
+			 * The state duration (for `stateSave`) in seconds.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type int
+			 *  @default 0
+			 */
+			"iStateDuration": 0,
+=09=09
+			/**
+			 * Array of callback functions for state saving. Each array element is =
an
+			 * object with the following parameters:
+			 *   <ul>
+			 *     <li>function:fn - function to call. Takes two parameters, oSetti=
ngs
+			 *       and the JSON string to save that has been thus far created. Re=
turns
+			 *       a JSON string to be inserted into a json object
+			 *       (i.e. '"param": [ 0, 1, 2]')</li>
+			 *     <li>string:sName - name of callback</li>
+			 *   </ul>
+			 *  @type array
+			 *  @default []
+			 */
+			"aoStateSave": [],
+=09=09
+			/**
+			 * Array of callback functions for state loading. Each array element is=
 an
+			 * object with the following parameters:
+			 *   <ul>
+			 *     <li>function:fn - function to call. Takes two parameters, oSetti=
ngs
+			 *       and the object stored. May return false to cancel state loadin=
g</li>
+			 *     <li>string:sName - name of callback</li>
+			 *   </ul>
+			 *  @type array
+			 *  @default []
+			 */
+			"aoStateLoad": [],
+=09=09
+			/**
+			 * State that was saved. Useful for back reference
+			 *  @type object
+			 *  @default null
+			 */
+			"oSavedState": null,
+=09=09
+			/**
+			 * State that was loaded. Useful for back reference
+			 *  @type object
+			 *  @default null
+			 */
+			"oLoadedState": null,
+=09=09
+			/**
+			 * Source url for AJAX data for the table.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type string
+			 *  @default null
+			 */
+			"sAjaxSource": null,
+=09=09
+			/**
+			 * Property from a given object from which to read the table data from.=
 This
+			 * can be an empty string (when not server-side processing), in which c=
ase
+			 * it is  assumed an an array is given directly.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type string
+			 */
+			"sAjaxDataProp": null,
+=09=09
+			/**
+			 * The last jQuery XHR object that was used for server-side data gather=
ing.
+			 * This can be used for working with the XHR information in one of the
+			 * callbacks
+			 *  @type object
+			 *  @default null
+			 */
+			"jqXHR": null,
+=09=09
+			/**
+			 * JSON returned from the server in the last Ajax request
+			 *  @type object
+			 *  @default undefined
+			 */
+			"json": undefined,
+=09=09
+			/**
+			 * Data submitted as part of the last Ajax request
+			 *  @type object
+			 *  @default undefined
+			 */
+			"oAjaxData": undefined,
+=09=09
+			/**
+			 * Function to get the server-side data.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type function
+			 */
+			"fnServerData": null,
+=09=09
+			/**
+			 * Functions which are called prior to sending an Ajax request so extra
+			 * parameters can easily be sent to the server
+			 *  @type array
+			 *  @default []
+			 */
+			"aoServerParams": [],
+=09=09
+			/**
+			 * Send the XHR HTTP method - GET or POST (could be PUT or DELETE if
+			 * required).
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type string
+			 */
+			"sServerMethod": null,
+=09=09
+			/**
+			 * Format numbers for display.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type function
+			 */
+			"fnFormatNumber": null,
+=09=09
+			/**
+			 * List of options that can be used for the user selectable length menu.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type array
+			 *  @default []
+			 */
+			"aLengthMenu": null,
+=09=09
+			/**
+			 * Counter for the draws that the table does. Also used as a tracker for
+			 * server-side processing
+			 *  @type int
+			 *  @default 0
+			 */
+			"iDraw": 0,
+=09=09
+			/**
+			 * Indicate if a redraw is being done - useful for Ajax
+			 *  @type boolean
+			 *  @default false
+			 */
+			"bDrawing": false,
+=09=09
+			/**
+			 * Draw index (iDraw) of the last error when parsing the returned data
+			 *  @type int
+			 *  @default -1
+			 */
+			"iDrawError": -1,
+=09=09
+			/**
+			 * Paging display length
+			 *  @type int
+			 *  @default 10
+			 */
+			"_iDisplayLength": 10,
+=09=09
+			/**
+			 * Paging start point - aiDisplay index
+			 *  @type int
+			 *  @default 0
+			 */
+			"_iDisplayStart": 0,
+=09=09
+			/**
+			 * Server-side processing - number of records in the result set
+			 * (i.e. before filtering), Use fnRecordsTotal rather than
+			 * this property to get the value of the number of records, regardless =
of
+			 * the server-side processing setting.
+			 *  @type int
+			 *  @default 0
+			 *  @private
+			 */
+			"_iRecordsTotal": 0,
+=09=09
+			/**
+			 * Server-side processing - number of records in the current display set
+			 * (i.e. after filtering). Use fnRecordsDisplay rather than
+			 * this property to get the value of the number of records, regardless =
of
+			 * the server-side processing setting.
+			 *  @type boolean
+			 *  @default 0
+			 *  @private
+			 */
+			"_iRecordsDisplay": 0,
+=09=09
+			/**
+			 * The classes to use for the table
+			 *  @type object
+			 *  @default {}
+			 */
+			"oClasses": {},
+=09=09
+			/**
+			 * Flag attached to the settings object so you can check in the draw
+			 * callback if filtering has been done in the draw. Deprecated in favou=
r of
+			 * events.
+			 *  @type boolean
+			 *  @default false
+			 *  @deprecated
+			 */
+			"bFiltered": false,
+=09=09
+			/**
+			 * Flag attached to the settings object so you can check in the draw
+			 * callback if sorting has been done in the draw. Deprecated in favour =
of
+			 * events.
+			 *  @type boolean
+			 *  @default false
+			 *  @deprecated
+			 */
+			"bSorted": false,
+=09=09
+			/**
+			 * Indicate that if multiple rows are in the header and there is more t=
han
+			 * one unique cell per column, if the top one (true) or bottom one (fal=
se)
+			 * should be used for sorting / title by DataTables.
+			 * Note that this parameter will be set by the initialisation routine. =
To
+			 * set a default use {@link DataTable.defaults}.
+			 *  @type boolean
+			 */
+			"bSortCellsTop": null,
+=09=09
+			/**
+			 * Initialisation object that is used for the table
+			 *  @type object
+			 *  @default null
+			 */
+			"oInit": null,
+=09=09
+			/**
+			 * Destroy callback functions - for plug-ins to attach themselves to the
+			 * destroy so they can clean up markup and events.
+			 *  @type array
+			 *  @default []
+			 */
+			"aoDestroyCallback": [],
+=09=09
+=09=09
+			/**
+			 * Get the number of records in the current record set, before filtering
+			 *  @type function
+			 */
+			"fnRecordsTotal": function ()
+			{
+				return _fnDataSource( this ) =3D=3D 'ssp' ?
+					this._iRecordsTotal * 1 :
+					this.aiDisplayMaster.length;
+			},
+=09=09
+			/**
+			 * Get the number of records in the current record set, after filtering
+			 *  @type function
+			 */
+			"fnRecordsDisplay": function ()
+			{
+				return _fnDataSource( this ) =3D=3D 'ssp' ?
+					this._iRecordsDisplay * 1 :
+					this.aiDisplay.length;
+			},
+=09=09
+			/**
+			 * Get the display end point - aiDisplay index
+			 *  @type function
+			 */
+			"fnDisplayEnd": function ()
+			{
+				var
+					len      =3D this._iDisplayLength,
+					start    =3D this._iDisplayStart,
+					calc     =3D start + len,
+					records  =3D this.aiDisplay.length,
+					features =3D this.oFeatures,
+					paginate =3D features.bPaginate;
+=09=09
+				if ( features.bServerSide ) {
+					return paginate =3D=3D=3D false || len =3D=3D=3D -1 ?
+						start + records :
+						Math.min( start+len, this._iRecordsDisplay );
+				}
+				else {
+					return ! paginate || calc>records || len=3D=3D=3D-1 ?
+						records :
+						calc;
+				}
+			},
+=09=09
+			/**
+			 * The DataTables object for this table
+			 *  @type object
+			 *  @default null
+			 */
+			"oInstance": null,
+=09=09
+			/**
+			 * Unique identifier for each instance of the DataTables object. If the=
re
+			 * is an ID on the table node, then it takes that value, otherwise an
+			 * incrementing internal counter is used.
+			 *  @type string
+			 *  @default null
+			 */
+			"sInstance": null,
+=09=09
+			/**
+			 * tabindex attribute value that is added to DataTables control element=
s, allowing
+			 * keyboard navigation of the table and its controls.
+			 */
+			"iTabIndex": 0,
+=09=09
+			/**
+			 * DIV container for the footer scrolling table if scrolling
+			 */
+			"nScrollHead": null,
+=09=09
+			/**
+			 * DIV container for the footer scrolling table if scrolling
+			 */
+			"nScrollFoot": null,
+=09=09
+			/**
+			 * Last applied sort
+			 *  @type array
+			 *  @default []
+			 */
+			"aLastSort": [],
+=09=09
+			/**
+			 * Stored plug-in instances
+			 *  @type object
+			 *  @default {}
+			 */
+			"oPlugins": {},
+=09=09
+			/**
+			 * Function used to get a row's id from the row's data
+			 *  @type function
+			 *  @default null
+			 */
+			"rowIdFn": null,
+=09=09
+			/**
+			 * Data location where to store a row's id
+			 *  @type string
+			 *  @default null
+			 */
+			"rowId": null
+		};
+=09=09
+		/**
+		 * Extension object for DataTables that is used to provide all extension
+		 * options.
+		 *
+		 * Note that the `DataTable.ext` object is available through
+		 * `jQuery.fn.dataTable.ext` where it may be accessed and manipulated. I=
t is
+		 * also aliased to `jQuery.fn.dataTableExt` for historic reasons.
+		 *  @namespace
+		 *  @extends DataTable.models.ext
+		 */
+=09=09
+=09=09
+		/**
+		 * DataTables extensions
+		 *=20
+		 * This namespace acts as a collection area for plug-ins that can be use=
d to
+		 * extend DataTables capabilities. Indeed many of the build in methods
+		 * use this method to provide their own capabilities (sorting methods for
+		 * example).
+		 *
+		 * Note that this namespace is aliased to `jQuery.fn.dataTableExt` for l=
egacy
+		 * reasons
+		 *
+		 *  @namespace
+		 */
+		DataTable.ext =3D _ext =3D {
+			/**
+			 * Buttons. For use with the Buttons extension for DataTables. This is
+			 * defined here so other extensions can define buttons regardless of lo=
ad
+			 * order. It is _not_ used by DataTables core.
+			 *
+			 *  @type object
+			 *  @default {}
+			 */
+			buttons: {},
+=09=09
+=09=09
+			/**
+			 * Element class names
+			 *
+			 *  @type object
+			 *  @default {}
+			 */
+			classes: {},
+=09=09
+=09=09
+			/**
+			 * DataTables build type (expanded by the download builder)
+			 *
+			 *  @type string
+			 */
+			builder: "-source-",
+=09=09
+=09=09
+			/**
+			 * Error reporting.
+			 *=20
+			 * How should DataTables report an error. Can take the value 'alert',
+			 * 'throw', 'none' or a function.
+			 *
+			 *  @type string|function
+			 *  @default alert
+			 */
+			errMode: "alert",
+=09=09
+=09=09
+			/**
+			 * Feature plug-ins.
+			 *=20
+			 * This is an array of objects which describe the feature plug-ins that=
 are
+			 * available to DataTables. These feature plug-ins are then available f=
or
+			 * use through the `dom` initialisation option.
+			 *=20
+			 * Each feature plug-in is described by an object which must have the
+			 * following properties:
+			 *=20
+			 * * `fnInit` - function that is used to initialise the plug-in,
+			 * * `cFeature` - a character so the feature can be enabled by the `dom`
+			 *   instillation option. This is case sensitive.
+			 *
+			 * The `fnInit` function has the following input parameters:
+			 *
+			 * 1. `{object}` DataTables settings object: see
+			 *    {@link DataTable.models.oSettings}
+			 *
+			 * And the following return is expected:
+			 *=20
+			 * * {node|null} The element which contains your feature. Note that the
+			 *   return may also be void if your plug-in does not require to inject=
 any
+			 *   DOM elements into DataTables control (`dom`) - for example this mi=
ght
+			 *   be useful when developing a plug-in which allows table control via
+			 *   keyboard entry
+			 *
+			 *  @type array
+			 *
+			 *  @example
+			 *    $.fn.dataTable.ext.features.push( {
+			 *      "fnInit": function( oSettings ) {
+			 *        return new TableTools( { "oDTSettings": oSettings } );
+			 *      },
+			 *      "cFeature": "T"
+			 *    } );
+			 */
+			feature: [],
+=09=09
+=09=09
+			/**
+			 * Row searching.
+			 *=20
+			 * This method of searching is complimentary to the default type based
+			 * searching, and a lot more comprehensive as it allows you complete co=
ntrol
+			 * over the searching logic. Each element in this array is a function
+			 * (parameters described below) that is called for every row in the tab=
le,
+			 * and your logic decides if it should be included in the searching dat=
a set
+			 * or not.
+			 *
+			 * Searching functions have the following input parameters:
+			 *
+			 * 1. `{object}` DataTables settings object: see
+			 *    {@link DataTable.models.oSettings}
+			 * 2. `{array|object}` Data for the row to be processed (same as the
+			 *    original format that was passed in as the data source, or an array
+			 *    from a DOM data source
+			 * 3. `{int}` Row index ({@link DataTable.models.oSettings.aoData}), wh=
ich
+			 *    can be useful to retrieve the `TR` element if you need DOM intera=
ction.
+			 *
+			 * And the following return is expected:
+			 *
+			 * * {boolean} Include the row in the searched result set (true) or not
+			 *   (false)
+			 *
+			 * Note that as with the main search ability in DataTables, technically=
 this
+			 * is "filtering", since it is subtractive. However, for consistency in
+			 * naming we call it searching here.
+			 *
+			 *  @type array
+			 *  @default []
+			 *
+			 *  @example
+			 *    // The following example shows custom search being applied to the
+			 *    // fourth column (i.e. the data[3] index) based on two input valu=
es
+			 *    // from the end-user, matching the data in a certain range.
+			 *    $.fn.dataTable.ext.search.push(
+			 *      function( settings, data, dataIndex ) {
+			 *        var min =3D document.getElementById('min').value * 1;
+			 *        var max =3D document.getElementById('max').value * 1;
+			 *        var version =3D data[3] =3D=3D "-" ? 0 : data[3]*1;
+			 *
+			 *        if ( min =3D=3D "" && max =3D=3D "" ) {
+			 *          return true;
+			 *        }
+			 *        else if ( min =3D=3D "" && version < max ) {
+			 *          return true;
+			 *        }
+			 *        else if ( min < version && "" =3D=3D max ) {
+			 *          return true;
+			 *        }
+			 *        else if ( min < version && version < max ) {
+			 *          return true;
+			 *        }
+			 *        return false;
+			 *      }
+			 *    );
+			 */
+			search: [],
+=09=09
+=09=09
+			/**
+			 * Selector extensions
+			 *
+			 * The `selector` option can be used to extend the options available fo=
r the
+			 * selector modifier options (`selector-modifier` object data type) that
+			 * each of the three built in selector types offer (row, column and cel=
l +
+			 * their plural counterparts). For example the Select extension uses th=
is
+			 * mechanism to provide an option to select only rows, columns and cells
+			 * that have been marked as selected by the end user (`{selected: true}=
`),
+			 * which can be used in conjunction with the existing built in selector
+			 * options.
+			 *
+			 * Each property is an array to which functions can be pushed. The func=
tions
+			 * take three attributes:
+			 *
+			 * * Settings object for the host table
+			 * * Options object (`selector-modifier` object type)
+			 * * Array of selected item indexes
+			 *
+			 * The return is an array of the resulting item indexes after the custom
+			 * selector has been applied.
+			 *
+			 *  @type object
+			 */
+			selector: {
+				cell: [],
+				column: [],
+				row: []
+			},
+=09=09
+=09=09
+			/**
+			 * Internal functions, exposed for used in plug-ins.
+			 *=20
+			 * Please note that you should not need to use the internal methods for
+			 * anything other than a plug-in (and even then, try to avoid if possib=
le).
+			 * The internal function may change between releases.
+			 *
+			 *  @type object
+			 *  @default {}
+			 */
+			internal: {},
+=09=09
+=09=09
+			/**
+			 * Legacy configuration options. Enable and disable legacy options that
+			 * are available in DataTables.
+			 *
+			 *  @type object
+			 */
+			legacy: {
+				/**
+				 * Enable / disable DataTables 1.9 compatible server-side processing
+				 * requests
+				 *
+				 *  @type boolean
+				 *  @default null
+				 */
+				ajax: null
+			},
+=09=09
+=09=09
+			/**
+			 * Pagination plug-in methods.
+			 *=20
+			 * Each entry in this object is a function and defines which buttons sh=
ould
+			 * be shown by the pagination rendering method that is used for the tab=
le:
+			 * {@link DataTable.ext.renderer.pageButton}. The renderer addresses ho=
w the
+			 * buttons are displayed in the document, while the functions here tell=
 it
+			 * what buttons to display. This is done by returning an array of button
+			 * descriptions (what each button will do).
+			 *
+			 * Pagination types (the four built in options and any additional plug-=
in
+			 * options defined here) can be used through the `paginationType`
+			 * initialisation parameter.
+			 *
+			 * The functions defined take two parameters:
+			 *
+			 * 1. `{int} page` The current page index
+			 * 2. `{int} pages` The number of pages in the table
+			 *
+			 * Each function is expected to return an array where each element of t=
he
+			 * array can be one of:
+			 *
+			 * * `first` - Jump to first page when activated
+			 * * `last` - Jump to last page when activated
+			 * * `previous` - Show previous page when activated
+			 * * `next` - Show next page when activated
+			 * * `{int}` - Show page of the index given
+			 * * `{array}` - A nested array containing the above elements to add a
+			 *   containing 'DIV' element (might be useful for styling).
+			 *
+			 * Note that DataTables v1.9- used this object slightly differently whe=
reby
+			 * an object with two functions would be defined for each plug-in. That
+			 * ability is still supported by DataTables 1.10+ to provide backwards
+			 * compatibility, but this option of use is now decremented and no long=
er
+			 * documented in DataTables 1.10+.
+			 *
+			 *  @type object
+			 *  @default {}
+			 *
+			 *  @example
+			 *    // Show previous, next and current page buttons only
+			 *    $.fn.dataTableExt.oPagination.current =3D function ( page, pages =
) {
+			 *      return [ 'previous', page, 'next' ];
+			 *    };
+			 */
+			pager: {},
+=09=09
+=09=09
+			renderer: {
+				pageButton: {},
+				header: {}
+			},
+=09=09
+=09=09
+			/**
+			 * Ordering plug-ins - custom data source
+			 *=20
+			 * The extension options for ordering of data available here is complim=
entary
+			 * to the default type based ordering that DataTables typically uses. It
+			 * allows much greater control over the the data that is being used to
+			 * order a column, but is necessarily therefore more complex.
+			 *=20
+			 * This type of ordering is useful if you want to do ordering based on =
data
+			 * live from the DOM (for example the contents of an 'input' element) r=
ather
+			 * than just the static string that DataTables knows of.
+			 *=20
+			 * The way these plug-ins work is that you create an array of the value=
s you
+			 * wish to be ordering for the column in question and then return that
+			 * array. The data in the array much be in the index order of the rows =
in
+			 * the table (not the currently ordering order!). Which order data gath=
ering
+			 * function is run here depends on the `dt-init columns.orderDataType`
+			 * parameter that is used for the column (if any).
+			 *
+			 * The functions defined take two parameters:
+			 *
+			 * 1. `{object}` DataTables settings object: see
+			 *    {@link DataTable.models.oSettings}
+			 * 2. `{int}` Target column index
+			 *
+			 * Each function is expected to return an array:
+			 *
+			 * * `{array}` Data for the column to be ordering upon
+			 *
+			 *  @type array
+			 *
+			 *  @example
+			 *    // Ordering using `input` node values
+			 *    $.fn.dataTable.ext.order['dom-text'] =3D function  ( settings, co=
l )
+			 *    {
+			 *      return this.api().column( col, {order:'index'} ).nodes().map( f=
unction ( td, i ) {
+			 *        return $('input', td).val();
+			 *      } );
+			 *    }
+			 */
+			order: {},
+=09=09
+=09=09
+			/**
+			 * Type based plug-ins.
+			 *
+			 * Each column in DataTables has a type assigned to it, either by autom=
atic
+			 * detection or by direct assignment using the `type` option for the co=
lumn.
+			 * The type of a column will effect how it is ordering and search (plug=
-ins
+			 * can also make use of the column type if required).
+			 *
+			 * @namespace
+			 */
+			type: {
+				/**
+				 * Type detection functions.
+				 *
+				 * The functions defined in this object are used to automatically dete=
ct
+				 * a column's type, making initialisation of DataTables super easy, ev=
en
+				 * when complex data is in the table.
+				 *
+				 * The functions defined take two parameters:
+				 *
+			     *  1. `{*}` Data from the column cell to be analysed
+			     *  2. `{settings}` DataTables settings object. This can be used to
+			     *     perform context specific type detection - for example detect=
ion
+			     *     based on language settings such as using a comma for a decim=
al
+			     *     place. Generally speaking the options from the settings will=
 not
+			     *     be required
+				 *
+				 * Each function is expected to return:
+				 *
+				 * * `{string|null}` Data type detected, or null if unknown (and thus
+				 *   pass it on to the other type detection functions.
+				 *
+				 *  @type array
+				 *
+				 *  @example
+				 *    // Currency type detection plug-in:
+				 *    $.fn.dataTable.ext.type.detect.push(
+				 *      function ( data, settings ) {
+				 *        // Check the numeric part
+				 *        if ( ! data.substring(1).match(/[0-9]/) ) {
+				 *          return null;
+				 *        }
+				 *
+				 *        // Check prefixed by currency
+				 *        if ( data.charAt(0) =3D=3D '$' || data.charAt(0) =3D=3D '&po=
und;' ) {
+				 *          return 'currency';
+				 *        }
+				 *        return null;
+				 *      }
+				 *    );
+				 */
+				detect: [],
+=09=09
+=09=09
+				/**
+				 * Type based search formatting.
+				 *
+				 * The type based searching functions can be used to pre-format the
+				 * data to be search on. For example, it can be used to strip HTML
+				 * tags or to de-format telephone numbers for numeric only searching.
+				 *
+				 * Note that is a search is not defined for a column of a given type,
+				 * no search formatting will be performed.
+				 *=20
+				 * Pre-processing of searching data plug-ins - When you assign the sTy=
pe
+				 * for a column (or have it automatically detected for you by DataTabl=
es
+				 * or a type detection plug-in), you will typically be using this for
+				 * custom sorting, but it can also be used to provide custom searching
+				 * by allowing you to pre-processing the data and returning the data in
+				 * the format that should be searched upon. This is done by adding
+				 * functions this object with a parameter name which matches the sType
+				 * for that target column. This is the corollary of <i>afnSortData</i>
+				 * for searching data.
+				 *
+				 * The functions defined take a single parameter:
+				 *
+			     *  1. `{*}` Data from the column cell to be prepared for searching
+				 *
+				 * Each function is expected to return:
+				 *
+				 * * `{string|null}` Formatted string that will be used for the search=
ing.
+				 *
+				 *  @type object
+				 *  @default {}
+				 *
+				 *  @example
+				 *    $.fn.dataTable.ext.type.search['title-numeric'] =3D function ( d=
 ) {
+				 *      return d.replace(/\n/g," ").replace( /<.*?>/g, "" );
+				 *    }
+				 */
+				search: {},
+=09=09
+=09=09
+				/**
+				 * Type based ordering.
+				 *
+				 * The column type tells DataTables what ordering to apply to the table
+				 * when a column is sorted upon. The order for each type that is defin=
ed,
+				 * is defined by the functions available in this object.
+				 *
+				 * Each ordering option can be described by three properties added to
+				 * this object:
+				 *
+				 * * `{type}-pre` - Pre-formatting function
+				 * * `{type}-asc` - Ascending order function
+				 * * `{type}-desc` - Descending order function
+				 *
+				 * All three can be used together, only `{type}-pre` or only
+				 * `{type}-asc` and `{type}-desc` together. It is generally recommended
+				 * that only `{type}-pre` is used, as this provides the optimal
+				 * implementation in terms of speed, although the others are provided
+				 * for compatibility with existing Javascript sort functions.
+				 *
+				 * `{type}-pre`: Functions defined take a single parameter:
+				 *
+			     *  1. `{*}` Data from the column cell to be prepared for ordering
+				 *
+				 * And return:
+				 *
+				 * * `{*}` Data to be sorted upon
+				 *
+				 * `{type}-asc` and `{type}-desc`: Functions are typical Javascript so=
rt
+				 * functions, taking two parameters:
+				 *
+			     *  1. `{*}` Data to compare to the second parameter
+			     *  2. `{*}` Data to compare to the first parameter
+				 *
+				 * And returning:
+				 *
+				 * * `{*}` Ordering match: <0 if first parameter should be sorted lower
+				 *   than the second parameter, =3D=3D=3D0 if the two parameters are e=
qual and
+				 *   >0 if the first parameter should be sorted height than the second
+				 *   parameter.
+				 *=20
+				 *  @type object
+				 *  @default {}
+				 *
+				 *  @example
+				 *    // Numeric ordering of formatted numbers with a pre-formatter
+				 *    $.extend( $.fn.dataTable.ext.type.order, {
+				 *      "string-pre": function(x) {
+				 *        a =3D (a =3D=3D=3D "-" || a =3D=3D=3D "") ? 0 : a.replace( /=
[^\d\-\.]/g, "" );
+				 *        return parseFloat( a );
+				 *      }
+				 *    } );
+				 *
+				 *  @example
+				 *    // Case-sensitive string ordering, with no pre-formatting method
+				 *    $.extend( $.fn.dataTable.ext.order, {
+				 *      "string-case-asc": function(x,y) {
+				 *        return ((x < y) ? -1 : ((x > y) ? 1 : 0));
+				 *      },
+				 *      "string-case-desc": function(x,y) {
+				 *        return ((x < y) ? 1 : ((x > y) ? -1 : 0));
+				 *      }
+				 *    } );
+				 */
+				order: {}
+			},
+=09=09
+			/**
+			 * Unique DataTables instance counter
+			 *
+			 * @type int
+			 * @private
+			 */
+			_unique: 0,
+=09=09
+=09=09
+			//
+			// Depreciated
+			// The following properties are retained for backwards compatibility on=
ly.
+			// The should not be used in new projects and will be removed in a futu=
re
+			// version
+			//
+=09=09
+			/**
+			 * Version check function.
+			 *  @type function
+			 *  @depreciated Since 1.10
+			 */
+			fnVersionCheck: DataTable.fnVersionCheck,
+=09=09
+=09=09
+			/**
+			 * Index for what 'this' index API functions should use
+			 *  @type int
+			 *  @deprecated Since v1.10
+			 */
+			iApiIndex: 0,
+=09=09
+=09=09
+			/**
+			 * jQuery UI class container
+			 *  @type object
+			 *  @deprecated Since v1.10
+			 */
+			oJUIClasses: {},
+=09=09
+=09=09
+			/**
+			 * Software version
+			 *  @type string
+			 *  @deprecated Since v1.10
+			 */
+			sVersion: DataTable.version
+		};
+=09=09
+=09=09
+		//
+		// Backwards compatibility. Alias to pre 1.10 Hungarian notation counter=
 parts
+		//
+		$.extend( _ext, {
+			afnFiltering: _ext.search,
+			aTypes:       _ext.type.detect,
+			ofnSearch:    _ext.type.search,
+			oSort:        _ext.type.order,
+			afnSortData:  _ext.order,
+			aoFeatures:   _ext.feature,
+			oApi:         _ext.internal,
+			oStdClasses:  _ext.classes,
+			oPagination:  _ext.pager
+		} );
+=09=09
+=09=09
+		$.extend( DataTable.ext.classes, {
+			"sTable": "dataTable",
+			"sNoFooter": "no-footer",
+=09=09
+			/* Paging buttons */
+			"sPageButton": "paginate_button",
+			"sPageButtonActive": "current",
+			"sPageButtonDisabled": "disabled",
+=09=09
+			/* Striping classes */
+			"sStripeOdd": "odd",
+			"sStripeEven": "even",
+=09=09
+			/* Empty row */
+			"sRowEmpty": "dataTables_empty",
+=09=09
+			/* Features */
+			"sWrapper": "dataTables_wrapper",
+			"sFilter": "dataTables_filter",
+			"sInfo": "dataTables_info",
+			"sPaging": "dataTables_paginate paging_", /* Note that the type is post=
fixed */
+			"sLength": "dataTables_length",
+			"sProcessing": "dataTables_processing",
+=09=09
+			/* Sorting */
+			"sSortAsc": "sorting_asc",
+			"sSortDesc": "sorting_desc",
+			"sSortable": "sorting", /* Sortable in both directions */
+			"sSortableAsc": "sorting_desc_disabled",
+			"sSortableDesc": "sorting_asc_disabled",
+			"sSortableNone": "sorting_disabled",
+			"sSortColumn": "sorting_", /* Note that an int is postfixed for the sor=
ting order */
+=09=09
+			/* Filtering */
+			"sFilterInput": "",
+=09=09
+			/* Page length */
+			"sLengthSelect": "",
+=09=09
+			/* Scrolling */
+			"sScrollWrapper": "dataTables_scroll",
+			"sScrollHead": "dataTables_scrollHead",
+			"sScrollHeadInner": "dataTables_scrollHeadInner",
+			"sScrollBody": "dataTables_scrollBody",
+			"sScrollFoot": "dataTables_scrollFoot",
+			"sScrollFootInner": "dataTables_scrollFootInner",
+=09=09
+			/* Misc */
+			"sHeaderTH": "",
+			"sFooterTH": "",
+=09=09
+			// Deprecated
+			"sSortJUIAsc": "",
+			"sSortJUIDesc": "",
+			"sSortJUI": "",
+			"sSortJUIAscAllowed": "",
+			"sSortJUIDescAllowed": "",
+			"sSortJUIWrapper": "",
+			"sSortIcon": "",
+			"sJUIHeader": "",
+			"sJUIFooter": ""
+		} );
+=09=09
+=09=09
+		var extPagination =3D DataTable.ext.pager;
+=09=09
+		function _numbers ( page, pages ) {
+			var
+				numbers =3D [],
+				buttons =3D extPagination.numbers_length,
+				half =3D Math.floor( buttons / 2 ),
+				i =3D 1;
+=09=09
+			if ( pages <=3D buttons ) {
+				numbers =3D _range( 0, pages );
+			}
+			else if ( page <=3D half ) {
+				numbers =3D _range( 0, buttons-2 );
+				numbers.push( 'ellipsis' );
+				numbers.push( pages-1 );
+			}
+			else if ( page >=3D pages - 1 - half ) {
+				numbers =3D _range( pages-(buttons-2), pages );
+				numbers.splice( 0, 0, 'ellipsis' ); // no unshift in ie6
+				numbers.splice( 0, 0, 0 );
+			}
+			else {
+				numbers =3D _range( page-half+2, page+half-1 );
+				numbers.push( 'ellipsis' );
+				numbers.push( pages-1 );
+				numbers.splice( 0, 0, 'ellipsis' );
+				numbers.splice( 0, 0, 0 );
+			}
+=09=09
+			numbers.DT_el =3D 'span';
+			return numbers;
+		}
+=09=09
+=09=09
+		$.extend( extPagination, {
+			simple: function ( page, pages ) {
+				return [ 'previous', 'next' ];
+			},
+=09=09
+			full: function ( page, pages ) {
+				return [  'first', 'previous', 'next', 'last' ];
+			},
+=09=09
+			numbers: function ( page, pages ) {
+				return [ _numbers(page, pages) ];
+			},
+=09=09
+			simple_numbers: function ( page, pages ) {
+				return [ 'previous', _numbers(page, pages), 'next' ];
+			},
+=09=09
+			full_numbers: function ( page, pages ) {
+				return [ 'first', 'previous', _numbers(page, pages), 'next', 'last' ];
+			},
+=09=09=09
+			first_last_numbers: function (page, pages) {
+		 		return ['first', _numbers(page, pages), 'last'];
+		 	},
+=09=09
+			// For testing and plug-ins to use
+			_numbers: _numbers,
+=09=09
+			// Number of number buttons (including ellipsis) to show. _Must be odd!_
+			numbers_length: 7
+		} );
+=09=09
+=09=09
+		$.extend( true, DataTable.ext.renderer, {
+			pageButton: {
+				_: function ( settings, host, idx, buttons, page, pages ) {
+					var classes =3D settings.oClasses;
+					var lang =3D settings.oLanguage.oPaginate;
+					var aria =3D settings.oLanguage.oAria.paginate || {};
+					var btnDisplay, btnClass, counter=3D0;
+=09=09
+					var attach =3D function( container, buttons ) {
+						var i, ien, node, button, tabIndex;
+						var disabledClass =3D classes.sPageButtonDisabled;
+						var clickHandler =3D function ( e ) {
+							_fnPageChange( settings, e.data.action, true );
+						};
+=09=09
+						for ( i=3D0, ien=3Dbuttons.length ; i<ien ; i++ ) {
+							button =3D buttons[i];
+=09=09
+							if ( Array.isArray( button ) ) {
+								var inner =3D $( '<'+(button.DT_el || 'div')+'/>' )
+									.appendTo( container );
+								attach( inner, button );
+							}
+							else {
+								btnDisplay =3D null;
+								btnClass =3D button;
+								tabIndex =3D settings.iTabIndex;
+=09=09
+								switch ( button ) {
+									case 'ellipsis':
+										container.append('<span class=3D"ellipsis">&#x2026;</span>');
+										break;
+=09=09
+									case 'first':
+										btnDisplay =3D lang.sFirst;
+=09=09
+										if ( page =3D=3D=3D 0 ) {
+											tabIndex =3D -1;
+											btnClass +=3D ' ' + disabledClass;
+										}
+										break;
+=09=09
+									case 'previous':
+										btnDisplay =3D lang.sPrevious;
+=09=09
+										if ( page =3D=3D=3D 0 ) {
+											tabIndex =3D -1;
+											btnClass +=3D ' ' + disabledClass;
+										}
+										break;
+=09=09
+									case 'next':
+										btnDisplay =3D lang.sNext;
+=09=09
+										if ( pages =3D=3D=3D 0 || page =3D=3D=3D pages-1 ) {
+											tabIndex =3D -1;
+											btnClass +=3D ' ' + disabledClass;
+										}
+										break;
+=09=09
+									case 'last':
+										btnDisplay =3D lang.sLast;
+=09=09
+										if ( pages =3D=3D=3D 0 || page =3D=3D=3D pages-1 ) {
+											tabIndex =3D -1;
+											btnClass +=3D ' ' + disabledClass;
+										}
+										break;
+=09=09
+									default:
+										btnDisplay =3D settings.fnFormatNumber( button + 1 );
+										btnClass =3D page =3D=3D=3D button ?
+											classes.sPageButtonActive : '';
+										break;
+								}
+=09=09
+								if ( btnDisplay !=3D=3D null ) {
+									node =3D $('<a>', {
+											'class': classes.sPageButton+' '+btnClass,
+											'aria-controls': settings.sTableId,
+											'aria-label': aria[ button ],
+											'data-dt-idx': counter,
+											'tabindex': tabIndex,
+											'id': idx =3D=3D=3D 0 && typeof button =3D=3D=3D 'string' ?
+												settings.sTableId +'_'+ button :
+												null
+										} )
+										.html( btnDisplay )
+										.appendTo( container );
+=09=09
+									_fnBindAction(
+										node, {action: button}, clickHandler
+									);
+=09=09
+									counter++;
+								}
+							}
+						}
+					};
+=09=09
+					// IE9 throws an 'unknown error' if document.activeElement is used
+					// inside an iframe or frame. Try / catch the error. Not good for
+					// accessibility, but neither are frames.
+					var activeEl;
+=09=09
+					try {
+						// Because this approach is destroying and recreating the paging
+						// elements, focus is lost on the select button which is bad for
+						// accessibility. So we want to restore focus once the draw has
+						// completed
+						activeEl =3D $(host).find(document.activeElement).data('dt-idx');
+					}
+					catch (e) {}
+=09=09
+					attach( $(host).empty(), buttons );
+=09=09
+					if ( activeEl !=3D=3D undefined ) {
+						$(host).find( '[data-dt-idx=3D'+activeEl+']' ).trigger('focus');
+					}
+				}
+			}
+		} );
+=09=09
+=09=09
+=09=09
+		// Built in type detection. See model.ext.aTypes for information about
+		// what is required from this methods.
+		$.extend( DataTable.ext.type.detect, [
+			// Plain numbers - first since V8 detects some plain numbers as dates
+			// e.g. Date.parse('55') (but not all, e.g. Date.parse('22')...).
+			function ( d, settings )
+			{
+				var decimal =3D settings.oLanguage.sDecimal;
+				return _isNumber( d, decimal ) ? 'num'+decimal : null;
+			},
+=09=09
+			// Dates (only those recognised by the browser's Date.parse)
+			function ( d, settings )
+			{
+				// V8 tries _very_ hard to make a string passed into `Date.parse()`
+				// valid, so we need to use a regex to restrict date formats. Use a
+				// plug-in for anything other than ISO8601 style strings
+				if ( d && !(d instanceof Date) && ! _re_date.test(d) ) {
+					return null;
+				}
+				var parsed =3D Date.parse(d);
+				return (parsed !=3D=3D null && !isNaN(parsed)) || _empty(d) ? 'date' :=
 null;
+			},
+=09=09
+			// Formatted numbers
+			function ( d, settings )
+			{
+				var decimal =3D settings.oLanguage.sDecimal;
+				return _isNumber( d, decimal, true ) ? 'num-fmt'+decimal : null;
+			},
+=09=09
+			// HTML numeric
+			function ( d, settings )
+			{
+				var decimal =3D settings.oLanguage.sDecimal;
+				return _htmlNumeric( d, decimal ) ? 'html-num'+decimal : null;
+			},
+=09=09
+			// HTML numeric, formatted
+			function ( d, settings )
+			{
+				var decimal =3D settings.oLanguage.sDecimal;
+				return _htmlNumeric( d, decimal, true ) ? 'html-num-fmt'+decimal : nul=
l;
+			},
+=09=09
+			// HTML (this is strict checking - there must be html)
+			function ( d, settings )
+			{
+				return _empty( d ) || (typeof d =3D=3D=3D 'string' && d.indexOf('<') !=
=3D=3D -1) ?
+					'html' : null;
+			}
+		] );
+=09=09
+=09=09
+=09=09
+		// Filter formatting functions. See model.ext.ofnSearch for information =
about
+		// what is required from these methods.
+		//=20
+		// Note that additional search methods are added for the html numbers and
+		// html formatted numbers by `_addNumericSort()` when we know what the d=
ecimal
+		// place is
+=09=09
+=09=09
+		$.extend( DataTable.ext.type.search, {
+			html: function ( data ) {
+				return _empty(data) ?
+					data :
+					typeof data =3D=3D=3D 'string' ?
+						data
+							.replace( _re_new_lines, " " )
+							.replace( _re_html, "" ) :
+						'';
+			},
+=09=09
+			string: function ( data ) {
+				return _empty(data) ?
+					data :
+					typeof data =3D=3D=3D 'string' ?
+						data.replace( _re_new_lines, " " ) :
+						data;
+			}
+		} );
+=09=09
+=09=09
+=09=09
+		var __numericReplace =3D function ( d, decimalPlace, re1, re2 ) {
+			if ( d !=3D=3D 0 && (!d || d =3D=3D=3D '-') ) {
+				return -Infinity;
+			}
+=09=09
+			// If a decimal place other than `.` is used, it needs to be given to t=
he
+			// function so we can detect it and replace with a `.` which is the only
+			// decimal place Javascript recognises - it is not locale aware.
+			if ( decimalPlace ) {
+				d =3D _numToDecimal( d, decimalPlace );
+			}
+=09=09
+			if ( d.replace ) {
+				if ( re1 ) {
+					d =3D d.replace( re1, '' );
+				}
+=09=09
+				if ( re2 ) {
+					d =3D d.replace( re2, '' );
+				}
+			}
+=09=09
+			return d * 1;
+		};
+=09=09
+=09=09
+		// Add the numeric 'deformatting' functions for sorting and search. This=
 is done
+		// in a function to provide an easy ability for the language options to =
add
+		// additional methods if a non-period decimal place is used.
+		function _addNumericSort ( decimalPlace ) {
+			$.each(
+				{
+					// Plain numbers
+					"num": function ( d ) {
+						return __numericReplace( d, decimalPlace );
+					},
+=09=09
+					// Formatted numbers
+					"num-fmt": function ( d ) {
+						return __numericReplace( d, decimalPlace, _re_formatted_numeric );
+					},
+=09=09
+					// HTML numeric
+					"html-num": function ( d ) {
+						return __numericReplace( d, decimalPlace, _re_html );
+					},
+=09=09
+					// HTML numeric, formatted
+					"html-num-fmt": function ( d ) {
+						return __numericReplace( d, decimalPlace, _re_html, _re_formatted_nu=
meric );
+					}
+				},
+				function ( key, fn ) {
+					// Add the ordering method
+					_ext.type.order[ key+decimalPlace+'-pre' ] =3D fn;
+=09=09
+					// For HTML types add a search formatter that will strip the HTML
+					if ( key.match(/^html\-/) ) {
+						_ext.type.search[ key+decimalPlace ] =3D _ext.type.search.html;
+					}
+				}
+			);
+		}
+=09=09
+=09=09
+		// Default sort methods
+		$.extend( _ext.type.order, {
+			// Dates
+			"date-pre": function ( d ) {
+				var ts =3D Date.parse( d );
+				return isNaN(ts) ? -Infinity : ts;
+			},
+=09=09
+			// html
+			"html-pre": function ( a ) {
+				return _empty(a) ?
+					'' :
+					a.replace ?
+						a.replace( /<.*?>/g, "" ).toLowerCase() :
+						a+'';
+			},
+=09=09
+			// string
+			"string-pre": function ( a ) {
+				// This is a little complex, but faster than always calling toString,
+				// http://jsperf.com/tostring-v-check
+				return _empty(a) ?
+					'' :
+					typeof a =3D=3D=3D 'string' ?
+						a.toLowerCase() :
+						! a.toString ?
+							'' :
+							a.toString();
+			},
+=09=09
+			// string-asc and -desc are retained only for compatibility with the old
+			// sort methods
+			"string-asc": function ( x, y ) {
+				return ((x < y) ? -1 : ((x > y) ? 1 : 0));
+			},
+=09=09
+			"string-desc": function ( x, y ) {
+				return ((x < y) ? 1 : ((x > y) ? -1 : 0));
+			}
+		} );
+=09=09
+=09=09
+		// Numeric sorting types - order doesn't matter here
+		_addNumericSort( '' );
+=09=09
+=09=09
+		$.extend( true, DataTable.ext.renderer, {
+			header: {
+				_: function ( settings, cell, column, classes ) {
+					// No additional mark-up required
+					// Attach a sort listener to update on sort - note that using the
+					// `DT` namespace will allow the event to be removed automatically
+					// on destroy, while the `dt` namespaced event is the one we are
+					// listening for
+					$(settings.nTable).on( 'order.dt.DT', function ( e, ctx, sorting, col=
umns ) {
+						if ( settings !=3D=3D ctx ) { // need to check this this is the host
+							return;               // table, not a nested one
+						}
+=09=09
+						var colIdx =3D column.idx;
+=09=09
+						cell
+							.removeClass(
+								classes.sSortAsc +' '+
+								classes.sSortDesc
+							)
+							.addClass( columns[ colIdx ] =3D=3D 'asc' ?
+								classes.sSortAsc : columns[ colIdx ] =3D=3D 'desc' ?
+									classes.sSortDesc :
+									column.sSortingClass
+							);
+					} );
+				},
+=09=09
+				jqueryui: function ( settings, cell, column, classes ) {
+					$('<div/>')
+						.addClass( classes.sSortJUIWrapper )
+						.append( cell.contents() )
+						.append( $('<span/>')
+							.addClass( classes.sSortIcon+' '+column.sSortingClassJUI )
+						)
+						.appendTo( cell );
+=09=09
+					// Attach a sort listener to update on sort
+					$(settings.nTable).on( 'order.dt.DT', function ( e, ctx, sorting, col=
umns ) {
+						if ( settings !=3D=3D ctx ) {
+							return;
+						}
+=09=09
+						var colIdx =3D column.idx;
+=09=09
+						cell
+							.removeClass( classes.sSortAsc +" "+classes.sSortDesc )
+							.addClass( columns[ colIdx ] =3D=3D 'asc' ?
+								classes.sSortAsc : columns[ colIdx ] =3D=3D 'desc' ?
+									classes.sSortDesc :
+									column.sSortingClass
+							);
+=09=09
+						cell
+							.find( 'span.'+classes.sSortIcon )
+							.removeClass(
+								classes.sSortJUIAsc +" "+
+								classes.sSortJUIDesc +" "+
+								classes.sSortJUI +" "+
+								classes.sSortJUIAscAllowed +" "+
+								classes.sSortJUIDescAllowed
+							)
+							.addClass( columns[ colIdx ] =3D=3D 'asc' ?
+								classes.sSortJUIAsc : columns[ colIdx ] =3D=3D 'desc' ?
+									classes.sSortJUIDesc :
+									column.sSortingClassJUI
+							);
+					} );
+				}
+			}
+		} );
+=09=09
+		/*
+		 * Public helper functions. These aren't used internally by DataTables, =
or
+		 * called by any of the options passed into DataTables, but they can be =
used
+		 * externally by developers working with DataTables. They are helper fun=
ctions
+		 * to make working with DataTables a little bit easier.
+		 */
+=09=09
+		var __htmlEscapeEntities =3D function ( d ) {
+			if (Array.isArray(d)) {
+				d =3D d.join(',');
+			}
+=09=09
+			return typeof d =3D=3D=3D 'string' ?
+				d
+					.replace(/&/g, '&amp;')
+					.replace(/</g, '&lt;')
+					.replace(/>/g, '&gt;')
+					.replace(/"/g, '&quot;') :
+				d;
+		};
+=09=09
+		/**
+		 * Helpers for `columns.render`.
+		 *
+		 * The options defined here can be used with the `columns.render` initia=
lisation
+		 * option to provide a display renderer. The following functions are def=
ined:
+		 *
+		 * * `number` - Will format numeric data (defined by `columns.data`) for
+		 *   display, retaining the original unformatted data for sorting and fi=
ltering.
+		 *   It takes 5 parameters:
+		 *   * `string` - Thousands grouping separator
+		 *   * `string` - Decimal point indicator
+		 *   * `integer` - Number of decimal points to show
+		 *   * `string` (optional) - Prefix.
+		 *   * `string` (optional) - Postfix (/suffix).
+		 * * `text` - Escape HTML to help prevent XSS attacks. It has no optional
+		 *   parameters.
+		 *
+		 * @example
+		 *   // Column definition using the number renderer
+		 *   {
+		 *     data: "salary",
+		 *     render: $.fn.dataTable.render.number( '\'', '.', 0, '$' )
+		 *   }
+		 *
+		 * @namespace
+		 */
+		DataTable.render =3D {
+			number: function ( thousands, decimal, precision, prefix, postfix ) {
+				return {
+					display: function ( d ) {
+						if ( typeof d !=3D=3D 'number' && typeof d !=3D=3D 'string' ) {
+							return d;
+						}
+=09=09
+						var negative =3D d < 0 ? '-' : '';
+						var flo =3D parseFloat( d );
+=09=09
+						// If NaN then there isn't much formatting that we can do - just
+						// return immediately, escaping any HTML (this was supposed to
+						// be a number after all)
+						if ( isNaN( flo ) ) {
+							return __htmlEscapeEntities( d );
+						}
+=09=09
+						flo =3D flo.toFixed( precision );
+						d =3D Math.abs( flo );
+=09=09
+						var intPart =3D parseInt( d, 10 );
+						var floatPart =3D precision ?
+							decimal+(d - intPart).toFixed( precision ).substring( 2 ):
+							'';
+=09=09
+						// If zero, then can't have a negative prefix
+						if (intPart =3D=3D=3D 0 && parseFloat(floatPart) =3D=3D=3D 0) {
+							negative =3D '';
+						}
+=09=09
+						return negative + (prefix||'') +
+							intPart.toString().replace(
+								/\B(?=3D(\d{3})+(?!\d))/g, thousands
+							) +
+							floatPart +
+							(postfix||'');
+					}
+				};
+			},
+=09=09
+			text: function () {
+				return {
+					display: __htmlEscapeEntities,
+					filter: __htmlEscapeEntities
+				};
+			}
+		};
+=09=09
+=09=09
+		/*
+		 * This is really a good bit rubbish this method of exposing the interna=
l methods
+		 * publicly... - To be fixed in 2.0 using methods on the prototype
+		 */
+=09=09
+=09=09
+		/**
+		 * Create a wrapper function for exporting an internal functions to an e=
xternal API.
+		 *  @param {string} fn API function name
+		 *  @returns {function} wrapped function
+		 *  @memberof DataTable#internal
+		 */
+		function _fnExternApiFunc (fn)
+		{
+			return function() {
+				var args =3D [_fnSettingsFromNode( this[DataTable.ext.iApiIndex] )].co=
ncat(
+					Array.prototype.slice.call(arguments)
+				);
+				return DataTable.ext.internal[fn].apply( this, args );
+			};
+		}
+=09=09
+=09=09
+		/**
+		 * Reference to internal functions for use by plug-in developers. Note t=
hat
+		 * these methods are references to internal functions and are considered=
 to be
+		 * private. If you use these methods, be aware that they are liable to c=
hange
+		 * between versions.
+		 *  @namespace
+		 */
+		$.extend( DataTable.ext.internal, {
+			_fnExternApiFunc: _fnExternApiFunc,
+			_fnBuildAjax: _fnBuildAjax,
+			_fnAjaxUpdate: _fnAjaxUpdate,
+			_fnAjaxParameters: _fnAjaxParameters,
+			_fnAjaxUpdateDraw: _fnAjaxUpdateDraw,
+			_fnAjaxDataSrc: _fnAjaxDataSrc,
+			_fnAddColumn: _fnAddColumn,
+			_fnColumnOptions: _fnColumnOptions,
+			_fnAdjustColumnSizing: _fnAdjustColumnSizing,
+			_fnVisibleToColumnIndex: _fnVisibleToColumnIndex,
+			_fnColumnIndexToVisible: _fnColumnIndexToVisible,
+			_fnVisbleColumns: _fnVisbleColumns,
+			_fnGetColumns: _fnGetColumns,
+			_fnColumnTypes: _fnColumnTypes,
+			_fnApplyColumnDefs: _fnApplyColumnDefs,
+			_fnHungarianMap: _fnHungarianMap,
+			_fnCamelToHungarian: _fnCamelToHungarian,
+			_fnLanguageCompat: _fnLanguageCompat,
+			_fnBrowserDetect: _fnBrowserDetect,
+			_fnAddData: _fnAddData,
+			_fnAddTr: _fnAddTr,
+			_fnNodeToDataIndex: _fnNodeToDataIndex,
+			_fnNodeToColumnIndex: _fnNodeToColumnIndex,
+			_fnGetCellData: _fnGetCellData,
+			_fnSetCellData: _fnSetCellData,
+			_fnSplitObjNotation: _fnSplitObjNotation,
+			_fnGetObjectDataFn: _fnGetObjectDataFn,
+			_fnSetObjectDataFn: _fnSetObjectDataFn,
+			_fnGetDataMaster: _fnGetDataMaster,
+			_fnClearTable: _fnClearTable,
+			_fnDeleteIndex: _fnDeleteIndex,
+			_fnInvalidate: _fnInvalidate,
+			_fnGetRowElements: _fnGetRowElements,
+			_fnCreateTr: _fnCreateTr,
+			_fnBuildHead: _fnBuildHead,
+			_fnDrawHead: _fnDrawHead,
+			_fnDraw: _fnDraw,
+			_fnReDraw: _fnReDraw,
+			_fnAddOptionsHtml: _fnAddOptionsHtml,
+			_fnDetectHeader: _fnDetectHeader,
+			_fnGetUniqueThs: _fnGetUniqueThs,
+			_fnFeatureHtmlFilter: _fnFeatureHtmlFilter,
+			_fnFilterComplete: _fnFilterComplete,
+			_fnFilterCustom: _fnFilterCustom,
+			_fnFilterColumn: _fnFilterColumn,
+			_fnFilter: _fnFilter,
+			_fnFilterCreateSearch: _fnFilterCreateSearch,
+			_fnEscapeRegex: _fnEscapeRegex,
+			_fnFilterData: _fnFilterData,
+			_fnFeatureHtmlInfo: _fnFeatureHtmlInfo,
+			_fnUpdateInfo: _fnUpdateInfo,
+			_fnInfoMacros: _fnInfoMacros,
+			_fnInitialise: _fnInitialise,
+			_fnInitComplete: _fnInitComplete,
+			_fnLengthChange: _fnLengthChange,
+			_fnFeatureHtmlLength: _fnFeatureHtmlLength,
+			_fnFeatureHtmlPaginate: _fnFeatureHtmlPaginate,
+			_fnPageChange: _fnPageChange,
+			_fnFeatureHtmlProcessing: _fnFeatureHtmlProcessing,
+			_fnProcessingDisplay: _fnProcessingDisplay,
+			_fnFeatureHtmlTable: _fnFeatureHtmlTable,
+			_fnScrollDraw: _fnScrollDraw,
+			_fnApplyToChildren: _fnApplyToChildren,
+			_fnCalculateColumnWidths: _fnCalculateColumnWidths,
+			_fnThrottle: _fnThrottle,
+			_fnConvertToWidth: _fnConvertToWidth,
+			_fnGetWidestNode: _fnGetWidestNode,
+			_fnGetMaxLenString: _fnGetMaxLenString,
+			_fnStringToCss: _fnStringToCss,
+			_fnSortFlatten: _fnSortFlatten,
+			_fnSort: _fnSort,
+			_fnSortAria: _fnSortAria,
+			_fnSortListener: _fnSortListener,
+			_fnSortAttachListener: _fnSortAttachListener,
+			_fnSortingClasses: _fnSortingClasses,
+			_fnSortData: _fnSortData,
+			_fnSaveState: _fnSaveState,
+			_fnLoadState: _fnLoadState,
+			_fnImplementState: _fnImplementState,
+			_fnSettingsFromNode: _fnSettingsFromNode,
+			_fnLog: _fnLog,
+			_fnMap: _fnMap,
+			_fnBindAction: _fnBindAction,
+			_fnCallbackReg: _fnCallbackReg,
+			_fnCallbackFire: _fnCallbackFire,
+			_fnLengthOverflow: _fnLengthOverflow,
+			_fnRenderer: _fnRenderer,
+			_fnDataSource: _fnDataSource,
+			_fnRowAttributes: _fnRowAttributes,
+			_fnExtend: _fnExtend,
+			_fnCalculateEnd: function () {} // Used by a lot of plug-ins, but redun=
dant
+			                                // in 1.10, so this dead-end function is
+			                                // added to prevent errors
+		} );
+=09=09
+=09=09
+		// jQuery access
+		$.fn.dataTable =3D DataTable;
+=09=09
+		// Provide access to the host jQuery object (circular reference)
+		DataTable.$ =3D $;
+=09=09
+		// Legacy aliases
+		$.fn.dataTableSettings =3D DataTable.settings;
+		$.fn.dataTableExt =3D DataTable.ext;
+=09=09
+		// With a capital `D` we return a DataTables API instance rather than a
+		// jQuery object
+		$.fn.DataTable =3D function ( opts ) {
+			return $(this).dataTable( opts ).api();
+		};
+=09=09
+		// All properties that are available to $.fn.dataTable should also be
+		// available on $.fn.DataTable
+		$.each( DataTable, function ( prop, val ) {
+			$.fn.DataTable[ prop ] =3D val;
+		} );
+=09
+		return DataTable;
+}));
diff --git a/lib/toaster/toastergui/templates/command_line_builds.html b/li=
b/toaster/toastergui/templates/command_line_builds.html
index d6ff685c..25a5e806 100644
--- a/lib/toaster/toastergui/templates/command_line_builds.html
+++ b/lib/toaster/toastergui/templates/command_line_builds.html
@@ -1,6 +1,7 @@
 {% extends "base.html" %}
 {% load projecttags %}
 {% load humanize %}
+{% load static %}
=20
 {% block title %} Import Builds from eventlogs - Toaster {% endblock %}
=20
@@ -68,7 +69,7 @@
                     </h4>
                     {% if files %}
                     <div class=3D"table-responsive">
-                        <table class=3D"table col-md-6 table-bordered tabl=
e-hover">
+                        <table class=3D"table col-md-6 table-bordered tabl=
e-hover" id=3D"eventlog-table" style=3D"border-collapse: collapse;">
                             <thead>
                             <tr class=3D"row">
                                 <th scope=3D"col">Name</th>
@@ -112,6 +113,8 @@
     </div>
 </div>
=20
+<link rel=3D"stylesheet" href=3D"{% static 'css/jquery.dataTables-1.11.5.c=
ss' %}" type=3D'text/css'/>
+<script src=3D"{% static 'js/jquery.dataTables-1.11.5.js' %}"> </script>
 <script>
=20
 function _ajax_update(file, all, dir){
@@ -193,6 +196,10 @@ $( "#form_file").on( "submit", function( event ) {
         }, 10000)
 });
=20
+$(document).ready( function () {
+    $('#eventlog-table').DataTable();
+});
+
 </script>
=20
 {% endblock %}
--=20
2.34.1


