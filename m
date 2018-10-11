Return-Path: <TOl@hms.se>
X-Greylist: delayed 24295 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 12 Oct 2018 05:08:15 UTC
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
	(mail-eopbgr20074.outbound.protection.outlook.com [40.107.2.74])
	by mail.openembedded.org (Postfix) with ESMTP id 0F1A56079E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Oct 2018 05:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms.se; s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=vSiv74ZjI8eV33I8z9ShvJISYfLEgLyBL6iguW7JAak=;
	b=zGlUQ+PSTFNiD9+6ATTKuUJZ3X0XIS5Qzubsd5ovgOwkJvJgi4ouKW4+wccS1Qs5DqUJKEVipBZ0FWj872CimJmTokNz6HDNujYugatyn6tLYEw5uh4wah5tGZ0RxalqFcv40boHMGqeV4OarJ5eQCP6YabKP6lEV7T9r5Zw8c0=
Received: from HE1PR1001MB1052.EURPRD10.PROD.OUTLOOK.COM (10.168.130.11) by
	HE1PR1001MB1049.EURPRD10.PROD.OUTLOOK.COM (10.168.130.8) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1228.21; Thu, 11 Oct 2018 13:50:25 +0000
Received: from HE1PR1001MB1052.EURPRD10.PROD.OUTLOOK.COM
	([fe80::80b5:60fe:8a6b:8c68]) by
	HE1PR1001MB1052.EURPRD10.PROD.OUTLOOK.COM
	([fe80::80b5:60fe:8a6b:8c68%10]) with mapi id 15.20.1228.020;
	Thu, 11 Oct 2018 13:50:25 +0000
From: Tobias Olausson <TOl@hms.se>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] taskexp: add focused search bar
Thread-Index: AQHUYWj9ra3rrgwhCEeysWTJHwpr7g==
Date: Thu, 11 Oct 2018 13:50:25 +0000
Message-ID: <HE1PR1001MB105271915A687C4730AAA357C3E10@HE1PR1001MB1052.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=TOl@hms.se; 
x-originating-ip: [88.131.56.168]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR1001MB1049;
	6:VAh6KeS116kuvCEoSoACcXL+nUPCbbnw9LxHcgUdPGZO4w/j5+qAtBQDBXbE4g92GlcIjSBwf5XcgRGQQS0uDSZ1jetbwwzktwQJlMN0vKNN32DFOSvZ0G9JIphrWeGtmDBxvFQyY72f093ACfmMzZu7md6B3fJZoUjx26oJTbKVg/3ql2aflXs7XuyyfmiprSfScQ90vhkQdvPwfPw3zbwHOwHQxgue8XdyfK+3XrtwFKNOQMkzG6LnQDZPYfbvyvgyVfLKJQ0XFWXriYUliWZ3EQTwszrfrUGZjT8f1JNPMn+dyF1LQaTKcotEzTWYmkipseI7fd5Rfj4/4sO0xutyxhqcpfmCzhAsgDQHenXNu+aYhRRoO081Y3zk9kT/PgTWlaqboAJYLwqMfw1PyJ10il/jeTSJEt1hKA2iULVaq0bwbJuWGVhrMI/hupXsOuskCGhGnlLvirENx9CGlg==;
	5:1oowAJHpZneeKsTppv1KeFyw43owk7oc7t0QxIZqJ42Hh2/I+fxGxZk2t2t/vkYMz8wDXcX/hvoW60j/fRID6nPwOe0/x28jzg4neQhHsUKnGaw3jeCgAc08cIzJql/4H11p2xLyDfd88s7WLCTcFpCVXooLqeTpOHfBT37f3Rg=;
	7:FXOXhIVXCAkUzn9QXk8AKXtGRyGnFU3l5mOWlXAtOuWf6pPNcL2DcUqacB/mtmeR3DWINjhnw4DYxdHRK0PqAO4M0kQc5qjWuy5/w+8YetCxKHI7mLocPL5Wki3jQ0Fl4b1xNlN6gpX616aRGqYPtfZCUp0I2OKuDtKu6Hob/swoBvR9OdgmHLSV6jfGYod4bZhoI8g9s/S7/7Wl5/Tt8anxpTB687LObdlv+M44ajW7z+/XKWrt1tSl5m0+Wngn
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: dd586332-c98a-4f3a-7581-08d62f807f34
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:HE1PR1001MB1049; 
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1049:|HE1PR1001MB1049:
x-microsoft-antispam-prvs: <HE1PR1001MB1049B9473E6364BE3F849E30C3E10@HE1PR1001MB1049.EURPRD10.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(21532816269658);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051);
	SRVR:HE1PR1001MB1049; BCL:0; PCL:0; RULEID:;
	SRVR:HE1PR1001MB1049; 
