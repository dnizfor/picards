import * as SQLite from "expo-sqlite";

const db = SQLite.openDatabaseSync("dbName");

const createTable = () => {
  db.transaction((tx) => {
    tx.executeSql(
      `CREATE TABLE IF NOT EXISTS deck_list (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          deck_id INTEGER,
          deck_name TEXT,
          url TEXT
        );`,
      [],
      () => {
        console.log("Tablo başarıyla oluşturuldu.");
      },
      (error) => {
        console.log("Tablo oluşturma hatası:", error);
      }
    );
  });
  db.transaction((tx) => {
    tx.executeSql(
      `CREATE TABLE IF NOT EXISTS video_list (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT,
        video_id INTEGER,
        video_url TEXT,
        word_id INTEGER
      );`,
      [],
      () => {
        console.log("Tablo başarıyla oluşturuldu.");
      },
      (error) => {
        console.log("Tablo oluşturma hatası:", error);
      }
    );
  });
  db.transaction((tx) => {
    tx.executeSql(
      `CREATE TABLE IF NOT EXISTS vocabulary_list (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        mean TEXT,
        deck_id INTEGER,
        word_id INTEGER,
        word_name TEXT
      );`,
      [],
      () => {
        console.log("Tablo başarıyla oluşturuldu.");
      },
      (error) => {
        console.log("Tablo oluşturma hatası:", error);
      }
    );
  });
};

export const initializeDatabase = () => {
  // Veritabanını oluşturma veya açma işlemi
  db.transaction((tx) => {
    tx.executeSql(
      "PRAGMA foreign_keys=ON;",
      [],
      () => {
        console.log("Foreign key desteği etkinleştirildi.");
      },
      (error) => {
        console.log("Foreign key desteği etkinleştirme hatası:", error);
      }
    );
  });

  // Tabloyu oluşturma
  createTable();
};

export const insertData = (tableName, data) => {
  return new Promise((resolve, reject) => {
    db.transaction((tx) => {
      tx.executeSql(
        `INSERT INTO ${tableName} (${Object.keys(data).join(
          ", "
        )}) VALUES (${Object.keys(data).fill("?").join(", ")});`,
        Object.values(data),
        (_, result) => {
          console.log("Veri eklendi:", result);
          resolve(result); // İşlem başarılı olduğunda resolve ile result değerini döndür
        },
        (error) => {
          console.log("Veri ekleme hatası:", error);
          reject(error); // Hata durumunda reject ile error değerini döndür
        }
      );
    });
  });
};

// Veri silme fonksiyonu
export const deleteData = (tableName, condition) => {
  db.transaction((tx) => {
    tx.executeSql(
      `DELETE FROM ${tableName} WHERE ${condition};`,
      [],
      (_, result) => {
        console.log("Veri silindi:", result);
      },
      (error) => {
        console.log("Veri silme hatası:", error);
      }
    );
  });
};

// Veri güncelleme fonksiyonu
export const updateData = (tableName, newData, condition) => {
  db.transaction((tx) => {
    tx.executeSql(
      `UPDATE ${tableName} SET ${Object.keys(newData)
        .map((key) => `${key} = ?`)
        .join(", ")} WHERE ${condition};`,
      Object.values(newData),
      (_, result) => {
        console.log("Veri güncellendi:", result);
      },
      (error) => {
        console.log("Veri güncelleme hatası:", error);
      }
    );
  });
};

export const selectData = (tableName, columns, condition) => {
  return new Promise((resolve, reject) => {
    const columnNames = columns.join(", ");

    db.transaction((tx) => {
      tx.executeSql(
        `SELECT ${columnNames} FROM ${tableName} WHERE ${condition};`,
        [],
        (_, result) => {
          console.log("Veri seçildi:", result);
          resolve(result); // İşlem başarılı olduğunda resolve ile result değerini döndür
        },
        (error) => {
          console.log("Veri seçme hatası:", error);
          reject(error); // Hata durumunda reject ile error değerini döndür
        }
      );
    });
  });
};