x-forefront-prvs: 08220FA8D6
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(366004)(346002)(396003)(39850400004)(136003)(376002)(199004)(189003)(1857600001)(26005)(316002)(186003)(6916009)(74482002)(72206003)(3846002)(6116002)(8936002)(6506007)(14444005)(478600001)(256004)(53546011)(86362001)(486006)(14454004)(476003)(97736004)(5640700003)(99286004)(53936002)(55016002)(6436002)(305945005)(25786009)(7696005)(5250100002)(102836004)(71200400001)(71190400001)(2501003)(9686003)(33656002)(74316002)(5660300001)(2900100001)(81156014)(81166006)(8676002)(106356001)(7736002)(105586002)(66066001)(68736007)(2906002)(2351001)(42262002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR1001MB1049;
	H:HE1PR1001MB1052.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: hms.se does not designate
	permitted sender hosts)
x-microsoft-antispam-message-info: D/g8uo8AMS0sI56yCZPUwWSlBm3PnGaNYuxC9hsojVHHkwqlx+XeDT3kBIb5Pf32FLucU4/9vUcI6mWeRcB4Xt9A3+m7DtKDC0meLhtatCt+9ibuzYbHK8gTkqBzeqpdhe/LGyhytGbufUTRP4lgJgstzsbLdAoULOpUs2TebuHMjXBDJ8ZxNrkm5XodSeKRL+4BMdTdCHg9vXMX1xTGraq5s+n5KYKCDhv5eHHjE1iTgSx3ABYFhQBWpkgXHNnb6zVGbL/1Fv64MkM8opumLLTtpN1MKKYOO/CrIj5cyPsbEdjB5lbZqsZIJj9+/XRh2aVVV1f1/fXvnT83zU1QgqjzJLwe3m7ztUN9dg7GYTY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dd586332-c98a-4f3a-7581-08d62f807f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2018 13:50:25.4596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1049
X-Microsoft-Exchange-Diagnostics: 1; HE1PR1001MB1049;
	23:WzzAgJqLnHOYFMrz5Map8ZvE0klef8R/1jMmBzYXM/ZlCUJzml6O49k7OiUk5bypiczLY+/oK8dXR+hrmM0IaB811qmcUuzf+3QR4dnqhR+3zCXeLk19OVIeaxoZcJmUQllni/5aaoFIla4QqmgdcA==
X-OriginatorOrg: hms.se
Subject: [PATCH] taskexp: add focused search bar
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 12 Oct 2018 05:08:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From 4f5f83161fcb7bd4e3d6b46ac13fa10ba5d50091 Mon Sep 17 00:00:00 2001
From: Tobias Olausson <tol@hms.se>
Date: Thu, 11 Oct 2018 15:29:49 +0200
Subject: [PATCH] taskexp: add focused search bar

Searching in the task explorer requires one to focus the task list. A
readily visible and focused search bar makes searching intuitive.

Signed-off-by: Tobias Olausson <tol@hms.se>
---
 lib/bb/ui/taskexp.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 0e8e9d4c..8305d70f 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -103,9 +103,16 @@ class DepExplorer(Gtk.Window):
         self.pkg_treeview.get_selection().connect("changed", self.on_curso=
r_changed)
         column =3D Gtk.TreeViewColumn("Package", Gtk.CellRendererText(), t=
ext=3DCOL_PKG_NAME)
         self.pkg_treeview.append_column(column)
-        pane.add1(scrolled)
         scrolled.add(self.pkg_treeview)
=20
+        self.search_entry =3D Gtk.SearchEntry.new()
+        self.pkg_treeview.set_search_entry(self.search_entry)
+
+        left_panel =3D Gtk.VPaned()
+        left_panel.add(self.search_entry)
+        left_panel.add(scrolled)
+        pane.add1(left_panel)
+
         box =3D Gtk.VBox(homogeneous=3DTrue, spacing=3D4)
=20
         # Task Depends
@@ -129,6 +136,7 @@ class DepExplorer(Gtk.Window):
         pane.add2(box)
=20
         self.show_all()
+        self.search_entry.grab_focus()
=20
     def on_package_activated(self, treeview, path, column, data_col):
         model =3D treeview.get_model()
--=20
2.17.1

